import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smoking_record/utils/dateTimeUtil.dart';

class AppSettingService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static DateTime? getLastEndTime() {
    String? lastEndTime = _prefs.getString('lastEndTime');

    if (lastEndTime != null) {
      DateTime? dateTime = DateTime.parse(lastEndTime);
      return dateTime;
    }
    return null;
  }

  static Future<void> setLastEndTime(DateTime? datetime) async {
    String dateStr =
        DateTimeUtil.getDate(datetime, DateTimeUtil.dateTimeFormat);
    await _prefs.setString('lastEndTime', dateStr);
  }

  static String getLanguage() {
    return _prefs.getString('language') ?? '中文';
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

  static String getTimeChange() {
    return _prefs.getString('time_change') ?? '07:00';
  }

  static TimeOfDay getTimeChangeToTimeOfDay() {
    String timeString = _prefs.getString('time_change') ?? '07:00';
    List<String> parts = timeString.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  static int getAverageSmokingTime() {
    return _prefs.getInt('average_smoking_time') ?? 300;
  }

  static double getAppVersion() {
    return _prefs.getDouble('app_version') ?? 0.1;
  }

  static bool getIsWeekStartMonday() {
    if (_prefs.getBool('isWeekStartMonday') == null) {
      setIsWeekStartMonday(false);
    }
    return _prefs.getBool('isWeekStartMonday') ?? false;
  }

  static bool getisStopAd() {
    if (_prefs.getBool('isStopAd') == null) {
      setIsStopAd(false);
    }
    return _prefs.getBool('isStopAd') ?? false;
  }

  static bool getDayChangeNotification() {
    if (_prefs.getBool('dayChangeNotification') == null) {
      setDayChangeNotification(false);
    }
    return _prefs.getBool('dayChangeNotification') ?? false;
  }

  static Future<void> setLanguage(String language) async {
    await _prefs.setString('language', language);
  }

  static Future<void> setTimeChange(String timeChange) async {
    await _prefs.setString('time_change', timeChange);
  }

  static Future<void> setAverageSmokingTime(int averageSmokingTime) async {
    await _prefs.setInt('average_smoking_time', averageSmokingTime);
  }

  static Future<void> setAppVersion(double appVersion) async {
    await _prefs.setDouble('app_version', appVersion);
  }

  static Future<void> setIsWeekStartMonday(bool isWeekStartMonday) async {
    await _prefs.setBool('isWeekStartMonday', isWeekStartMonday);
  }

  static Future<void> setIsStopAd(bool isStopAd) async {
    await _prefs.setBool('isStopAd', isStopAd);
  }

  static void setDayChangeNotification(bool dayChangeNotification) async {
    await _prefs.setBool('dayChangeNotification', dayChangeNotification);
  }

  static void setRecordNotificationTime(bool recordNotificationTime) async {
    await _prefs.setBool('recordNotificationTime', recordNotificationTime);
  }

  static getRecordNotificationTime() {
    if (_prefs.getBool('recordNotificationTime') == null) {
      setRecordNotificationTime(true);
    }
    return _prefs.getBool('recordNotificationTime') ?? true;
  }
}
