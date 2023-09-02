import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../core/models/summaryDay.dart';

class ReportChatWidget extends StatefulWidget {
  final List<SummaryDay>? summaryDayList;
  final String? column;
  final double maxBarValue;

  const ReportChatWidget(
      {Key? key,
      required this.summaryDayList,
      required this.column,
      required this.maxBarValue})
      : super(key: key);

  @override
  _ReportChatWidget createState() => _ReportChatWidget();
}

class _ReportChatWidget extends State<ReportChatWidget> {
  List<BarChartGroupData> generateBarGroups() {
    List<BarChartGroupData> barGroups = [];
    for (int i = 0; i < widget.summaryDayList!.length; i++) {
      final data = widget.summaryDayList![i].toMap();

      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: data[widget.column].toDouble(), // 假設 count 是 int，需要轉為 double
              color: Colors.red,
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
    double screenWidth = MediaQuery.of(context).size.width;
    double calculatedWidth = widget.summaryDayList!.length * 40.0;
    double containerWidth =
        calculatedWidth < screenWidth ? screenWidth : calculatedWidth;
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          // 設定一個適當的寬度，以便能夠滑動。
          // 這裡我假設每個 bar group 的寬度為 60，您可以根據需要調整。
          width: containerWidth,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: widget.maxBarValue,
              // 根據您的數據範圍調整
              barTouchData: BarTouchData(
                enabled: false,
              ),
              titlesData: FlTitlesData(
                show: true,
                topTitles: const AxisTitles(
                    sideTitles: SideTitles(
                        reservedSize: 30, showTitles: false)), // 隐藏顶部的标题
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      int index = value.toInt();
                      if (index >= 0 && index < widget.summaryDayList!.length) {
                        return Text(widget.summaryDayList![index].sDate
                            .substring(5)); // 假設 sDate 是日期的字符串表示形式
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
          ),
        ),
      ),
    );
  }
}
