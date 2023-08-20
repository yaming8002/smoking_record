import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smoking_record/settingPage.dart';
import 'package:sqflite/sqflite.dart';

import 'databace/SmokingStatus.dart';
import 'editRecordPage.dart';

class SmokingListPage extends StatefulWidget {
  final Database database;

  SmokingListPage({super.key, required this.database});

  @override
  _SmokingListPageState createState() => _SmokingListPageState();
}

class _SmokingListPageState extends State<SmokingListPage> {
  Database? db;
  List<String> _dateList = [];
  List<SmokingStatus> _smokingList = [];
  String _selectedDate = '';
  int _currentPage = 0; // 新增變數來跟踪當前的頁碼
  final int _itemsPerPage = 10; // 每頁的項目數量

  @override
  void initState() {
    super.initState();
    db = widget.database;
    _selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now()); // Initialize _selectedDate here
    _dateList.add(_selectedDate);
    _loadDropdownButton().then((_) {
      _loadData();
    });
  }

  _loadDropdownButton() async {
    String sql = 'SELECT sDate FROM summaryDay';

    List<Map<String, dynamic>> records = await db!.rawQuery(sql, null);
    for (var record in records) {
      if (!_dateList.contains(record['sDate'])) {
        _dateList.add(record['sDate']);
      }
    }
    setState(() {});
  }

  _loadData() async {
    print(_dateList[0]) ;
    DateTime startDate =
      DateTime.parse(_selectedDate + ' ' + AppSettings.getTimeChange());
    DateTime endDate = startDate.add(Duration(days: 1));


    int offset = _currentPage * _itemsPerPage; // 計算偏移量
    print(offset) ;
    print(_currentPage) ;
    print(_itemsPerPage) ;
    List<Map<String, dynamic>> list = await db!.rawQuery(
        'SELECT * from SmokingStatus where startTime >= ? AND endTime < ? LIMIT ? OFFSET ?',
        [startDate.toIso8601String(), endDate.toIso8601String(), _itemsPerPage, offset]);

    _smokingList = list.map((item) => SmokingStatus.fromMap(item)).toList();
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Smoking List'),
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            value: _dateList.contains(_selectedDate) ? _selectedDate : null,
            onChanged: (value) {
              setState(() {
                print( "------------------") ;
                print( value) ;
                _selectedDate = value!;
                print( _selectedDate) ;
                _loadData();
              });
            },
            items: _dateList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Table(
                border: TableBorder.all(),
                columnWidths: {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(2),
                  3: FlexColumnWidth(2),
                  4: FlexColumnWidth(1),
                },
                children: [
                  TableRow(
                    children: [
                      Center(child: Text('Edit')),
                      Center(child: Text('吸菸數量')),
                      Center(child: Text('開始時間')),
                      Center(child: Text('結束時間')),
                      Center(child: Text('感受評分')),
                    ],
                  ),
                  ..._smokingList.map((item) {
                    return TableRow(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditSomkingPage(status: item)),
                            );
                          },
                        ),
                        Center(child: Text('${item.count}')),
                        Center(child: Text('${item.startTime}')),
                        Center(child: Text('${item.endTime}')),
                        Center(child: Text('${item.evaluate}')),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                child: Text('Previous'),
                onPressed: () {
                  if (_currentPage > 0) {
                    _currentPage--;
                    _loadData();
                  }
                },
              ),
              ElevatedButton(
                child: Text('Next'),
                onPressed: () {
                  _currentPage++;
                  _loadData();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}






