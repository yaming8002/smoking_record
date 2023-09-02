import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ui/pages/AddPage.dart';
import '../../utils/dateTimeUtil.dart';
import '../models/SmokingStatus.dart';
import '../models/summaryDay.dart';
import '../services/AppSettingService.dart';
import '../services/SmokingSatusService.dart';

class HomePageProvider with ChangeNotifier {
  final SmokingSatusService service;
  Timer? _timer;
  DateTime? _targetTime;
  String timeDiff = "00:00:00";
  SummaryDay? today;
  SummaryDay? yesterday;
  SummaryDay? thisWeek;
  SummaryDay? beforeWeek;
  TimeOfDay? changTime = AppSettingService.getTimeChangeToTimeOfDay();

  HomePageProvider(BuildContext context)
      : service = Provider.of<SmokingSatusService>(context) {
    loadData();
  }

  Future<void> loadData() async {
    await _getDayTotalNumFromService();
    await _getWeekTotalNumFromService();
    startTimer();
    notifyListeners();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (DateTimeUtil.compareTime(TimeOfDay.now(), changTime!)) {
        _reloadTargetTime();
      }

      timeDiff = _targetTime == null
          ? '00:00:00'
          : DateTimeUtil.formatDuration(
              DateTime.now().difference(_targetTime!));

      notifyListeners();
    });
  }

  Future<void> _reloadTargetTime() async {
    _targetTime = await service.getLastEndTime();
  }

  Future<void> _getDayTotalNumFromService() async {
    String todayDate = DateTimeUtil.getDateWithDayChangeTime();
    today = await service.getDayTotalNum(todayDate);
    yesterday = await service.getDayTotalNum(
        DateTimeUtil.getDate(DateTimeUtil.getYesterday(today: todayDate)));

    notifyListeners();
  }

  Future<void> _getWeekTotalNumFromService() async {
    DateTime now = DateTime.now();

    thisWeek = await service.getWeekTotalNum();
    beforeWeek =
        await service.getWeekTotalNum(now!.subtract(Duration(days: 7)));

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
    await _getDayTotalNumFromService();
    await _getWeekTotalNumFromService();
  }
}
