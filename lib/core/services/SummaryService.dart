import 'package:flutter/material.dart';

import '../../utils/dateTimeUtil.dart';
import '../models/SmokingStatus.dart';
import '../models/Summary.dart';
import 'AppSettingService.dart';
import 'DatabaseManager.dart';

class SummaryService {
  final DatabaseManager databaseManager;
  TimeOfDay? changeTime = AppSettingService.getTimeChangeToTimeOfDay();
  String? changeTimeByStr = AppSettingService.getTimeChange();

  SummaryService(this.databaseManager);

  /// Retrieves the total data for the week of a specified date. If no date is specified, defaults to today.
  Future<Summary> getSummary([DateTime? now, String? tableName]) async {
    now = now ?? DateTime.now();
    tableName = tableName ?? 'SummaryDay';
    // Build query string
    String daySelect =
        '''SELECT * FROM $tableName WHERE startTime < ? and endTime > ? ''';
    print("daySelect $daySelect ");
    print("now $now ");
    final weekTotalRes = await databaseManager?.rawQuery(daySelect,
        [DateTimeUtil.getDateTime(now), DateTimeUtil.getDateTime(now)]);
    print("weekTotalRes $weekTotalRes ");
    List<DateTime> dateRange = DateTimeUtil.getWeekRange(now);
    Summary summary = weekTotalRes!.isNotEmpty
        ? Summary.fromMap(weekTotalRes[0])
        : Summary('-', dateRange[0], dateRange[1], 0, 0, Duration.zero,
            Duration.zero, Duration.zero, 0.0);

    return summary;
  }

  /// Retrieves all SummaryDay records within a specified date range.
  Future<List<Summary>> getSummaryList(DateTimeRange dateRange,
      [String? tableName]) async {
    String startDate = dateRange.start.toIso8601String().substring(0, 10);
    String endDate = dateRange.end.toIso8601String().substring(0, 10);
    tableName = tableName ?? 'SummaryDay';

    // Execute query
    List<Map<String, dynamic>> queryResult = await databaseManager!.rawQuery(
        'SELECT * from $tableName where sDate between ? and ?',
        [startDate, endDate]);

    // Parse query result
    List<Summary> list =
        queryResult.map((item) => Summary.fromMap(item)).toList();
    return list;
  }

  /// Inserts or updates a SummaryDay record.
  Future<void> insertOrUpdateSummaryDay(Summary day) async {
    await databaseManager.insertorReplace(
      'SummaryDay',
      day.toMap(),
    );
  }

  /// Inserts or updates a SummaryDay record.
  Future<void> insertOrUpdateSummaryWeek(Summary day) async {
    await databaseManager.insertorReplace(
      'SummaryWeek',
      day.toMap(),
    );
  }

  Future<void> updateSummaryDay([DateTime? now]) async {
    now = now ?? DateTime.now();
    final range = DateTimeUtil.getOneDateRange(now);

    List<dynamic> arguments = [
      DateTimeUtil.getDate(range[0]),
      DateTimeUtil.getDateTime(range[0]),
      DateTimeUtil.getDateTime(range[1]),
      DateTimeUtil.getDateTime(range[0]),
      DateTimeUtil.getDateTime(range[1])
    ];

    List<Map<String, dynamic>>? records =
        await databaseManager.rawQuery(summarySelectSql, arguments);
    for (Map<String, dynamic> x in records) {
      print(x);
    }
    // SummaryDay today = SummaryDay.fromMap(records[0]);
    await databaseManager.insertorReplace('SummaryDay', records[0]);
  }

  Future<void> updateSummaryWeek([DateTime? now]) async {
    now = now ?? DateTime.now();
    final range = DateTimeUtil.getWeekRange(now);

    List<dynamic> arguments = [
      "${DateTimeUtil.getDate(range[0])}~${DateTimeUtil.getDateTime(range[1])}",
      DateTimeUtil.getDateTime(range[0]),
      DateTimeUtil.getDateTime(range[1]),
      DateTimeUtil.getDateTime(range[0]),
      DateTimeUtil.getDateTime(range[1])
    ];

    List<Map<String, dynamic>>? records =
        await databaseManager.rawQuery(summarySelectSql, arguments);
    // SummaryDay today = SummaryDay.fromMap(records[0]);
    await databaseManager.insertorReplace('SummaryWeek', records[0]);
  }

  generateSummaries(Set<DateTime> dates) async {
    for (var dateTime in dates) {
      await updateSummaryDay(dateTime);
      await updateSummaryWeek(dateTime);
    }
  }

  cleanAll() async {
    await databaseManager.deleteAll("SummaryDay");
    await databaseManager.deleteAll("SummaryWeek");
    String selectfirststatus =
        '''SELECT * FROM SmokingStatus ORDER BY id LIMIT 1;  ''';
    List<Map<String, dynamic>> statuses =
        await databaseManager.select("SmokingStatus");
    print(statuses);

    DateTime firstDate = DateTime.parse(statuses[0]["startTime"]);

    await processRecordsInPlace(
        statuses, "${AppSettingService.getTimeChange()}:00");

    // await databaseManager
    //     .execute(updateStatusSql, ["${AppSettingService.getTimeChange()}:00"]);

    DateTime currentDate = DateTime.now();
    Set<DateTime> dates = {};
    while (firstDate.isBefore(currentDate)) {
      dates.add(firstDate);
      firstDate = firstDate.add(Duration(days: 1));
    }
    dates.add(currentDate);
    await generateSummaries(dates);
  }

  Future<void> processRecordsInPlace(
      List<Map<String, dynamic>> records, String crossoverTime) async {
    SmokingStatus? previous;

    for (Map<String, dynamic> item in records) {
      SmokingStatus current = SmokingStatus.fromMap(item);
      DateTime startTime = current.startTime;
      DateTime? prevEndTime = previous?.endTime;
      DateTime crossover =
          DateTime.parse('${DateTimeUtil.getDate(startTime)} $crossoverTime');

      Duration? spacing;
      if (prevEndTime == null || startTime.isBefore(prevEndTime!)) {
        spacing = null;
      } else if (startTime.isAfter(crossover) &&
          prevEndTime.isBefore(crossover)) {
        spacing = null;
      } else {
        spacing = startTime.difference(prevEndTime!);
      }

      current.spacing = spacing;
      previous = current;
      await databaseManager.insertorReplace("SmokingStatus", current.toMap());
    }
  }

  final String summarySelectSql = '''
    SELECT
          ? as sDate, 
          COALESCE(SUM(count), 0) as count, 
          ? as startTime,
          ? as endTime,
          count(*) as frequency,
          COALESCE(SUM(totalTime), 0) as totalTime, 
          COALESCE(CAST(avg(totalTime) AS INTEGER), 0) as avgTime,
          COALESCE(CAST(avg(spacing) AS INTEGER), 0)  as spacing,
          COALESCE(CAST(avg(evaluate) AS INTEGER), 0)  as evaluate
    FROM SmokingStatus 
    WHERE endTime > ? and endTime < ? 
  ''';
}
