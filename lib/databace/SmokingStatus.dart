class SmokingStatus {
  int? id;  // 唯一識別碼
  int count;  // 抽菸的次數
  DateTime startTime;  // 抽菸的開始時間
  DateTime endTime;  // 抽菸的結束時間
  int evaluate;  // 抽菸感受的評分
  Duration totalTime;  // 抽菸的總時間
  Duration? spacing;  // 抽菸的間隔時間

  SmokingStatus(
      this.id,
      this.count,
      this.startTime,
      this.endTime,
      this.evaluate,
      this.totalTime,
      this.spacing,
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
      'spacing': (spacing ?? Duration.zero).inMilliseconds,
    };
  }

  // 從 Map 結構創建對象，方便從 SQLite 讀取數據
  SmokingStatus.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        count = map['count'],
        startTime = DateTime.parse(map['startTime']),
        endTime = DateTime.parse(map['endTime']),
        evaluate = map['evaluate'],
        totalTime = Duration(milliseconds: map['totalTime']),
        spacing = Duration(milliseconds:(map['spacing'] ?? Duration.zero) );

  @override
  String toString() {
    return 'SmokingStatus{id: $id, count: $count, startTime: $startTime, endTime: $endTime, evaluate: $evaluate, totalTime: $totalTime, spacing: $spacing}';
  }

// 返回對象的字符串表示形式，方便調試


}