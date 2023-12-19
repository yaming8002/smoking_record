import 'package:share_plus/share_plus.dart';
import 'package:smoking_record/utils/DateTimeUtil.dart';

import '../models/SmokingStatus.dart';
import 'DatabaseManager.dart';

class SmokingSatusService {
  final DatabaseManager databaseManager;

  SmokingSatusService(this.databaseManager);

  Future<String> selectAll() async {
    List<Map<String, dynamic>> maps =
        await databaseManager.select("smokingStatus");

    List<SmokingStatus> list =
        maps.map((item) => SmokingStatus.fromMap(item)).toList();

    return SmokingStatus.toCsv(list);
  }

  Future<List<SmokingStatus>> selectByRang(int currentPage, int itemsPerPage,
      [DateTime? startTime, DateTime? endTime]) async {
    String start = DateTimeUtil.getDate(startTime ?? DateTime.now());
    String end = DateTimeUtil.getDate(endTime ?? DateTime.now());

    int offset = currentPage * itemsPerPage;
    List<Map<String, dynamic>> queryStatus = await databaseManager!.rawQuery(
        "SELECT * FROM smokingStatus WHERE SUBSTR(endTime, 1, 10) between ? and ? order by endTime  LIMIT ? OFFSET ? ",
        [start, end, itemsPerPage, offset]);

    List<SmokingStatus> list =
        queryStatus.map((item) => SmokingStatus.fromMap(item)).toList();
    return list;
  }

  insertSmokingStatus(Map<String, dynamic> map) async {
    await databaseManager!.insert('smokingStatus', map);
  }

  updateAllByDate(List<SmokingStatus> list, bool isEdit) async {
    if (list == null || list.isEmpty) {
      return;
    }
    list[0].interval = Duration.zero;
    for (int i = 1; i < list.length; i += 1) {
      if (isEdit) {
        await updateSmokingStatus(list[i - 1].toMap());
      } else {
        await insertSmokingStatus(list[i - 1].toMap());
      }
      list[i].interval =
          _checkIntervalValid(list[i - 1].endTime, list[i].startTime);
    }
    if (isEdit) {
      await updateSmokingStatus(list[list.length - 1].toMap());
    } else {
      await insertSmokingStatus(list[list.length - 1].toMap());
    }
  }

  deleteAll() async {
    await databaseManager!.deleteAll("smokingStatus");
  }

  updateSmokingStatus(Map<String, dynamic> map, [bool? first]) async {
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
          'UPDATE smokingStatus SET ${updates.join(', ')} WHERE id = ${map['id']}';

      await databaseManager!.execute(sql);
    } else {
      insertSmokingStatus(map);
    }

    if (first ?? false) {
      List<DateTime> range =
          DateTimeUtil.getOneDateRange(DateTime.parse(map['endTime']));
      List<Map<String, dynamic>> queryStatus = await databaseManager!.rawQuery(
          "SELECT * FROM smokingStatus WHERE  endTime >= ? and  endTime <= ?  order by endTime",
          [range[0].toIso8601String(), range[1].toIso8601String()]);
      List<SmokingStatus> list = [];
      for (Map<String, dynamic> status in queryStatus) {
        list.add(SmokingStatus.fromMap(status));
      }
      await updateAllByDate(list, true);
    }
  }

  updateLastEndTime(DateTime lastTime) async {
    lastTime = lastTime ?? DateTime.now();
    List<DateTime> range = DateTimeUtil.getOneDateRange(lastTime);
    List<Map<String, dynamic>> queryStatus = await databaseManager!.rawQuery(
        "SELECT * FROM smokingStatus WHERE endTime >= ? and endTime <= ? order by endTime DESC LIMIT 5",
        [range[0].toIso8601String(), range[1].toIso8601String()]);
    // 检查是否有记录
    if (queryStatus.isNotEmpty) {
      AppSettingService.setLastEndTime(range['']);
    } else {
      print("没有找到记录");
    }

    AppSettingService.getLastEndTime();
  }

  Future<void> exportDataToCsv() async {
    // 1. 從SQLite數據庫查詢數據
    final List<Map<String, dynamic>> maps =
        await databaseManager.select("smokingStatus");
    final List<SmokingStatus> records =
        List.generate(maps.length, (i) => SmokingStatus.fromMap(maps[i]));

    // 2. 使用toCsv方法將數據轉換為CSV格式的二維列表
    final rows = SmokingStatus.toCsv(records);

    // Share the CSV
    Share.share(rows, subject: 'Smoking Status Records.csv');
  }

  Duration _checkIntervalValid(DateTime a /*last end */, DateTime b /*start*/) {
    Duration interval = b.difference(a);
    if (DateTimeUtil.getDate(a) == DateTimeUtil.getDate(b) &&
        interval > Duration.zero &&
        interval.inHours < 6) {
      return interval;
    }
    return Duration.zero; // startTime.difference(endTime);
  }
}
