import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import '../../../core/models/Summary.dart';

class ReportChatWidget extends StatefulWidget {
  final List<Summary>? summaryDayList;
  final String? column; // count, totalTime, interval, or null for all
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
  GlobalKey _chartKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (widget.column == null || widget.column == 'all') {
      currentColumn = ['count', 'totalTime', 'interval'];
    } else {
      currentColumn = [widget.column!];
    }
  }

  Future<Uint8List?> captureChart() async {
    try {
      RenderRepaintBoundary boundary =
          _chartKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      print(e);
      return null;
    }
  }

  void calculateShowLine() {
    double maxValue = getChartMaxValue();

    if (maxValue < 10.0) {
      showLine = 2.0;
    } else if (maxValue < 50.0) {
      showLine = 5.0;
    } else if (maxValue < 100.0) {
      showLine = 10.0;
    } else if (maxValue < 200.0) {
      showLine = 20.0;
    } else if (maxValue < 500.0) {
      showLine = 50.0;
    } else if (maxValue < 1000.0) {
      showLine = 100.0;
    } else if (maxValue < 2000.0) {
      showLine = 200.0;
    } else {
      showLine = pow(10, (log(maxValue) / ln10).floor() - 1).toDouble();
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
      if (currentColumn.contains("interval")) {
        rods.add(BarChartRodData(
          toY: max(0, (data['interval'] / data['intervalCount'])),
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
    double additionalWidthForYAxis = 50; // 增加的宽度基于Y轴的最大值
    double calculatedWidth =
        widget.summaryDayList!.length * 20.0 * currentColumn.length +
            additionalWidthForYAxis;

    double containerWidth =
        calculatedWidth < screenWidth ? screenWidth : calculatedWidth;
    calculateShowLine();
    return Stack(children: <Widget>[
      Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: containerWidth,
                child: Container(
                  padding: const EdgeInsets.only(top: 55, bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: RepaintBoundary(
                      key: _chartKey,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: getChartMaxValue(),
                          barTouchData: BarTouchData(
                            enabled: true,
                            touchTooltipData: BarTouchTooltipData(
                              tooltipBgColor: Colors.amber, // 您可以根据需要更改这里的颜色
                              getTooltipItem: (BarChartGroupData group,
                                  int groupIndex,
                                  BarChartRodData rod,
                                  int rodIndex) {
                                // 获取日期
                                String date = widget
                                    .summaryDayList![group.x.toInt()].sDate;

                                // 获取数值，并转换为字符串
                                double value = rod.toY;
                                String label = '';
                                if (rodIndex < currentColumn.length) {
                                  label = currentColumn[rodIndex];
                                }
                                // 返回一个工具提示项，其中包含日期和数值，每个占一行
                                return BarTooltipItem(
                                  '$date\n$label:${value.floor()}', // 这里将日期和数值分成两行
                                  TextStyle(
                                    color: Colors.white, // 文本颜色
                                    fontSize: 12, // 减小字体大小
                                  ),
                                );
                              },
                            ),
                          ),
                          titlesData: const FlTitlesData(
                            show: true,
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 60, // 这里设置Y轴标题的宽度
                              ),
                            ),
                            rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            bottomTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
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
                      )),
                ),
              ),
            ),
          ),
        ],
      )
    ]);
  }
}
