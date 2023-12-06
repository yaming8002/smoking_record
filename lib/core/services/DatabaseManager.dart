import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'AppSettingService.dart';

class DatabaseManager {
  static Database? _db;
  static const int databaseVersion = 2;

  DatabaseManager._(); // 私有構造函數，避免創建類的實例
  DatabaseManager(Database db) {
    _db = db;
    initDB();
  }

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "MyDatabase.db");
    return await openDatabase(
      path,
      version: databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE smokingStatus  (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          count INTEGER,
          startTime TEXT,
          endTime TEXT,
          evaluate INTEGER,
          totalTime INTEGER,
          interval INTEGER
        )
    ''');

    await db.execute('''
      DROP TABLE IF EXISTS summaryDay; 
      ''');

    await db.execute('''
      CREATE TABLE SummaryDay (
          sDate TEXT PRIMARY KEY,  -- 將 sDate 設定為主鍵
          startTime TEXT,
          endTime TEXT,
          count INTEGER NOT NULL,
          frequency INTEGER NOT NULL,
          totalTime INTEGER NOT NULL, -- 存儲 Duration 的毫秒值
          avgTime INTEGER NOT NULL, -- 存儲 Duration 的毫秒值
          interval INTEGER NOT NULL, -- 存儲 Duration 的毫秒值
          evaluate REAL  NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE SummaryWeek (
          sDate TEXT PRIMARY KEY,  -- 將 sDate 設定為主鍵
          startTime TEXT,
          endTime TEXT,
          count INTEGER NOT NULL,
          frequency INTEGER NOT NULL,
          totalTime INTEGER NOT NULL, -- 存儲 Duration 的毫秒值
          avgTime INTEGER NOT NULL, -- 存儲 Duration 的毫秒值
          interval INTEGER NOT NULL, -- 存儲 Duration 的毫秒值
          evaluate REAL  NOT NULL
      );
    ''');
  }

  static Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // 根據 oldVersion 和 newVersion 來決定如何升級資料庫
    if (oldVersion < 2) {
      // 例如，如果舊版本是1，新版本是2，則執行以下操作：
      // ... (你的升級語句)
    }
    // 如果有更多的版本，可以繼續添加更多的條件
  }

  Future<void> checkAndUpdate() async {
    final currentVersion = 0.3; // 你的當前 app 版本
    final storedVersion = AppSettingService.getAppVersion();

    if (storedVersion < currentVersion) {
      await updateDailySmokingSummary();
      AppSettingService.setAppVersion(currentVersion);
    }
  }

  static Future<void> updateDailySmokingSummary() async {
    // 步驟1: 從 SmokingStatus 表中選取所有資料
    List<Map<String, dynamic>> smokingData = await _db!.query('smokingStatus');

    // 根據 smokingEndTime 進行分組，並計算每日的摘要
    Map<String, Map<String, dynamic>> groupedData = {};

    for (var record in smokingData) {
      // 假設格式為 "YYYY-MM-DD HH:MM:SS"
      String date = record['smokingEndTime'].split(' ')[0];
      if (!groupedData.containsKey(date)) {
        groupedData[date] = {
          'summaryDate': date,
          'totalSmokes': 0,
          'smokeNumber': 0,
          'totalSmokingTime': 0, // 簡單起見，假設這是以分鐘為單位
          'smokingInterval': 0, // 簡單起見，假設這是以分鐘為單位
          'smokingEvaluate': 0
        };
      }

      groupedData[date]?['totalSmokes'] += 1;
      groupedData[date]?['smokeNumber'] += record['smokeCount'];
      groupedData[date]?['totalSmokingTime'] += record['totalSmokingTime'];
      groupedData[date]?['smokingInterval'] += record['smokingInterval'];
      groupedData[date]?['smokingEvaluate'] += record['smokingEvaluate'];
    }

    for (var date in groupedData.keys) {
      groupedData[date]?['averageSmokingTime'] = groupedData[date]
              ?['totalSmokingTime'] /
          groupedData[date]?['totalSmokes'];
      groupedData[date]?['smokingEvaluate'] = (groupedData[date]
                  ?['smokingEvaluate'] /
              groupedData[date]?['totalSmokes'])
          .round();
    }

    // 步驟3: 檢查 DailySmokingSummary 表中是否已有該日期的資料，如果有，則刪除
    for (var date in groupedData.keys) {
      await _db!.delete('DailySmokingSummary',
          where: 'summaryDate = ?', whereArgs: [date]);
    }

    // 步驟4: 將計算結果插入 DailySmokingSummary 表中
    for (var date in groupedData.keys) {
      await _db!.insert('DailySmokingSummary', groupedData[date]!);
    }
  }

  Future<int> delete(String table, int id) async {
    return await _db!.delete(table, where: 'id = ?', whereArgs: [id]) ?? 0;
  }

  Future<int> deleteAll(String table) async {
    await _db!.execute("DELETE FROM sqlite_sequence WHERE name='$table'");
    return await _db!.delete(table) ?? 0;
  }

  Future<int> insert(String table, Map<String, dynamic> data) async {
    return await _db!.insert(table, data);
  }

  Future<int> insertorReplace(String table, Map<String, dynamic> data) async {
    return await _db!.insert(table, data,
            conflictAlgorithm: ConflictAlgorithm.replace) ??
        0;
  }

  Future<List<Map<String, dynamic>>> select(String table) async {
    return await _db?.query(table) ?? [];
  }

  Future<List<Map<String, dynamic>>> rawQuery(String sql,
      [List<dynamic>? arguments]) async {
    return await _db?.rawQuery(sql, arguments) ?? [];
  }

  Future<int> update(String table, int id, Map<String, dynamic> data) async {
    return await _db?.update(table, data, where: 'id = ?', whereArgs: [id]) ??
        0;
  }

  execute(String sql, [List<dynamic>? arguments]) {
    _db!.execute(sql, arguments);
  }
}
