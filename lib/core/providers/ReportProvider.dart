import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ui/pages/editRecordPage.dart';
import '../../utils/dateTimeUtil.dart';
import '../models/Summary.dart';
import '../services/SummaryService.dart';

class ReportProvider with ChangeNotifier {
  final SummaryService summaryService;
  String? dateShow;
  DateTimeRange? dateRange;
  String? chatControl;
  // List<String> columns = ['count', 'totalTime',  'interval'];
  String column = 'count';
  bool isWeekly;

  List<Summary> summaryDayList = [];
  Map<String, double> maxBarValue = {
    'count': 0.0,
    'totalTime': 0.0,
    'interval': 0.0,
  };

  // void setIsWeekly(bool value) {
  //   print(value) ;
  //   isWeekly = value;
  // }

  ReportProvider({required this.isWeekly, required BuildContext context})
      : summaryService = Provider.of<SummaryService>(context) {
    loadData(isWeek: isWeekly);
  }

  void setIsWeekly(bool value) {
    isWeekly = value;
    notifyListeners();
  }

  Future<void> loadData({DateTimeRange? picked, bool? isWeek}) async {
    isWeek = isWeek ?? false;
    DateTime now = DateTime.now();
    if (picked != null) {
      dateRange = picked;
    } else if (isWeek) {
      dateRange = DateTimeRange(
        start: now.subtract(const Duration(days: 9 * 7)), // 找9週前的第一天
        end: now, // 找當中的最後一天
      );
    } else {
      dateRange = DateTimeRange(
        start: now.subtract(const Duration(days: 9)), //
        end: now, //
      );
    }

    summaryDayList = await summaryService.getSummaryList(dateRange!, isWeek);

    _calculateMaxBarValue();
    dateShow =
        '${DateTimeUtil.getDate(dateRange!.start)} ~ ${DateTimeUtil.getDate(dateRange!.end)}';

    notifyListeners();
    isWeekly = isWeek ?? false;
  }

  void _calculateMaxBarValue() {
    for (String column in maxBarValue.keys) {
      for (int i = 0; i < summaryDayList!.length; i++) {
        final data = summaryDayList![i].toMinuteMap();
        maxBarValue[column] = max(
            maxBarValue[column] ?? 0,
            column == 'interval'
                ? (data[column] / data['intervalCount'])
                : data[column].toDouble());
      }
      maxBarValue[column] = (maxBarValue[column]! / 10) < 1
          ? 15
          : (maxBarValue[column]! / 10).ceilToDouble() * 10 + 10;
    }
  }

  void changColumn(String? newValue) {
    column = newValue!;
    loadData();
  }

  void onNavigateToEditPage(context, item) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditSomkingPage(status: item),
      ),
    );
    notifyListeners();
  }
}
