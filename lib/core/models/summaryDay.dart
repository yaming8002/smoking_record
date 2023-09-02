class SummaryDay {
  final String sDate;

  final int count;

  final int frequency;
  //  final int avgCount;

  final Duration totalTime;
  final Duration avgTime;
  final Duration spacing;

  final double evaluate;

  SummaryDay(
      this.sDate,
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
      'count': count, // 總抽菸數
      // 'avgCount': avgCount, // 總抽菸數
      'frequency': frequency, // 抽菸次數
      'totalTime': totalTime.inMilliseconds, // 總耗時
      'avgTime': avgTime.inMilliseconds,
      'spacing': spacing.inMilliseconds, // 平均間隔時間
      'evaluate': evaluate, // 平均感受評分
    };
  }

  SummaryDay.fromMap(
    Map<String, dynamic> map,
  )   : sDate = map['sDate'] ?? '-',
        count = map['count'] ?? 0,
        frequency = map['frequency'] ?? 0,
        // avgCount = map['avgCount'],
        totalTime = Duration(milliseconds: map['totalTime'] ?? 0),
        avgTime = Duration(milliseconds: map['avgTime'] ?? 0),
        spacing = Duration(milliseconds: map['spacing'] ?? 0),
        evaluate = double.parse((map['evaluate'] ?? 0.0).toStringAsFixed(2));

  @override
  String toString() {
    return 'summaryDay{sDate: $sDate, count: $count, frequency: $frequency, totalTime: $totalTime, avgTime: $avgTime, spacing: $spacing, evaluate: $evaluate}';
  }
}
