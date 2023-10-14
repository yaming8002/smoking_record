import 'package:flutter/material.dart';

import '../../utils/dateTimeUtil.dart';
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
    List<Map<String, dynamic>> firstStatus =
        await databaseManager.rawQuery(selectfirststatus);
    DateTime firstDate = DateTime.parse(firstStatus[0]["startTime"]);

    await databaseManager
        .execute(updateStatusSql, ["${AppSettingService.getTimeChange()}:00"]);

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
          COALESCE(CAST(avg(spacing) AS INTEGER), 0)  as spacing,
          COALESCE(CAST(avg(evaluate) AS INTEGER), 0)  as evaluate
    FROM SmokingStatus 
    WHERE endTime > ? and endTime < ? 
  ''';

  final String updateStatusSql = '''
    WITH CTE AS (
        SELECT
            SmokingStatus.id,
            LAG(SmokingStatus.endTime, 1) OVER (ORDER BY SmokingStatus.startTime) AS prevEndTime,
            SmokingStatus.startTime,
            strftime('%Y-%m-%d', SmokingStatus.startTime) || ' ' || ? AS crossoverTime  -- 換日時間
        FROM SmokingStatus
    )
    
    UPDATE SmokingStatus
    SET spacing = 
        CASE 
            -- 當 startTime 小於前一筆的 endTime，設定 spacing 為 null
            WHEN SmokingStatus.startTime <= COALESCE(CTE.prevEndTime, SmokingStatus.startTime) THEN NULL  
            -- 當 startTime 大於 crossoverTime 且前一筆的 endTime 小於 crossoverTime，設定 spacing 為 null
            WHEN SmokingStatus.startTime > CTE.crossoverTime AND COALESCE(CTE.prevEndTime, '1900-01-01') < CTE.crossoverTime THEN NULL  
            -- 其他情況，計算 startTime - endTime 並設定為 spacing
            ELSE (strftime('%s', SmokingStatus.startTime) - strftime('%s', COALESCE(CTE.prevEndTime, SmokingStatus.startTime))) * 1000  
        END
    FROM CTE
    WHERE CTE.id = SmokingStatus.id;
  ''';
}
