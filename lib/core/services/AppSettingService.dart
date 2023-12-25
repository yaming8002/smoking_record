import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/DateTimeUtil.dart';

class AppSettingService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Locale? getLanguageLocale() {
    String? language = _prefs.getString('language');
    String? region = _prefs.getString('region');
    return language == null ? null : Locale(language, region);
  }

  static Future<void> setLanguageLocale(Locale locale) async {
    await _prefs.setString('language', locale.languageCode);
    await _prefs.setString('region', locale.countryCode ?? "");
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
    int? intervalTime = _prefs.getInt('interval_time');
    intervalTime = intervalTime ?? 6;
    _prefs.setInt('interval_time', intervalTime);
    return Duration(hours: _prefs.getInt('interval_time') ?? 6);
  }

  static Future<void> setIntervalTime(Duration interval) async {
    await _prefs.setInt('interval_time', interval.inHours);
  }

  static Duration getStopTime() {
    int? stopTime = _prefs.getInt('stop_time');
    stopTime = stopTime ?? 0;
    _prefs.setInt('stop_time', stopTime);
    return Duration(minutes: _prefs.getInt('stop_time') ?? 0);
  }

  static Future<void> setStopTime(Duration stopTime) async {
    await _prefs.setInt('stop_time', stopTime.inMinutes);
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
