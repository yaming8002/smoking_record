import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/models/Summary.dart';

class ReportChatWidget extends StatefulWidget {
  final List<Summary>? summaryDayList;
  final String? column; // count, totalTime, spacing, or null for all
  final Map<String, double> maxBarValue;

  const ReportChatWidget({
    Key? key,
    required this.summaryDayList,
    this.column,
    required this.maxBarValue,
  }) : super(key: key);

  @override
  _ReportChatWidget createState() => _ReportChatWidget();
}

class _ReportChatWidget extends State<ReportChatWidget> {
  late List<String> currentColumn;
  late double showLine;

  @override
  void initState() {
    super.initState();
    showLine = 20.0;
    if (widget.column == null || widget.column == 'all') {
      currentColumn = ['count', 'totalTime', 'spacing'];
    } else {
      currentColumn = [widget.column!];
      if (widget.column! == 'count') showLine = 5.0;
    }
  }

  List<BarChartGroupData> generateBarGroups() {
    List<BarChartGroupData> barGroups = [];
    for (int i = 0; i < widget.summaryDayList!.length; i++) {
      final data = widget.summaryDayList![i].toMinuteMap();

      List<BarChartRodData> rods = [];
      if (currentColumn.contains("count")) {
        rods.add(BarChartRodData(
          toY: data['count'].toDouble(),
          width: 15,
          color: Colors.red,
        ));
      }
      if (currentColumn.contains("totalTime")) {
        rods.add(BarChartRodData(
          toY: data['totalTime'].toDouble(),
          width: 15,
          color: Colors.amber,
        ));
      }
      if (currentColumn.contains("spacing")) {
        rods.add(BarChartRodData(
          toY: max(0, data['spacing'].toDouble()),
          width: 15,
          color: Colors.lightGreen,
        ));
      }

      barGroups.add(BarChartGroupData(x: i, barRods: rods));
    }
    return barGroups;
  }

  double getChartMaxValue() {
    if (widget.column == null || widget.column == 'all') {
      return widget.maxBarValue.values.reduce(max);
    } else {
      return widget.maxBarValue[widget.column!] ?? 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double calculatedWidth =
        widget.summaryDayList!.length * 20.0 * currentColumn.length;

    double containerWidth =
        calculatedWidth < screenWidth ? screenWidth : calculatedWidth;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: containerWidth,
              child: Container(
                padding: const EdgeInsets.only(top: 15, bottom: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: getChartMaxValue(),
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        direction: TooltipDirection.bottom,
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            int index = value.toInt();
                            if (index >= 0 &&
                                index < widget.summaryDayList!.length) {
                              return Transform.rotate(
                                origin: const Offset(11, 10),
                                angle: -45 * (pi / 180),
                                alignment: Alignment.center,
                                child: Text(widget.summaryDayList![index].sDate
                                    .substring(5)),
                              );
                            }
                            return const Text('');
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(
                        color: Colors.black87,
                        width: 1,
                      ),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawHorizontalLine: true,
                      horizontalInterval: showLine,

                      getDrawingHorizontalLine: (double value) {
                        return const FlLine(
                          color: Colors.black54, // 設定為黑色或其他您喜歡的顏色
                          strokeWidth: 1, // 設定線條寬度，可以根據需要調整
                          dashArray: [4, 2], // 添加這行
                        );
                      },
                      checkToShowHorizontalLine: (double value) {
                        return value % showLine == 0;
                      },
                      drawVerticalLine: false, // 不畫X軸的網格線
                    ),
                    barGroups: generateBarGroups(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
