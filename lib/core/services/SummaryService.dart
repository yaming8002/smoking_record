import 'package:flutter/material.dart';

import '../models/summaryDay.dart';
import 'AppSettingService.dart';
import 'DatabaseManager.dart';

class SummaryService {
  final DatabaseManager databaseManager;

  SummaryService(this.databaseManager);

  // Future<DateTime?> getLastEndTime() async {
  //   final maps = await databaseManager?.rawQuery(
  //       "SELECT endTime FROM SmokingStatus ORDER BY endTime DESC LIMIT 1");
  //
  //   if (maps != null && maps.isNotEmpty) {
  //     final formattedEndTime =
  //         DateTimeUtil.StrDateByformat((maps.first['endTime'] as String?));
  //     String now = DateTimeUtil.getDate();
  //     final timeChange = '$now ${AppSettings.getTimeChange()}';
  //
  //     if (formattedEndTime != null &&
  //         formattedEndTime.compareTo(timeChange) >= 0) {
  //       return DateTime.parse(formattedEndTime);
  //     }
  //   }
  //   return null;
  // }

  Future<List<SummaryDay>> getSummaryDayList(DateTimeRange dateRange) async {
    String startDate = dateRange.start.toIso8601String().substring(0, 10);
    String endDate = dateRange.end.toIso8601String().substring(0, 10);

    List<Map<String, dynamic>> queryResult = await databaseManager!.rawQuery(
        'SELECT * from summaryDay where sDate between ? and ?',
        [startDate, endDate]);
    List<SummaryDay> list =
        queryResult.map((item) => SummaryDay.fromMap(item)).toList();
    return list;
  }

  Future<void> insertOrUpdateSummaryDay(SummaryDay day) async {
    await databaseManager.insert(
      'summary_days',
      day.toMap(),
    );
  }

  Future<void> updateSummaryDay(String date) async {
    String timeChange = AppSettingService.getTimeChange();
    DateTime startDateTime = DateTime.parse('$date $timeChange');
    DateTime endDateTime = startDateTime.add(Duration(days: 1));

    String sql = '''SELECT
      ? as sDate, 
      SUM(count) as count, 
      count(*) as frequency,
      SUM(totalTime) as totalTime, 
      CAST(avg(totalTime) AS INTEGER) as avgTime,
      CAST(avg(spacing) AS INTEGER)  as spacing,
      CAST(avg(evaluate) AS INTEGER)  as evaluate
      FROM SmokingStatus 
      WHERE endTime > ? and endTime < ?'''; // 注意這裡的結束括號

    List<dynamic> arguments = [
      date,
      startDateTime.toString(),
      endDateTime.toString()
    ];

    List<Map<String, dynamic>>? records =
        await databaseManager.rawQuery(sql, arguments);
    // summaryDay today = summaryDay.fromMap(records[0]);
    await databaseManager.insertorReplace('summaryDay', records[0]);
  }
}
