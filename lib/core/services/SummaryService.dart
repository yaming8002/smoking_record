import 'package:flutter/material.dart';

import '../../utils/dateTimeUtil.dart';
import '../models/Summary.dart';
import 'AppSettingService.dart';
import 'DatabaseManager.dart';

class SummaryService {
  final DatabaseManager databaseManager;

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

    // Get the start and end of the week based on the given date
    var weekRange = DateTimeUtil.getWeekRange(now);
    List<dynamic> arguments = [
      DateTimeUtil.getDateTime(weekRange[0]),
      DateTimeUtil.getDateTime(weekRange[1])
    ];

    // Query the daily summaries within the week's time range
    String query = '''
      SELECT 
        MIN(startTime) as startTime, 
        MAX(endTime) as endTime, 
        SUM(count) as count,
        SUM(frequency) as frequency,
        SUM(totalTime) as totalTime,
        AVG(avgTime) as avgTime,
        AVG(interval) as interval,
        AVG(evaluate) as evaluate
      FROM SummaryDay 
      WHERE startTime >= ? AND endTime <= ?
    ''';

    List<Map<String, dynamic>> queryResult =
        await databaseManager.rawQuery(query, arguments);

    bool isValidResult = queryResult.isNotEmpty &&
        queryResult[0].values.any((value) => value != null);
    print(queryResult);
    // Check if there is data for the week and create a summary
    Summary summary;
    if (isValidResult) {
      summary = Summary.fromMap(queryResult[0]);
    } else {
      summary = Summary('-', weekRange[0], weekRange[1], 0, 0, Duration.zero,
          Duration.zero, Duration.zero, 0.0);
    }

    return summary;
  }

  /// Retrieves all SummaryDay records within a specified date range.
  Future<List<Summary>> getSummaryList(DateTimeRange dateRange,
      [String? tableName]) async {
    List<DateTime> range = tableName == 'SummaryWeek'
        ? DateTimeUtil.getRange(DateTimeUtil.getWeekRange(dateRange.start)[0],
            DateTimeUtil.getWeekRange(dateRange.end)[1])
        : DateTimeUtil.getRange(dateRange.start, dateRange.end);

    // Execute query
    List<Map<String, dynamic>> queryResult = await databaseManager!.rawQuery(
        'SELECT * from SummaryDay where startTime >= ? and endTime <= ? order by startTime ',
        [
          DateTimeUtil.getDateTime(range[0]),
          DateTimeUtil.getDateTime(range[1])
        ]);

    // Parse query result
    List<Summary> list =
        queryResult.map((item) => Summary.fromMap(item)).toList();

    return tableName == 'SummaryWeek' ? aggregateToWeeklySummaries(list) : list;
  }

  List<Summary> aggregateToWeeklySummaries(List<Summary> list) {
    bool? isWeekStartMonday = AppSettingService.getIsWeekStartMonday() ?? false;
    List<Summary> weekList = [];
    String dateWeekend = '';
    Summary? currentWeekSummary;
    for (int i = 0; i < list.length; i++) {
      if (dateWeekend == '' ||
          DateTimeUtil.getDate(list[i].startTime).compareTo(dateWeekend) < 0) {
        currentWeekSummary = list[i].copy();
        weekList.add(currentWeekSummary);
      } else {
        currentWeekSummary?.aggregate(list[i]);
      }
    }

    return weekList;
  }

  /// Inserts or updates a SummaryDay record.
  Future<void> insertOrUpdateSummaryDay(Summary day) async {
    await databaseManager.insertorReplace(
      'SummaryDay',
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

    List<Map<String, dynamic>>? summary =
        await databaseManager.rawQuery(summarySelectSql, arguments);
    await databaseManager.insertorReplace('summaryDay', summary[0]);
  }

  generateSummaries(Set<DateTime> dates) async {
    for (var dateTime in dates) {
      await updateSummaryDay(dateTime);
    }
  }

  cleanAll() async {
    await databaseManager.deleteAll("summaryDay");

    List<Map<String, dynamic>> statuses =
        await databaseManager.select("smokingStatus");

    DateTime firstDate = DateTime.parse(statuses[0]["startTime"]);

    DateTime currentDate = DateTime.now();
    Set<DateTime> dates = {};
    while (firstDate.isBefore(currentDate)) {
      dates.add(firstDate);
      firstDate = firstDate.add(Duration(days: 1));
    }
    dates.add(currentDate);
    await generateSummaries(dates);
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
          COALESCE(CAST(avg(interval) AS INTEGER), 0)  as interval,
          COALESCE(CAST(avg(evaluate) AS INTEGER), 0)  as evaluate
    FROM smokingStatus 
    WHERE endTime >= ? and endTime <= ? 
  ''';
}
