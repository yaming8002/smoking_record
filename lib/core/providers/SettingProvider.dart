import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../services/AppSettingService.dart';
import '../services/CsvManager.dart';
import '../services/SmokingSatusService.dart';
import '../services/SummaryService.dart';
import 'notification_service.dart';

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

  Future<void> init() async {
    notion = await NotificationService.instance;
  }

  String get contactAuthor => ""; // 这里可以添加具体的实现
  String get exportDataToCSV => ""; // 这里可以添加具体的实现
  String get importDataFromCSV => ""; // 这里可以添加具体的实现
  String get aboutApp => "null"; // 这里可以添加具体的实现

  String get language => AppSettingService.getLanguage();
  set language(String value) {
    AppSettingService.setLanguage(value);
    notifyListeners();
  }

  bool get dayChangeNotification =>
      AppSettingService.getDayChangeNotification();
  set dayChangeNotification(bool value) {
    AppSettingService.setDayChangeNotification(value);
    notifyListeners();
  }

  bool get recordNotification =>
      AppSettingService.getRecordNotificationTime(); // 这里可以添加具体的实现

  set recordNotification(bool value) {
    AppSettingService.setRecordNotificationTime(value);
    notifyListeners();
  }

  String get timeChange => AppSettingService.getTimeChange();
  set timeChange(String value) {
    AppSettingService.setTimeChange(value);
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

  void exportDataToCsv() {
    csvManager?.exportDataToCsv();
  }

  Future<void> importDataToCsv() async {
    await csvManager!.importCsvAndSaveToDatabase();
    await summaryService.cleanAll();
  }

  Future<void> dataRecount() async {
    await summaryService.cleanAll();
  }

  testnutton() {
    print("測試打應");
    notion?.showNotifications();
  }
}
