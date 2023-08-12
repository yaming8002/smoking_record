class summaryDay {
  static const index = 'id',
      summaryDate = 'sDate', // 統計日期
      summaryCount = 'count', // 總抽菸數
      summaryFrequency = 'frequency', // 抽菸次數
      summarAvgCount = 'avgCount', // 平均一次抽幾根
      summaryTotalTime = 'totalTime', // 總耗時
      summarAvgTimeBy = 'avgTime', // 平均菸耗時
      summarSpacing = 'spacing', // 平均間隔時間
      summarEvaluate = 'evaluate'; // 平均感受評分

  final int id;

  final String sDate;

  final int count;

  final int frequency;
  final int avgCount;

  final DateTime totalTime;
  final DateTime avgTime;
  final DateTime spacing;

  final int evaluate;

  summaryDay(this.id,this.sDate, this.count, this.frequency, this.avgCount,
      this.totalTime, this.avgTime, this.spacing, this.evaluate);

  Map<String, dynamic> toMap() {
    return {
      index: id,
      summaryDate: sDate, // 統計日期
      summaryCount: count, // 總抽菸數
      summaryFrequency: frequency, // 抽菸次數
      summarAvgCount: avgCount, // 平均一次抽幾根
      summaryTotalTime: totalTime, // 總耗時
      summarAvgTimeBy: avgTime, // 平均菸耗時
      summarSpacing: spacing, // 平均間隔時間
      summarEvaluate: evaluate, // 平均感受評分
    };
  }


}
