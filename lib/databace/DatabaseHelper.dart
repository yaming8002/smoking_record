import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smoking_record/databace/summaryDay.dart';
import 'package:sqflite/sqflite.dart';

import '../settingPage.dart';
import 'SmokingStatus.dart';


class DBHelper {
  static Database? _db;
  static const int databaseVersion = 2; // 統一的版本控制

  static Future<Database> get database async {
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
      version: databaseVersion, // 使用統一的版本控制
      onCreate: _onCreate,
      onUpgrade: _onUpgrade, // 處理資料庫升級
    );
  }

  static Future _onCreate(Database db, int version) async {

    await db.execute('''
        CREATE TABLE SmokingStatus  (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          count INTEGER,
          startTime TEXT,
          endTime TEXT,
          evaluate INTEGER,
          totalTime INTEGER,
          spacing INTEGER
        )
    ''');

    await db.execute('''
      DROP TABLE IF EXISTS summaryDay; 
      ''') ;

    await db.execute('''
      CREATE TABLE summaryDay (
          sDate TEXT PRIMARY KEY,  -- 將 sDate 設定為主鍵
          count INTEGER NOT NULL,
          frequency INTEGER NOT NULL,
          totalTime INTEGER NOT NULL, -- 存儲 Duration 的毫秒值
          avgTime INTEGER NOT NULL, -- 存儲 Duration 的毫秒值
          spacing INTEGER NOT NULL, -- 存儲 Duration 的毫秒值
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
    final storedVersion =  AppSettings.getAppVersion() ;

    if (storedVersion < currentVersion) {
      await updateDailySmokingSummary();
      AppSettings.setAppVersion(currentVersion) ;
    }
  }


  static Future<void> updateDailySmokingSummary() async {
    Database db = await DBHelper.database;

    // 步驟1: 從 SmokingStatus 表中選取所有資料
    List<Map<String, dynamic>> smokingData = await db.query('SmokingStatus');

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
      groupedData[date]?['averageSmokingTime'] = groupedData[date]?['totalSmokingTime'] / groupedData[date]?['totalSmokes'];
      groupedData[date]?['smokingEvaluate'] = (groupedData[date]?['smokingEvaluate'] / groupedData[date]?['totalSmokes']).round();
    }

    // 步驟3: 檢查 DailySmokingSummary 表中是否已有該日期的資料，如果有，則刪除
    for (var date in groupedData.keys) {
      await db.delete('DailySmokingSummary', where: 'summaryDate = ?', whereArgs: [date]);
    }

    // 步驟4: 將計算結果插入 DailySmokingSummary 表中
    for (var date in groupedData.keys) {
      await db.insert('DailySmokingSummary', groupedData[date]!);
    }
  }

  static Future<int> delete(String table, int id) async {
    Database db = await DBHelper.database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  // 插入操作
  static Future<int> insert(String table, Map<String, dynamic> data) async {
    Database db = await DBHelper.database;
    return await db.insert(table, data);
  }

  static Future<int> insertorReplace(String table, Map<String, dynamic> data) async {
    Database db = await DBHelper.database;
    return await db.insert(
        table,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }
  // 查詢操作
  static Future<List<Map<String, dynamic>>> select(String table) async {
    Database db = await DBHelper.database;
    return await db.query(table);
  }

  static Future<List<Map<String, dynamic>>> rawQuery(String sql, [List<dynamic>? arguments]) async {
    Database db = await DBHelper.database;
    return await db.rawQuery(sql, arguments);
  }

  // 更新操作
  static Future<int> update(String table, int id, Map<String, dynamic> data) async {
    Database db = await DBHelper.database;
    return await db.update(table, data, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> insertOrUpdateSummaryDay(Database db, summaryDay day) async {
    await db.insert(
      'summary_days',
      day.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static insertSmokingStatus( Map<String, dynamic> map) async {
    print(map) ;
    await DBHelper.insert('SmokingStatus', map );
    // await DBHelper.insertSmokingStatus( map ) ;
    String date = map['endTime'].substring(0,10);
    String timeChange = AppSettings.getTimeChange() ;
    DateTime startDateTime = DateTime.parse('$date $timeChange');
    DateTime endDateTime = startDateTime.add(Duration(days: 1));

    String sql = '''SELECT
      ? as sDate, 
      SUM(count) as count, 
      count(*) as frequency,
      SUM(totalTime) as totalTime, 
      CAST(avg(totalTime) AS INTEGER) as avgTime,
      CAST(avg(spacing) AS INTEGER)  as spacing,
      CAST(avg(evaluate) AS INTEGER)  as evaluate
      FROM SmokingStatus 
      WHERE endTime > ? and endTime < ?'''; // 注意這裡的結束括號

    List<dynamic> arguments = [date, startDateTime.toString(), endDateTime.toString()];

    List<Map<String, dynamic>> records = await DBHelper.rawQuery(sql, arguments);
    print(records[0]) ;
    // summaryDay today = summaryDay.fromMap(records[0]);
    await DBHelper.insertorReplace('summaryDay', records[0] );

  }



}
