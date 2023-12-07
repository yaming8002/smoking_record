class Summary {
  int? id; // 唯一識別碼
  String sDate;
  DateTime startTime; // 當日的開始時間
  DateTime endTime; // 當日的結束時間

  int count;
  int frequency;
  // final int avgCount;

  Duration totalTime;
  Duration avgTime;
  Duration interval;
  int intervalCount;

  double evaluate;

  Summary(
      this.sDate,
      this.startTime,
      this.endTime,
      this.count,
      this.frequency,
      // this.avgCount,
      this.totalTime,
      this.avgTime,
      this.interval,
      this.intervalCount,
      this.evaluate);

  Summary.newSummary()
      : sDate = '-',
        startTime = DateTime.now(),
        endTime = DateTime.now(),
        count = 0,
        frequency = 0,
        totalTime = Duration.zero,
        avgTime = Duration.zero,
        interval = Duration.zero,
        intervalCount = 0,
        evaluate = 0.0;

  Summary copy() {
    return Summary(
      sDate,
      DateTime.fromMillisecondsSinceEpoch(startTime.millisecondsSinceEpoch),
      DateTime.fromMillisecondsSinceEpoch(endTime.millisecondsSinceEpoch),
      count,
      frequency,
      Duration(milliseconds: totalTime.inMilliseconds),
      Duration(milliseconds: avgTime.inMilliseconds),
      Duration(milliseconds: interval.inMilliseconds),
      intervalCount,
      evaluate,
    );
  }

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
      'interval': interval.inMilliseconds, // 平均間隔時間
      'intervalCount': intervalCount, // 平均間隔時間
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
      'interval': (interval.inMinutes < 0 ? 0 : interval.inMinutes), // 平均間隔時間
      'intervalCount': intervalCount,
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
        avgTime = Duration(milliseconds: (map['avgTime'] ?? 0).round()),
        interval = Duration(
            milliseconds: (map['interval'] ?? 0) < 0
                ? 0
                : (map['interval'] ?? 0).round()),
        intervalCount = map['intervalCount'], // 平均間隔時間
        evaluate = double.parse((map['evaluate'] ?? 0.0).toStringAsFixed(2));

  void aggregate(Summary other) {
    count += other.count;
    totalTime += other.totalTime;
    avgTime += other.avgTime;
    interval += other.interval;
  }

  @override
  String toString() {
    return 'Summary{id: $id, sDate: $sDate, startTime: $startTime, endTime: $endTime, count: $count, frequency: $frequency, totalTime: $totalTime, avgTime: $avgTime, interval: $interval, intervalCount: $intervalCount, evaluate: $evaluate}';
  }
}
