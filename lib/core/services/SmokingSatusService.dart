import 'package:share_plus/share_plus.dart';
import 'package:smoking_record/utils/dateTimeUtil.dart';

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
    List<Map<String, dynamic>> queryResult = await databaseManager!.rawQuery(
        "SELECT * FROM smokingStatus WHERE SUBSTR(endTime, 1, 10) between ? and ? order by endTime  LIMIT ? OFFSET ? ",
        [start, end, itemsPerPage, offset]);

    List<SmokingStatus> list =
        queryResult.map((item) => SmokingStatus.fromMap(item)).toList();
    return list;
  }

  insertSmokingStatus(Map<String, dynamic> map) async {
    int check = await databaseManager!.insert('smokingStatus', map);
    List<Map<String, dynamic>> queryResult = await databaseManager!
        .rawQuery("SELECT * FROM smokingStatus WHERE id = ? ", [check]);
  }

  deleteAll() async {
    await databaseManager!.deleteAll("smokingStatus");
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
          'UPDATE smokingStatus SET ${updates.join(', ')} WHERE id = ${map['id']}';

      await databaseManager!.execute(sql);
    } else {
      print('Error: smokingStatus does not have an id.');
      insertSmokingStatus(map);
    }
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
}
