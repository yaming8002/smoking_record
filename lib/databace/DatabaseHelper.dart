import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DBHelper {
  static Database? _db;

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
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {


    await db.execute('''
        CREATE TABLE SmokingStatus  (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          smokeCount INTEGER,
          smokingStartTime TEXT,
          smokingEndTime TEXT,
          smokingRating INTEGER,
          totalSmokingTime INTEGER,
          smokingInterval INTEGER
        )
    ''');
    await db.execute('''
      CREATE TABLE DailySmokingSummary (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        summaryDate TEXT,
        totalSmokes INTEGER,
        smokeFrequency INTEGER,
        averageSmokeCount INTEGER,
        totalSmokingTime TEXT,
        averageSmokingTime TEXT,
        smokeExperienceRating TEXT,
        overallRating INTEGER
      )
    ''');
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



}
