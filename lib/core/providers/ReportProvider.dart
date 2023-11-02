import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smoking_record/core/services/AppSettingService.dart';

import '../../ui/pages/editRecordPage.dart';
import '../../utils/dateTimeUtil.dart';
import '../models/Summary.dart';
import '../services/SummaryService.dart';

class ReportProvider with ChangeNotifier {
  final SummaryService summaryService;
  String? dateShow;
  DateTimeRange? dateRange;
  String? chatControl;
  // List<String> columns = ['count', 'totalTime',  'spacing'];
  String column = 'count';
  bool isWeekly;

  List<Summary> summaryDayList = [];
  Map<String, double> maxBarValue = {
    'count': 0.0,
    'totalTime': 0.0,
    'spacing': 0.0,
  };

  // void setIsWeekly(bool value) {
  //   print(value) ;
  //   isWeekly = value;
  // }

  ReportProvider({required this.isWeekly, required BuildContext context})
      : summaryService = Provider.of<SummaryService>(context) {
    loadData(Week: isWeekly);
  }

  void setIsWeekly(bool value) {
    isWeekly = value;
    notifyListeners();
  }

  Future<void> loadData({DateTimeRange? picked, bool? Week}) async {
    Week = Week ?? false;
    DateTime now = DateTime.now();
    if (picked != null) {
      dateRange = picked;
    } else if (Week) {
      DateTime weekend =
          now.add(Duration(days: DateTime.sunday - now.weekday)); // 這週的週日
      weekend = AppSettingService.getIsWeekStartMonday()
          ? weekend.subtract(Duration(days: 1))
          : weekend;
      dateRange = DateTimeRange(
          start: weekend
              .subtract(const Duration(days: 7 * 10))
              .subtract(const Duration(days: 6)),
          end: weekend);
    } else {
      dateRange = DateTimeRange(
        start: now.subtract(const Duration(days: 9)), //
        end: now, //
      );
    }

    summaryDayList = await summaryService.getSummaryList(
        dateRange!, Week ? "SummaryWeek" : "SummaryDay");

    _calculateMaxBarValue();
    dateShow =
        '${DateTimeUtil.getDate(dateRange!.start)} ~ ${DateTimeUtil.getDate(dateRange!.end)}';

    notifyListeners();
    isWeekly = Week ?? false;
  }

  void _calculateMaxBarValue() {
    for (String column in maxBarValue.keys) {
      for (int i = 0; i < summaryDayList!.length; i++) {
        final data = summaryDayList![i].toMinuteMap();
        maxBarValue[column] = maxBarValue[column]! > data[column].toDouble()
            ? maxBarValue[column]
            : data[column].toDouble();
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
