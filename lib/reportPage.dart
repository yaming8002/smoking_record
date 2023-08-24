import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sqflite/sqflite.dart';

import 'databace/DatabaseHelper.dart';
import 'databace/summaryDay.dart';

class ReportPage extends StatefulWidget {
  String dropdownValue;

  ReportPage({super.key, required this.dropdownValue});

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  late DateTimeRange dateRange;
  Database? db;
  String dropdownValue = '';

  List<summaryDay> _summaryDayList = [];

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.dropdownValue;
    dateRange = DateTimeRange(
      start: DateTime.now()
          .subtract(Duration(days: DateTime.now().weekday - 1)), // 星期一
      end:
          DateTime.now().add(Duration(days: 7 - DateTime.now().weekday)), // 星期日
    );
    _loadDB().then((_) {
      _loadData();
    });
  }

  _loadDB() async {
    db = await DBHelper.database;
  }

  _loadData() async {
    if (db == null) return; // 確保db已初始化
    String startDate = dateRange.start.toIso8601String().substring(0, 10);
    String endDate = dateRange.end.toIso8601String().substring(0, 10);

    List<Map<String, dynamic>> list = await db!.rawQuery(
        'SELECT * from summaryDay where sDate between ? and ?',
        [startDate, endDate]);

    _summaryDayList = list.map((item) => summaryDay.fromMap(item)).toList();
    _summaryDayList.forEach((element) {
      print(element.toString());
    });
    setState(() {});
  }

  // _loadDataBySmokingStatus() async {
  //   DateTime startDate =
  //   DateTime.parse(_selectedDate + ' ' + AppSettings.getTimeChange());
  //   DateTime endDate = startDate.add(Duration(days: 1));
  //
  //
  //   int offset = _currentPage * _itemsPerPage; // 計算偏移量
  //   List<Map<String, dynamic>> list = await db!.rawQuery(
  //       'SELECT * from SmokingStatus where startTime >= ? AND endTime < ? LIMIT ? OFFSET ?',
  //       [startDate.toIso8601String(), endDate.toIso8601String(), _itemsPerPage, offset]);
  //
  //   _smokingList = list.map((item) => SmokingStatus.fromMap(item)).toList();
  //   setState(() {});
  // }
  double _formatDuration(Duration d) {
    int minutes = d.inMinutes ;
    print( minutes) ;
    return minutes/60;
  }

  List<BarChartGroupData> generateBarGroups() {
    List<BarChartGroupData> barGroups = [];
    for (int i = 0; i < _summaryDayList.length; i++) {
      final data = _summaryDayList[i];
      print(data.count) ;
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: data.count.toDouble(), // 假設 count 是 int，需要轉為 double
              color: Colors.red,
            ),
            BarChartRodData(
              toY:  data.evaluate, // 假設 count 是 int，需要轉為 double
              color: Colors.amber,
            ),
            BarChartRodData(
              toY: data.avgTime.inMinutes.toDouble(), // 假設 count 是 int，需要轉為 double
              color: Colors.orangeAccent,
            ),
            BarChartRodData(
              toY: data.spacing.inMinutes.toDouble(), // 假設 count 是 int，需要轉為 double
              color: Colors.green,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
      );

    }
    return barGroups;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Smoking Report')),
      body: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                  final picked = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    initialDateRange: dateRange,
                  );
                  if (picked != null) {
                    setState(() {
                      dateRange = picked;
                      _loadData();
                    });
                  }
                },
                child: Text('Pick Date Range'),
              ),
              SizedBox(width: 10),
              DropdownButton<String>(
                value: dropdownValue,
                onChanged: (value) {
                  setState(() {
                    dropdownValue = value ?? '一週';
                    _loadData();
                  });
                },
                items: <String>['單日', '一週', '一個月']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          Expanded(
              child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 200,
              // 根據您的數據範圍調整
              barTouchData: BarTouchData(
                enabled: false,
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      int index = value.toInt();
                      if (index >= 0 && index < _summaryDayList.length) {
                        return Text(_summaryDayList[index]
                            .sDate); // 假設 sDate 是日期的字符串表示形式
                      }
                      return Text('');
                    },
                  ),
                ),

              ),

              borderData: FlBorderData(

                show: true,
                border: Border.all(

                  color: const Color(0xff37434d),
                  width: 1,
                ),


              ),
              barGroups: generateBarGroups(),
            ),
          )),
          Expanded(

            child: ListView.builder(
              itemCount: _summaryDayList.length,
              itemBuilder: (context, index) {
                final data = _summaryDayList[index];
                return ListTile(
                  title: Text(data.sDate),
                  subtitle: Table(
                    children: [
                      TableRow(children: [
                        Text('總數吸菸數: ${data.count}'),
                        Text('總計抽菸時間: ${data.totalTime.inMinutes}分鐘'),
                      ]),
                      TableRow(children: [
                        Text('平均時間間隔:  ${data.spacing.inMinutes}分鐘'),
                        Text('平均吸菸間隔時間: ${data.avgTime.inMinutes}分鐘'),
                      ]),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
