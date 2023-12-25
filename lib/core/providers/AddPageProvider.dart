import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../utils/DateTimeUtil.dart';
import '../../utils/ReferenceBool.dart';
import '../models/SmokingStatus.dart';
import '../services/AppSettingService.dart';
import '../services/SmokingSatusService.dart';
import '../services/SummaryService.dart';

class AddPageProvider with ChangeNotifier {
  final SmokingSatusService service;
  final SummaryService summaryService;
  SmokingStatus? status;
  // final InterstitialAdWidget _interstitialAdWidget =
  //     const InterstitialAdWidget();

  double cardWidth = 200; // Adjust as needed
  double cardHeight = 100; // Adjust as needed
  List<int> ratings = [1, 2, 3, 4, 5];
  String timeDiff = "00:00:00";
  Timer? _timer;
  ReferenceBool startBaseswitch = ReferenceBool(false);
  ReferenceBool endBaseswitch = ReferenceBool(false);
  // DateTime endTime = DateTime.now();

  AddPageProvider(BuildContext context, this.status)
      : service = Provider.of<SmokingSatusService>(context),
        summaryService = Provider.of<SummaryService>(context) {
    loadData();
  }

  Future<void> loadData() async {
    startTimer();
    // _interstitialAdWidget;
    notifyListeners();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      status?.endTime = DateTime.now();
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
    status!.count = value;
    notifyListeners();
  }

  insertSmokingStatus(
      {required bool byStart,
      required bool byEnd,
      required SmokingStatus status,
      Function(String)? onError}) async {
    int totalSmokingTimeInSeconds =
        (status.count! * AppSettingService.getAverageSmokingTime());
    if (byStart) {
      status.endTime = status.startTime.add(status.totalTime);
      if (status.endTime.isAfter(DateTime.now())) {
        onError!(S.current.msg_endTimeFutureError);
        return;
      }
      status.totalTime = Duration(seconds: totalSmokingTimeInSeconds);
    } else if (byEnd) {
      status.totalTime = Duration(seconds: totalSmokingTimeInSeconds);
      status.startTime = status.endTime.subtract(status.totalTime);
    } else {
      status.totalTime = status.endTime.difference(status.startTime);
    }

    AppSettingService.setLastEndTime(status.endTime);
    await service.insertSmokingStatus(status.toMap());

    await summaryService?.generateSummaries({status.endTime});
  }
}
