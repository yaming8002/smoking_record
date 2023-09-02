import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smoking_record/utils/dateTimeUtil.dart';

import '../models/SmokingStatus.dart';
import '../services/AppSettingService.dart';
import '../services/SmokingSatusService.dart';

class AddPageProvider with ChangeNotifier {
  final SmokingSatusService service;
  final SmokingStatus status;
  double cardWidth = 200; // Adjust as needed
  double cardHeight = 100; // Adjust as needed
  List<int> ratings = [1, 2, 3, 4, 5];
  String timeDiff = "00:00:00";
  Timer? _timer;
  Duration _duration = Duration.zero; // 初始的持續時間

  AddPageProvider(BuildContext context, this.status)
      : service = Provider.of<SmokingSatusService>(context) {
    loadData();
  }

  Future<void> loadData() async {
    notifyListeners();
    startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 這裡可以安全地顯示對話框或進行其他UI操作
      // _showAdv();
    });
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _duration = _duration + Duration(seconds: 1); // 增加1秒到持續時間
      timeDiff = DateTimeUtil.formatDuration(_duration);
      notifyListeners();
    });
  }

  // 確保在析構函數中取消計時器
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  set count(int value) {
    status.count = value;
    notifyListeners();
  }

  insertSmokingStatus(
      {required bool isByCount,
      required SmokingStatus status,
      Function(String)? onError}) async {
    if (isByCount) {
      int totalSmokingTimeInSeconds =
          (status.count! * AppSettingService.getAverageSmokingTime());
      status.totalTime = Duration(seconds: totalSmokingTimeInSeconds);
      status.endTime = status.startTime.add(status.totalTime);
      if (status.endTime.isAfter(DateTime.now())) {
        onError!('End time cannot be in the future!');
        return;
      }
    } else {
      status.endTime = DateTime.now();
      status.totalTime = DateTime.now().difference(status.startTime);
    }

    service.insertSmokingStatus(status.toMap());
  }
}
