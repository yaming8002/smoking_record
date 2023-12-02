import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/dateTimeUtil.dart';

class AppSettingService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Language
  static String getLanguage() {
    return _prefs.getString('language') ?? 'en';
  }

  static Future<void> setLanguage(String language) async {
    await _prefs.setString('language', language);
  }

  static Locale getLanguageLocale() {
    String? language = _prefs.getString('language');
    if (language == 'zh') {
      return const Locale('zh', 'CN');
    } else if (language == 'zh_TW') {
      return const Locale('zh', 'TW');
    }
    return const Locale('en', 'US');
  }

  // Last End Time
  static DateTime? getLastEndTime() {
    String? lastEndTime = _prefs.getString('lastEndTime');
    return lastEndTime != null ? DateTime.parse(lastEndTime) : null;
  }

  static Future<void> setLastEndTime(DateTime? datetime) async {
    String dateStr =
        DateTimeUtil.getDate(datetime, DateTimeUtil.dateTimeFormat);
    await _prefs.setString('lastEndTime', dateStr);
  }

  // Last Status Time
  static DateTime getLastStatusTime() {
    String? lastTime = _prefs.getString('last_status_time');
    return lastTime != null ? DateTime.parse(lastTime) : DateTime.now();
  }

  static Future<void> setLastStatusTime(DateTime endtime) async {
    await _prefs.setString('last_status_time', endtime.toIso8601String());
  }

  // Interval Time
  static Duration getIntervalTime() {
    return Duration(minutes: _prefs.getInt('interval_time') ?? 0);
  }

  static Future<void> setIntervalTime(Duration interval) async {
    await _prefs.setInt('interval_time', interval.inMinutes);
  }

  // Average Smoking Time
  static int getAverageSmokingTime() {
    return _prefs.getInt('average_smoking_time') ?? 300;
  }

  static Future<void> setAverageSmokingTime(int averageSmokingTime) async {
    await _prefs.setInt('average_smoking_time', averageSmokingTime);
  }

  // Week Start Day
  static bool getIsWeekStartMonday() {
    return _prefs.getBool('isWeekStartMonday') ?? false;
  }

  static Future<void> setIsWeekStartMonday(bool isWeekStartMonday) async {
    await _prefs.setBool('isWeekStartMonday', isWeekStartMonday);
  }

  // Advertisement
  static bool getIsStopAd() {
    return _prefs.getBool('isStopAd') ?? false;
  }

  static Future<void> setIsStopAd(bool isStopAd) async {
    await _prefs.setBool('isStopAd', isStopAd);
  }

  // Day Change Notification
  static bool getDayChangeNotification() {
    return _prefs.getBool('dayChangeNotification') ?? false;
  }

  static Future<void> setDayChangeNotification(
      bool dayChangeNotification) async {
    await _prefs.setBool('dayChangeNotification', dayChangeNotification);
  }

  // Record Notification Time
  static bool getRecordNotificationTime() {
    return _prefs.getBool('recordNotificationTime') ?? true;
  }

  static Future<void> setRecordNotificationTime(
      bool recordNotificationTime) async {
    await _prefs.setBool('recordNotificationTime', recordNotificationTime);
  }

  // App Version
  static double getAppVersion() {
    return _prefs.getDouble('app_version') ?? 0.1;
  }

  static Future<void> setAppVersion(double appVersion) async {
    await _prefs.setDouble('app_version', appVersion);
  }
}
