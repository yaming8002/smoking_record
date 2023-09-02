import 'package:flutter/foundation.dart';

import '../services/AppSettingService.dart';

class SettingsProvider with ChangeNotifier {
  // No need for the init method here since AppSettings is already initialized in main

  String get language => AppSettingService.getLanguage();

  get contactAuthor => "";

  get exportDataToCSV => "";

  get dayChangeNotification => true;

  get recordNotification => true;

  // String get aboutApp => null;

  get importDataFromCSV => "";

  get aboutApp => "null";

  set recordNotificationTime(String recordNotificationTime) {}
  set language(String value) {
    AppSettingService.setLanguage(value);
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
}
