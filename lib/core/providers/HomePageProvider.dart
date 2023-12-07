import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../ui/pages/AddPage.dart';
import '../../ui/widgets/input/InterstitialState.dart';
import '../../utils/dateTimeUtil.dart';
import '../models/PageTextSizes.dart';
import '../models/SmokingStatus.dart';
import '../models/Summary.dart';
import '../services/AppSettingService.dart';
import '../services/NotificationService.dart';
import '../services/SmokingSatusService.dart';
import '../services/SummaryService.dart';

class HomePageProvider with ChangeNotifier, WidgetsBindingObserver {
  final SmokingSatusService satusService;
  final SummaryService summaryService;
  Timer? _timer;
  DateTime? _targetTime = AppSettingService.getLastEndTime();
  String timeDiff = "";
  Summary? today;
  Summary? yesterday;
  Summary? thisWeek;
  Summary? beforeWeek;
  Duration interval = AppSettingService.getIntervalTime();
  String? imagePath;
  String? message;
  Color CircleColor = Colors.red;
  PageTextSizes? szieMap;
  NotificationService? notion;

  HomePageProvider(BuildContext context)
      : satusService = Provider.of<SmokingSatusService>(context),
        summaryService = Provider.of<SummaryService>(context) {
    WidgetsBinding.instance!.addObserver(this);
    loadData();
    szieMap = PageTextSizes();
    notifyListeners();
  }

  Future<void> loadData() async {
    // await _reloadTargetTime();
    await _getSummaryDayFromService();
    await _getSummaryWeekFromService();
    print("check reload");
    print(today.toString());
    upgroupTimeDiff();
    startTimer();
    notifyListeners();
  }

  void startTimer() {
    _timer?.cancel(); // 确保取消之前的定时器
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      upgroupTimeDiff();
    });
  }

  void upgroupTimeDiff() {
    _targetTime = AppSettingService.getLastEndTime();
    DateTime now = DateTime.now();
    Duration diff = now.difference(_targetTime ?? now);
    Duration interval = AppSettingService.getIntervalTime();

    if (diff.inMilliseconds > 0 && interval.inMinutes > 0 && diff < interval) {
      timeDiff =
          S.current.home_interval(DateTimeUtil.formatDuration(interval - diff));
      CircleColor = Colors.grey;
    } else if (diff.inMilliseconds > 0) {
      timeDiff = DateTimeUtil.formatDuration(diff);
      CircleColor = Colors.red;
    } else {
      timeDiff = S.current.home_start;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _getSummaryDayFromService() async {
    DateTime now = DateTime.now();

    today = await summaryService.getSummaryDay(now);
    yesterday = await summaryService
        .getSummaryDay(now.subtract(const Duration(days: 1)));

    notifyListeners();
  }

  Future<void> _getSummaryWeekFromService() async {
    DateTime now = DateTime.now();

    thisWeek = await summaryService.getSummaryWeek(now!);
    beforeWeek = await summaryService
        .getSummaryWeek(now!.subtract(const Duration(days: 7)));
    notifyListeners();
  }

  Future<void> showAd(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InterstitialAdWidget()),
    );
    // 如果需要在廣告後進行其他操作，您可以在此處進行
  }

  Future<void> onNavigateToSecondPage(BuildContext context) async {
    SmokingStatus newStatus = SmokingStatus(
        null,
        1,
        DateTime.now(),
        DateTime.now(),
        0,
        DateTime.now().difference(DateTime.now()),
        _targetTime == null
            ? Duration.zero
            : DateTime.now().difference(_targetTime!));
    // if (!AppSettingService.getisStopAd()) {
    //   await showAd(context);
    // }
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddPage(status: newStatus)));

    await loadData();
    notifyListeners();
  }
}
