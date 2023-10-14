class Summary {
  int? id; // 唯一識別碼
  final String sDate;
  final DateTime startTime; // 當日的開始時間
  final DateTime endTime; // 當日的結束時間

  final int count;

  final int frequency;
  // final int avgCount;

  final Duration totalTime;
  final Duration avgTime;
  final Duration spacing;

  final double evaluate;

  Summary(
      this.sDate,
      this.startTime,
      this.endTime,
      this.count,
      this.frequency,
      // this.avgCount,
      this.totalTime,
      this.avgTime,
      this.spacing,
      this.evaluate);

  Map<String, dynamic> toMap() {
    return {
      'sDate': sDate, // 統計日期
      'startTime': startTime.toIso8601String(), // 統計開始時間
      'endTime': endTime.toIso8601String(), // 統計結束時間
      'count': count, // 總抽菸數
      // 'avgCount': avgCount, // 平均抽菸數
      'frequency': frequency, // 抽菸次數
      'totalTime': totalTime.inMilliseconds, // 總耗時
      'avgTime': avgTime.inMilliseconds,
      'spacing': spacing.inMilliseconds, // 平均間隔時間
      'evaluate': evaluate, // 平均感受評分
    };
  }

  Map<String, dynamic> toMinuteMap() {
    return {
      'sDate': sDate, // 統計日期
      'startTime': startTime.toIso8601String(), // 統計開始時間
      'endTime': endTime.toIso8601String(), // 統計結束時間
      'count': count, // 總抽菸數
      // 'avgCount': avgCount, // 平均抽菸數
      'frequency': frequency, // 抽菸次數
      'totalTime': (totalTime.inMinutes < 0 ? 0 : totalTime.inMinutes), // 總耗時
      'avgTime': (avgTime.inMinutes < 0 ? 0 : avgTime.inMinutes),
      'spacing': (spacing.inMinutes < 0 ? 0 : spacing.inMinutes), // 平均間隔時間
      'evaluate': evaluate, // 平均感受評分
    };
  }

  Summary.fromMap(Map<String, dynamic> map)
      : sDate = map['sDate'] ?? '-',
        startTime = DateTime.parse(map['startTime']),
        endTime = DateTime.parse(map['endTime']),
        count = map['count'] ?? 0,
        frequency = map['frequency'] ?? 0,
        // avgCount = map['avgCount'],
        totalTime = Duration(milliseconds: map['totalTime'] ?? 0),
        avgTime = Duration(milliseconds: map['avgTime'] ?? 0),
        spacing = Duration(
            milliseconds: (map['spacing'] ?? 0) < 0 ? 0 : map['spacing']),
        evaluate = double.parse((map['evaluate'] ?? 0.0).toStringAsFixed(2));

  @override
  String toString() {
    return 'SummaryWeek{sDate: $sDate,startTime: $startTime, endTime: $endTime, count: $count, frequency: $frequency, totalTime: $totalTime, avgTime: $avgTime, spacing: $spacing, evaluate: $evaluate}';
  }
}
