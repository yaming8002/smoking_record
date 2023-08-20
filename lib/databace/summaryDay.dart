class summaryDay {
  final String sDate;

  final int count;

  final int frequency;
 //  final int avgCount;

  final Duration totalTime;
  final Duration avgTime;
  final Duration spacing;

  final double evaluate;

  summaryDay(
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


  summaryDay.fromMap(Map<String, dynamic> map, )
      : sDate = map['sDate'],
        count = map['count'],
        frequency = map['frequency'],
        // avgCount = map['avgCount'],
        totalTime = Duration(milliseconds: map['totalTime']),
        avgTime = Duration(milliseconds: map['avgTime']),
        spacing = Duration(milliseconds: map['spacing']),
        evaluate = double.parse(map['evaluate'].toStringAsFixed(2)) ;

  @override
  String toString() {
    return 'summaryDay{sDate: $sDate, count: $count, frequency: $frequency, totalTime: $totalTime, avgTime: $avgTime, spacing: $spacing, evaluate: $evaluate}';
  }

}
