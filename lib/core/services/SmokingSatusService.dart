import '../../utils/dateTimeUtil.dart';
import '../models/SmokingStatus.dart';
import '../models/summaryDay.dart';
import 'AppSettingService.dart';
import 'DatabaseManager.dart';
import 'SummaryService.dart';

class SmokingSatusService {
  final DatabaseManager databaseManager;
  final SummaryService summaryService;

  SmokingSatusService(this.databaseManager, this.summaryService);

  Future<DateTime?> getLastEndTime() async {
    final maps = await databaseManager.rawQuery(
        "SELECT endTime FROM SmokingStatus ORDER BY endTime DESC LIMIT 1");

    if (maps != null && maps.isNotEmpty) {
      final formattedEndTime = maps.first['endTime'];
      String now = DateTimeUtil.getDate();
      final timeChange = '$now ${AppSettingService.getTimeChange()}';

      if (formattedEndTime != null &&
          formattedEndTime.compareTo(timeChange) >= 0) {
        return DateTime.parse(formattedEndTime);
      }
    }
    return null;
  }

  Future<SummaryDay> getDayTotalNum([String? todayStart]) async {
    todayStart ??= DateTimeUtil.getDate();

    String daySelect = '''SELECT * FROM summaryDay WHERE sDate = ? ''';
    final dayTotalres =
        await databaseManager?.rawQuery(daySelect, [todayStart]);
    SummaryDay first = dayTotalres?.isEmpty == false
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

  insertSmokingStatus(Map<String, dynamic> map) async {
    await databaseManager?.insert('SmokingStatus', map);

    await summaryService?.updateSummaryDay(map['endTime'].substring(0, 10));
  }

  updateSmokingStatus(Map<String, dynamic> map) async {
    if (map['id'] != null) {
      List<String> updates = [];
      map.forEach((key, value) {
        if (value is String) {
          updates.add('$key = "$value"');
        } else {
          updates.add('$key = $value');
        }
      });

      String sql =
          'UPDATE SmokingStatus SET ${updates.join(', ')} WHERE id = ${map['id']}';

      await databaseManager!.execute(sql);
      await summaryService?.updateSummaryDay(map['endTime'].substring(0, 10));
    } else {
      print('Error: SmokingStatus does not have an id.');
    }
  }

  Future<List<SmokingStatus>> selectByRang(
      int currentPage, int itemsPerPage, List<String> date) async {
    int offset = currentPage * itemsPerPage;
    List<Map<String, dynamic>> queryResult = await databaseManager!.rawQuery(
        'SELECT * from SmokingStatus where startTime >= ? AND endTime < ? LIMIT ? OFFSET ?',
        [date[0], date[1], itemsPerPage, offset]);

    List<SmokingStatus> list =
        queryResult.map((item) => SmokingStatus.fromMap(item)).toList();
    return list;
  }
}
