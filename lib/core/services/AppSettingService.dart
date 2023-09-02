import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String getLanguage() {
    return _prefs.getString('language') ?? '中文';
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
}
