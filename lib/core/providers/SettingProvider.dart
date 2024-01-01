import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../services/AppSettingService.dart';
import '../services/CsvManager.dart';
import '../services/NotificationService.dart';
import '../services/SmokingSatusService.dart';
import '../services/SummaryService.dart';

class SettingsProvider with ChangeNotifier {
  final SmokingSatusService satusService;
  final SummaryService summaryService;
  NotificationService? notion;
  CsvManager? csvManager;

  SettingsProvider(BuildContext context)
      : satusService = Provider.of<SmokingSatusService>(context, listen: false),
        summaryService = Provider.of<SummaryService>(context, listen: false) {
    csvManager = CsvManager(context);
    init();
  }

  void init() {
    notion = NotificationService.instance;
  }

  Locale? get language => AppSettingService.getLanguageLocale();

  bool get dayChangeNotification =>
      AppSettingService.getDayChangeNotification();
  set dayChangeNotification(bool value) {
    AppSettingService.setDayChangeNotification(value);
    notifyListeners();
  }

  Duration get intervalTime => AppSettingService.getIntervalTime();
  set intervalTime(Duration value) {
    AppSettingService.setIntervalTime(value);
    notifyListeners();
  }

  Duration get stopTime => AppSettingService.getStopTime();
  set stopTime(Duration value) {
    AppSettingService.setStopTime(value);
    notifyListeners();
  }

  int get averageSmokingTime => AppSettingService.getAverageSmokingTime();
  set averageSmokingTime(int value) {
    AppSettingService.setAverageSmokingTime(value);
    notifyListeners();
  }

  double get appVersion => AppSettingService.getAppVersion();
  set appVersion(double value) {
    AppSettingService.setAppVersion(value);
    notifyListeners();
  }

  void updateWeekStartMonday(bool newValue) {
    AppSettingService.setIsWeekStartMonday(newValue);
    notifyListeners();
  }

  void exportDataToCsv() {
    csvManager?.exportDataToCsv();
  }

  Future<void> importDataToCsv() async {
    await csvManager!.importCsvAndSaveToDatabase();
  }

  Future<void> dataRecount() async {
    await summaryService.cleanAll();
  }

  testnutton() {
    
    notion?.showNotifications(AppSettingService.getLanguageLocale()!);
  }
}
