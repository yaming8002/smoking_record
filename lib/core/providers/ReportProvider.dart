import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ui/pages/editRecordPage.dart';
import '../../utils/dateTimeUtil.dart';
import '../models/summaryDay.dart';
import '../services/SummaryService.dart';

class ReportProvider with ChangeNotifier {
  final SummaryService summaryService;
  String? dateShow;
  DateTimeRange? dateRange;
  String? chatControl;
  List<String> columns = ['count', 'evaluate', 'avgTime', 'spacing'];
  String column = 'count';

  List<SummaryDay> summaryDayList = [];
  double maxBarValue = 0.0;

  ReportProvider(BuildContext context)
      : summaryService = Provider.of<SummaryService>(context) {
    loadData();
  }

  Future<void> loadData([DateTimeRange? picked]) async {
    if (picked != null) {
      dateRange = picked;
    } else {
      dateRange = DateTimeRange(
        start: DateTime.now().subtract(const Duration(days: 10)), // 星期一
        end: DateTime.now(), // 星期日
      );
    }
    summaryDayList = await summaryService.getSummaryDayList(dateRange!);
    dateShow =
        '${DateTimeUtil.getDate(dateRange!.start)} ~ ${DateTimeUtil.getDate(dateRange!.end)}';
    _calculateMaxBarValue();
    notifyListeners();
  }

  void _calculateMaxBarValue() {
    maxBarValue = 0.0;
    for (int i = 0; i < summaryDayList!.length; i++) {
      final data = summaryDayList![i].toMap();
      maxBarValue = maxBarValue > data[column].toDouble()
          ? maxBarValue
          : data[column].toDouble();
    }
    maxBarValue = (maxBarValue / 10) < 1
        ? 15
        : (maxBarValue / 10).ceilToDouble() * 10 + 10;
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
