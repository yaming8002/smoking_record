import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ui/pages/AddPage.dart';
import '../../ui/widgets/input/InterstitialState.dart';
import '../../utils/dateTimeUtil.dart';
import '../models/SmokingStatus.dart';
import '../models/Summary.dart';
import '../services/AppSettingService.dart';
import '../services/DayTimeManager.dart';
import '../services/SmokingSatusService.dart';
import '../services/SummaryService.dart';

class HomePageProvider with ChangeNotifier {
  final SmokingSatusService satusService;
  final SummaryService summaryService;
  Timer? _timer;
  DateTime? _targetTime = AppSettingService.getLastEndTime();
  String timeDiff = "開始記錄";
  Summary? today;
  Summary? yesterday;
  Summary? thisWeek;
  Summary? beforeWeek;
  TimeOfDay? changTime = AppSettingService.getTimeChangeToTimeOfDay();
  String? changTimeStr = AppSettingService.getTimeChange();
  String? imagePath;
  String? message;

  HomePageProvider(BuildContext context)
      : satusService = Provider.of<SmokingSatusService>(context),
        summaryService = Provider.of<SummaryService>(context) {
    loadData();
  }

  Future<void> loadData() async {
    await _reloadTargetTime();
    await _getSummaryDayFromService();
    await _getSummaryWeekFromService();
    timeDiff = "開始記錄";
    startTimer();
    notifyListeners();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      timeDiff = DayTimeManager().isTimeWithin(_targetTime)
          ? DateTimeUtil.formatDuration(DateTime.now().difference(_targetTime!))
          : '00:00:00';

      notifyListeners();
    });
  }

  Future<void> _reloadTargetTime() async {
    DateTime? sqlTime = await satusService.getLastEndTime();
    _targetTime = AppSettingService.getLastEndTime() ?? sqlTime;
    notifyListeners();
  }

  Future<void> _getSummaryDayFromService() async {
    DateTime now = DateTime.now();

    today = await summaryService.getSummary(now);
    yesterday =
        await summaryService.getSummary(now.subtract(const Duration(days: 1)));

    notifyListeners();
  }

  Future<void> _getSummaryWeekFromService() async {
    DateTime now = DateTime.now();

    thisWeek = await summaryService.getSummary(now!, 'SummaryWeek');
    print(thisWeek);
    beforeWeek = await summaryService.getSummary(
        now!.subtract(const Duration(days: 7)), 'SummaryWeek');
    print(beforeWeek);
    notifyListeners();
  }

  Future<void> showAd(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InterstitialAdWidget()),
    );
    // 如果需要在廣告後進行其他操作，您可以在此處進行
  }

  void onNavigateToSecondPage(BuildContext context) async {
    SmokingStatus newStatus = SmokingStatus(
        null,
        1,
        DateTime.now(),
        DateTime.now(),
        0,
        DateTime.now().difference(DateTime.now()),
        _targetTime == null ? null : DateTime.now().difference(_targetTime!));
    if (!AppSettingService.getisStopAd()) {
      await showAd(context);
    }
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddPage(status: newStatus)));

    await loadData();
    notifyListeners();
  }
}
