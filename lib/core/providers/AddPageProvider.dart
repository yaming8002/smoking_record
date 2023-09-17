import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smoking_record/utils/dateTimeUtil.dart';

import '../../generated/l10n.dart';
import '../../ui/widgets/input/InterstitialState.dart';
import '../models/SmokingStatus.dart';
import '../services/AppSettingService.dart';
import '../services/SmokingSatusService.dart';
import '../services/SummaryService.dart';

class AddPageProvider with ChangeNotifier {
  final SmokingSatusService service;
  final SummaryService summaryService;
  final SmokingStatus status;
  final InterstitialAdWidget _interstitialAdWidget =
      const InterstitialAdWidget();

  double cardWidth = 200; // Adjust as needed
  double cardHeight = 100; // Adjust as needed
  List<int> ratings = [1, 2, 3, 4, 5];
  String timeDiff = "00:00:00";
  Timer? _timer;

  AddPageProvider(BuildContext context, this.status)
      : service = Provider.of<SmokingSatusService>(context),
        summaryService = Provider.of<SummaryService>(context) {
    loadData();
  }

  Future<void> loadData() async {
    startTimer();
    _interstitialAdWidget;
    notifyListeners();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      Duration duration =
          DateTime.now().difference(status!.startTime); // 增加1秒到持續時間
      timeDiff = DateTimeUtil.formatDuration(duration);
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
      if (status.endTime.isAfter(DateTime.now())) {
        onError!(S.current.msg_endTimeFutureError);
        return;
      }
      status.totalTime = Duration(seconds: totalSmokingTimeInSeconds);
      status.endTime = status.startTime.add(status.totalTime);
    } else {
      status.endTime = DateTime.now();
      status.totalTime = status.endTime.difference(status.startTime);
    }

    AppSettingService.setLastEndTime(status.endTime);
    await service.insertSmokingStatus(status.toMap());
    await summaryService?.updateSummaryDay(DateTimeUtil.getNowDate());
  }
}
