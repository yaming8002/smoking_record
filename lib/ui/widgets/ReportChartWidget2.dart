import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../core/models/summaryDay.dart';

class ReportChatWidget2 extends StatefulWidget {
  final List<SummaryDay>? summaryDayList;

  const ReportChatWidget2({Key? key, required this.summaryDayList})
      : super(key: key);

  @override
  _ReportChatWidget2 createState() => _ReportChatWidget2();
}
//
// class _ReportChatWidget extends State<ReportChatWidget> {
//   List<BarChartGroupData> generateBarGroups() {
//     List<BarChartGroupData> barGroups = [];
//     for (int i = 0; i < widget.summaryDayList!.length; i++) {
//       final data = widget.summaryDayList![i];
//       barGroups.add(
//         BarChartGroupData(
//           x: i,
//           barRods: [
//             BarChartRodData(
//               toY: data.count.toDouble(), // 假設 count 是 int，需要轉為 double
//               color: Colors.red,
//             ),
//             BarChartRodData(
//               toY: data.evaluate, // 假設 count 是 int，需要轉為 double
//               color: Colors.amber,
//             ),
//             BarChartRodData(
//               toY: data.avgTime.inMinutes
//                   .toDouble(), // 假設 count 是 int，需要轉為 double
//               color: Colors.orangeAccent,
//             ),
//             BarChartRodData(
//               toY: data.spacing.inMinutes
//                   .toDouble(), // 假設 count 是 int，需要轉為 double
//               color: Colors.green,
//             ),
//           ],
//           showingTooltipIndicators: [0],
//         ),
//       );
//     }
//     return barGroups;
//   }

class _ReportChatWidget2 extends State<ReportChatWidget2> {
  List<BarChartGroupData> generateBarGroups() {
    List<BarChartGroupData> barGroups = [];
    for (int i = 0; i < widget.summaryDayList!.length; i++) {
      final data = widget.summaryDayList![i];
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: data.count.toDouble(),
              color: Colors.red,
            ),
            BarChartRodData(
              toY: data.evaluate,
              color: Colors.amber,
            ),
            BarChartRodData(
              toY: data.avgTime.inMinutes.toDouble(),
              color: Colors.orangeAccent,
            ),
            BarChartRodData(
              toY: data.spacing.inMinutes.toDouble(),
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
    return Expanded(
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
    ));
  }
}
