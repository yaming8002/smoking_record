import 'package:csv/csv.dart';

class SmokingStatus {
  int? id; // 唯一識別碼
  int count; // 抽菸的次數
  DateTime startTime; // 抽菸的開始時間
  DateTime endTime; // 抽菸的結束時間
  int evaluate; // 抽菸感受的評分
  Duration totalTime; // 抽菸的總時間
  Duration interval; // 抽菸的間隔時間

  SmokingStatus(
    this.id,
    this.count,
    this.startTime,
    this.endTime,
    this.evaluate,
    this.totalTime,
    this.interval,
  );

  // 將對象轉換為 Map 結構，方便儲存到 SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'count': count,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'evaluate': evaluate,
      'totalTime': totalTime.inMilliseconds,
      'interval': interval.inMilliseconds,
    };
  }

  // 從 Map 結構創建對象，方便從 SQLite 讀取數據
  SmokingStatus.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        count = map['count'],
        startTime = DateTime.parse(map['startTime']),
        endTime = DateTime.parse(map['endTime']),
        evaluate = map['evaluate'],
        totalTime = Duration(milliseconds: map['totalTime'] ?? 0),
        interval = Duration(milliseconds: map['interval'] ?? 0);

  @override
  String toString() {
    return 'SmokingStatus{id: $id, count: $count, startTime: $startTime, endTime: $endTime, evaluate: $evaluate, totalTime: $totalTime, interval: $interval}';
  }

  // 將SmokingStatus列表轉換為CSV字符串
  static String toCsv(List<SmokingStatus> records) {
    final rows = List<List<dynamic>>.from(records.map((record) => [
          record.id,
          record.count,
          record.startTime.toIso8601String(),
          record.endTime.toIso8601String(),
          record.evaluate,
          record.totalTime.inMilliseconds,
          record.interval.inMilliseconds,
        ]));
    rows.insert(0, [
      'id',
      'count',
      'startTime',
      'endTime',
      'evaluate',
      'totalTime',
      'interval'
    ]); // 插入標題行
    return const ListToCsvConverter().convert(rows);
  }

  // 從CSV字符串創建SmokingStatus列表
  factory SmokingStatus.fromCsv(List<dynamic> csvRow) {
    return SmokingStatus(
      null, // id set to null because we don't want to sync from CSV
      csvRow[1],
      DateTime.parse(csvRow[2]),
      DateTime.parse(csvRow[3]),
      csvRow[4],
      Duration(milliseconds: csvRow[5]),
      Duration(milliseconds: csvRow[6]),
    );
  }
}
