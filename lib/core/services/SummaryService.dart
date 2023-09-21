import 'package:flutter/material.dart';

import '../../utils/dateTimeUtil.dart';
import '../models/summaryDay.dart';
import 'AppSettingService.dart';
import 'DatabaseManager.dart';

class SummaryService {
  final DatabaseManager databaseManager;
  TimeOfDay? changTime = AppSettingService.getTimeChangeToTimeOfDay();
  String? changTimeByStr = AppSettingService.getTimeChange();

  SummaryService(this.databaseManager);

  Future<SummaryDay> getDayTotalNum([String? todayStart]) async {
    todayStart ??= DateTimeUtil.getDate();

    String daySelect = '''SELECT * FROM SummaryDay WHERE sDate = ? ''';
    final dayTotalres =
        await databaseManager?.rawQuery(daySelect, [todayStart]);
    SummaryDay first = dayTotalres!.isNotEmpty
        ? SummaryDay.fromMap(dayTotalres![0])
        : SummaryDay(
            todayStart, 0, 0, Duration.zero, Duration.zero, Duration.zero, 0);

    return first;
  }

  Future<SummaryDay> getWeekTotalNum([DateTime? now]) async {
    now = now ?? DateTime.now();

    String todayStart = DateTimeUtil.getDate();
    List<String> rangeDate = DateTimeUtil.getWeekDateRange(now);
    for (int i = 0; i < rangeDate.length; i++) {
      rangeDate[i] = rangeDate[i].substring(0, 10);
    }

    String weekSelect = '''SELECT 
      '-' as sDate,
      SUM(count) as count, 
      SUM(frequency) as frequency,
      SUM(totalTime) as totalTime, 
      CAST(ROUND(avg(avgTime)) AS INT) as avgTime, 
      CAST(ROUND(avg(spacing)) AS INT) as spacing,
      CAST(ROUND(avg(evaluate)) AS INT) as evaluate
      FROM summaryDay WHERE sDate >= ? and sDate < ? ''';

    final weekTotalres = await databaseManager?.rawQuery(weekSelect, rangeDate);
    return SummaryDay.fromMap(weekTotalres![0]);
  }

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
    await databaseManager.insertorReplace(
      'SummaryDay',
      day.toMap(),
    );
  }

  Future<void> updateSummaryDay(String date) async {
    print(date);
    String sql = '''SELECT
      ? as sDate, 
      SUM(count) as count, 
      count(*) as frequency,
      SUM(totalTime) as totalTime, 
      CAST(avg(totalTime) AS INTEGER) as avgTime,
      CAST(avg(spacing) AS INTEGER)  as spacing,
      CAST(avg(evaluate) AS INTEGER)  as evaluate
      FROM SmokingStatus 
      WHERE endTime > ? and endTime < ? '''; // 注意這裡的結束括號

    List<dynamic> arguments =
        DateTimeUtil.updateSummaryDayArg(date, changTimeByStr!);

    List<Map<String, dynamic>>? records =
        await databaseManager.rawQuery(sql, arguments);
    // SummaryDay today = SummaryDay.fromMap(records[0]);
    await databaseManager.insertorReplace('SummaryDay', records[0]);
  }

  // DateTime _getGroupDate(DateTime dateTime, String changeTime) {
  //   final changeHour = int.parse(changeTime.split(':')[0]);
  //   final changeMinute = int.parse(changeTime.split(':')[1]);
  //
  //   final changeDateTime = DateTime(
  //     dateTime.year,
  //     dateTime.month,
  //     dateTime.day,
  //     changeHour,
  //     changeMinute,
  //   );
  //
  //   if (dateTime.isBefore(changeDateTime)) {
  //     return dateTime.subtract(Duration(days: 1));
  //   } else {
  //     return dateTime;
  //   }
  // }

  // SummaryDay _generateSummary(List<SmokingStatus> records, DateTime groupDate) {
  //   int totalCount = 0;
  //   int totalFrequency = 0;
  //   int totalTime = 0;
  //   int totalEvaluate = 0;
  //   List<int> spacings = [];
  //
  //   for (var record in records) {
  //     totalCount += record.count;
  //     totalTime += record.totalTime.inSeconds;
  //     totalEvaluate += record.evaluate;
  //     if (record.spacing != null) {
  //       spacings.add(record.spacing!.inSeconds);
  //     }
  //   }
  //
  //   spacings.sort();
  //   if (spacings.isNotEmpty) spacings.removeAt(0);
  //
  //   final avgSpacing = (spacings.isNotEmpty)
  //       ? (spacings.reduce((a, b) => a + b) / spacings.length).toInt()
  //       : null;
  //
  //   final avgTime = totalTime ~/ records.length;
  //   final avgEvaluate = totalEvaluate ~/ records.length;
  //
  //   return SummaryDay(
  //       groupDate.toIso8601String().substring(0, 10),
  //       totalCount,
  //       totalFrequency,
  //       Duration(seconds: totalTime),
  //       Duration(seconds: avgTime),
  //       avgSpacing != null ? Duration(seconds: avgSpacing) : Duration.zero,
  //       avgEvaluate.toDouble());
  // }

  // Future<String> selectSmokingStatusAll() async {
  //   List<Map<String, dynamic>> maps =
  //       await databaseManager.select("SmokingStatus");
  //   List<SmokingStatus> list =
  //       maps.map((item) => SmokingStatus.fromMap(item)).toList();
  //   // String data = await SmokingStatus.toCsv(list);
  //   return SmokingStatus.toCsv(list);
  // }

  Future<void> generateSummaries(Set<String> dates) async {
    // databaseManager.deleteAll("summaryDay");
    if (dates.isNotEmpty) {
      for (String sdate in dates) {
        updateSummaryDay(sdate);
      }
    }
  }

  // Map<DateTime, List<SmokingStatus>> _groupByDate(
  //     List<SmokingStatus> records, String changeTime) {
  //   Map<DateTime, List<SmokingStatus>> groupedRecords = {};
  //
  //   for (var record in records) {
  //     final groupDate = _getGroupDate(record.startTime, changeTime);
  //     if (!groupedRecords.containsKey(groupDate)) {
  //       groupedRecords[groupDate] = [];
  //     }
  //     groupedRecords[groupDate]!.add(record);
  //   }
  //
  //   return groupedRecords;
  // }
}
