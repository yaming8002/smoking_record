import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ui/pages/AddPage.dart';
import '../../utils/dateTimeUtil.dart';
import '../models/SmokingStatus.dart';
import '../models/summaryDay.dart';
import '../services/AppSettingService.dart';
import '../services/DayTimeManager.dart';
import '../services/SmokingSatusService.dart';
import '../services/SummaryService.dart';
import '../services/notification_service.dart';

class HomePageProvider with ChangeNotifier {
  final SmokingSatusService satusService;
  final SummaryService summaryService;
  final NotificationService notion;
  Timer? _timer;
  DateTime? _targetTime = AppSettingService.getLastEndTime();
  String timeDiff = "00:00:00";
  SummaryDay? today;
  SummaryDay? yesterday;
  SummaryDay? thisWeek;
  SummaryDay? beforeWeek;
  TimeOfDay? changTime = AppSettingService.getTimeChangeToTimeOfDay();
  String? changTimeStr = AppSettingService.getTimeChange();

  HomePageProvider(BuildContext context)
      : satusService = Provider.of<SmokingSatusService>(context),
        summaryService = Provider.of<SummaryService>(context),
        notion = Provider.of<NotificationService>(context) {
    loadData();
  }

  Future<void> loadData() async {
    await _reloadTargetTime();
    await _getDayTotalNumFromService();
    await _getWeekTotalNumFromService();
    timeDiff = "00:00:00";
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

  Future<void> _getDayTotalNumFromService() async {
    DateTime todayDate = DateTimeUtil.getStartDateTime(
        DateTimeUtil.getDateTime(), changTimeStr!);
    String todayStr = DateTimeUtil.getDate(todayDate);
    today = await summaryService.getDayTotalNum(todayStr);
    yesterday = await summaryService.getDayTotalNum(
        DateTimeUtil.getDate(DateTimeUtil.getYesterday(today: todayStr)));

    notifyListeners();
  }

  Future<void> _getWeekTotalNumFromService() async {
    DateTime now = DateTime.now();

    thisWeek = await summaryService.getWeekTotalNum(now!);
    beforeWeek =
        await summaryService.getWeekTotalNum(now!.subtract(Duration(days: 7)));

    notifyListeners();
  }

  void onNavigateToSecondPage(BuildContext context) async {
    SmokingStatus newStatus = SmokingStatus(
        null,
        1,
        DateTime.now(),
        DateTime.now(),
        3,
        DateTime.now().difference(DateTime.now()),
        _targetTime == null ? null : DateTime.now().difference(_targetTime!));
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddPage(status: newStatus)));

    await loadData();
    notifyListeners();
  }

  testnutton() {
    print("測試打應");
    notion.showNotifications();
  }
}
