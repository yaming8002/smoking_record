import 'package:flutter/material.dart';

import '../../utils/dateTimeUtil.dart';
import '../models/SmokingStatus.dart';
import '../models/Summary.dart';
import 'AppSettingService.dart';
import 'DatabaseManager.dart';

class SummaryService {
  final DatabaseManager databaseManager;
  TimeOfDay? changeTime = AppSettingService.getTimeChangeToTimeOfDay();
  // String? changeTimeByStr = AppSettingService.getTimeChange();

  SummaryService(this.databaseManager);

  /// Retrieves the total data for the week of a specified date. If no date is specified, defaults to today.
  Future<Summary> getSummaryDay([DateTime? now]) async {
    now = now ?? DateTime.now();
    // Build query string
    String daySelect = '''SELECT * FROM SummaryDay WHERE sDate = ? ''';

    final dayTotalRes =
        await databaseManager?.rawQuery(daySelect, [DateTimeUtil.getDate(now)]);

    Summary summary = dayTotalRes!.isNotEmpty
        ? Summary.fromMap(dayTotalRes[0])
        : Summary('-', now, now, 0, 0, Duration.zero, Duration.zero,
            Duration.zero, 0.0);

    return summary;
  }

  Future<Summary> getSummaryWeek([DateTime? now]) async {
    now = now ?? DateTime.now();

    // Build query string
    String daySelect =
        '''SELECT * FROM SummaryWeek WHERE ? between startTime  and endTime ''';

    final weekTotalRes = await databaseManager
        ?.rawQuery(daySelect, [DateTimeUtil.getDateTime(now)]);

    Summary summary = weekTotalRes!.isNotEmpty
        ? Summary.fromMap(weekTotalRes[0])
        : Summary('-', now, now, 0, 0, Duration.zero, Duration.zero,
            Duration.zero, 0.0);

    return summary;
  }

  /// Retrieves all SummaryDay records within a specified date range.
  Future<List<Summary>> getSummaryList(DateTimeRange dateRange,
      [String? tableName]) async {
    // String startDate = dateRange.start.toIso8601String().substring(0, 10);
    // String endDate = dateRange.end.toIso8601String().substring(0, 10);
    List range = DateTimeUtil.getRange(dateRange.start, dateRange.end);
    tableName = tableName ?? 'SummaryDay';
    print(range);
    // Execute query
    List<Map<String, dynamic>> queryResult = await databaseManager!.rawQuery(
        'SELECT * from $tableName where startTime >= ? and endTime <= ?', [
      DateTimeUtil.getDateTime(range[0]),
      DateTimeUtil.getDateTime(range[1])
    ]);

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
      range[0].toIso8601String(),
      range[1].toIso8601String(),
      range[0].toIso8601String(),
      range[1].toIso8601String()
    ];

    List<Map<String, dynamic>>? records =
        await databaseManager.rawQuery(summarySelectSql, arguments);
    print("SummaryDay");
    for (Map<String, dynamic> x in records) {
      print("SummaryDay$x");
    }
    // SummaryDay today = SummaryDay.fromMap(records[0]);
    await databaseManager.insertorReplace('SummaryDay', records[0]);
  }

  Future<void> updateSummaryWeek([DateTime? now]) async {
    now = now ?? DateTime.now();
    final range = DateTimeUtil.getWeekRange(now);

    List<dynamic> arguments = [
      "${DateTimeUtil.getDate(range[0])}~${DateTimeUtil.getDate(range[1])}",
      range[0].toIso8601String(),
      range[1].toIso8601String(),
      range[0].toIso8601String(),
      range[1].toIso8601String()
    ];

    List<Map<String, dynamic>>? records =
        await databaseManager.rawQuery(summarySelectSql, arguments);
    // SummaryDay today = SummaryDay.fromMap(records[0]);
    print("SummaryWeek");
    for (Map<String, dynamic> x in records) {
      print("SummaryWeek$x");
    }
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

    // await processRecordsInPlace(
    //     statuses, "${AppSettingService.getTimeChange()}:00");

    await processRecordsInPlace(statuses);

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

  Future<void> processRecordsInPlace(List<Map<String, dynamic>> records) async {
    // Future<void> processRecordsInPlace(
    //     List<Map<String, dynamic>> records, String crossoverTime) async {
    SmokingStatus? previous;
    Duration interval = AppSettingService.getIntervalTime();

    for (Map<String, dynamic> item in records) {
      SmokingStatus current = SmokingStatus.fromMap(item);
      DateTime startTime = current.startTime;
      DateTime? prevEndTime = previous?.endTime;
      // DateTime crossover =
      //     DateTime.parse('${DateTimeUtil.getDate(startTime)} $crossoverTime');

      Duration diff = startTime.difference(prevEndTime ?? startTime);
      Duration? spacing =
          diff.inMinutes > 0 && diff.inMinutes < interval.inMinutes
              ? diff
              : null;
      // if (prevEndTime == null || startTime.isBefore(prevEndTime!)) {
      //   spacing = null;
      // } else if (startTime.isAfter(crossover) &&
      //     prevEndTime.isBefore(crossover)) {
      //   spacing = null;
      // } else {
      //   spacing = startTime.difference(prevEndTime!);
      // }

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
    WHERE endTime >= ? and endTime <= ? 
  ''';
}
