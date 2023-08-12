class SmokingStatus {
  int? id;  // 唯一識別碼
  int smokeCount;  // 抽菸的次數
  DateTime smokingStartTime;  // 抽菸的開始時間
  DateTime smokingEndTime;  // 抽菸的結束時間
  int smokingRating;  // 抽菸感受的評分
  Duration totalSmokingTime;  // 抽菸的總時間
  Duration? smokingInterval;  // 抽菸的間隔時間

  SmokingStatus(
      this.id,
      this.smokeCount,
      this.smokingStartTime,
      this.smokingEndTime,
      this.smokingRating,
      this.totalSmokingTime,
      this.smokingInterval,
      );

  // 將對象轉換為 Map 結構，方便儲存到 SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'smokeCount': smokeCount,
      'smokingStartTime': smokingStartTime.toIso8601String(),
      'smokingEndTime': smokingEndTime.toIso8601String(),
      'smokingRating': smokingRating,
      'totalSmokingTime': totalSmokingTime.inMilliseconds,
      'smokingInterval': smokingInterval == null ? null : smokingInterval?.inMilliseconds,
    };
  }

  // 從 Map 結構創建對象，方便從 SQLite 讀取數據
  SmokingStatus.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        smokeCount = map['smokeCount'],
        smokingStartTime = DateTime.parse(map['smokingStartTime']),
        smokingEndTime = DateTime.parse(map['smokingEndTime']),
        smokingRating = map['smokingRating'],
        totalSmokingTime = Duration(milliseconds: map['totalSmokingTime']),
        smokingInterval = Duration(milliseconds: map['smokingInterval'] == null ? 0 : map['smokingInterval']);

  // 返回對象的字符串表示形式，方便調試
  @override
  String toString() {
    return 'SmokingStatusRecord{id: $id, smokeCount: $smokeCount, smokingStartTime: $smokingStartTime, smokingEndTime: '
        '$smokingEndTime, smokingRating: $smokingRating, totalSmokingTime: $totalSmokingTime, smokingInterval: $smokingInterval}';
  }

}