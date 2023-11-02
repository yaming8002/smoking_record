import 'package:share_plus/share_plus.dart';
import 'package:smoking_record/utils/dateTimeUtil.dart';

import '../models/SmokingStatus.dart';
import 'DatabaseManager.dart';

class SmokingSatusService {
  final DatabaseManager databaseManager;

  // TimeOfDay? changTime = AppSettingService.getTimeChangeToTimeOfDay();
  // String? changTimeByStr = AppSettingService.getTimeChange();

  SmokingSatusService(this.databaseManager);

  // Future<DateTime?> getLastEndTime() async {
  //   final maps = await databaseManager.rawQuery(
  //       "SELECT endTime FROM SmokingStatus ORDER BY endTime DESC LIMIT 1");
  //
  //   if (maps != null && maps.isNotEmpty) {
  //     final formattedEndTime =
  //         DateTimeUtil.parseTimeFromString(maps.first['endTime']);
  //
  //     if (DateTimeUtil.compareTime(formattedEndTime!, changTime!)) {
  //       // 將字符串轉換為DateTime
  //       return DateTime.parse(maps.first['endTime']);
  //     }
  //   }
  //   return null;
  // }

  Future<String> selectAll() async {
    List<Map<String, dynamic>> maps =
        await databaseManager.select("SmokingStatus");

    List<SmokingStatus> list =
        maps.map((item) => SmokingStatus.fromMap(item)).toList();
    // String data = await SmokingStatus.toCsv(list);
    return SmokingStatus.toCsv(list);
  }

  Future<List<SmokingStatus>> selectByRang(int currentPage, int itemsPerPage,
      [DateTime? now]) async {
    String nowFormatted = DateTimeUtil.getDate(now ?? DateTime.now());

    int offset = currentPage * itemsPerPage;
    List<Map<String, dynamic>> queryResult = await databaseManager!.rawQuery(
        "SELECT * FROM SmokingStatus WHERE SUBSTR(endTime, 1, 10) = ? LIMIT ? OFFSET ?",
        [nowFormatted, itemsPerPage, offset]);

    List<SmokingStatus> list =
        queryResult.map((item) => SmokingStatus.fromMap(item)).toList();
    return list;
  }

  insertSmokingStatus(Map<String, dynamic> map) async {
    print("insertSmokingStatus$map");
    await databaseManager?.insert('SmokingStatus', map);
  }

  deleteAll() async {
    await databaseManager.deleteAll("SmokingStatus");
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
    } else {
      print('Error: SmokingStatus does not have an id.');
    }
  }

  Future<void> exportDataToCsv() async {
    // 1. 從SQLite數據庫查詢數據
    final List<Map<String, dynamic>> maps =
        await databaseManager.select("SmokingStatus");
    final List<SmokingStatus> records =
        List.generate(maps.length, (i) => SmokingStatus.fromMap(maps[i]));

    // 2. 使用toCsv方法將數據轉換為CSV格式的二維列表
    final rows = SmokingStatus.toCsv(records);

    // Share the CSV
    Share.share(rows, subject: 'Smoking Status Records.csv');
  }
}
