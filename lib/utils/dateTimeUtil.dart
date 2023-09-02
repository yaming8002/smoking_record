import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core/services/AppSettingService.dart';

class DateTimeUtil {
  static const String dateFormat = "yyyy-MM-dd";
  static const String TimeFormat = "hh:mm:ss";
  static const String MinuteFormat = "hh:mm";
  static const String dateTimeFormat = "yyyy-MM-dd hh:mm:ss";

  /// 格式化Duration為時:分:秒
  static String formatDuration(Duration d) {
    String hours = d.inHours.remainder(24).toString().padLeft(2, '0');
    String minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  /// 獲取格式化的日期
  static String getDate([DateTime? date, String? format]) {
    date = date ?? DateTime.now();
    return DateFormat(format ?? dateFormat).format(date);
  }

  /// 根據日更換時間獲取格式化的日期
  static String getDateWithDayChangeTime([DateTime? date, String? format]) {
    date = date ?? DateTime.now();
    format = format ?? dateFormat;
    String dayChangeTime =
        AppSettingService.getTimeChange() ?? '00:00'; // Default to midnight

    final currentTime = TimeOfDay.fromDateTime(date);
    final parsedDayChangeTime =
        TimeOfDay.fromDateTime(DateFormat('HH:mm').parse(dayChangeTime));

    if (currentTime.hour < parsedDayChangeTime.hour ||
        (currentTime.hour == parsedDayChangeTime.hour &&
            currentTime.minute < parsedDayChangeTime.minute)) {
      final yesterday = date.subtract(Duration(days: 1));
      return DateFormat(format).format(yesterday);
    }
    return DateFormat(format).format(date);
  }

  /// 獲取昨天的日期
  static DateTime getYesterday({String? today, String? format}) {
    DateTime todayDateTime =
        today == null ? DateTime.now() : DateTime.parse(today);
    return todayDateTime.subtract(const Duration(days: 1));
  }

  /// 獲取格式化的時間
  static String getTime({DateTime? date, TimeOfDay? time, String? format}) {
    date = date ?? DateTime.now();
    time = time ?? TimeOfDay.fromDateTime(date);
    DateTime combinedDateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    return DateFormat(format ?? TimeFormat).format(combinedDateTime);
  }

  /// 將時間字符串解析為TimeOfDay
  static TimeOfDay? parseTime(String timeString) {
    List<String> parts = timeString.split(':');
    if (parts.length < 2) return null;
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  /// 比較兩個TimeOfDay
  static bool compareTime(TimeOfDay a, TimeOfDay b) {
    return (a.hour > b.hour || (a.hour == b.hour && a.minute > b.minute));
  }

  /// 根據ISO日期格式獲取格式化的日期時間
  static String? StrDateByformat([String? isoDate, String? format]) {
    if (isoDate == null) {
      return null;
    }
    DateTime parsedDate = DateTime.parse(isoDate);
    return DateFormat(dateTimeFormat).format(parsedDate);
  }

  /// 獲取一周的日期範圍
  static List<String> getWeekDateRange([DateTime? now]) {
    return _getDateRange(now, 7);
  }

  /// 獲取一天的日期範圍
  static List<String> getOneDateRange([DateTime? now]) {
    return _getDateRange(now, 1);
  }

  /// 獲取日期範圍的私有方法
  static List<String> _getDateRange(DateTime? now, int days) {
    now ??= DateTime.now();
    String timeChange = AppSettingService.getTimeChange();
    String formattedStartOfWeekDate = DateFormat("yyyy-MM-dd").format(now);

    DateTime startDateTime =
        DateTime.parse('$formattedStartOfWeekDate $timeChange');
    DateTime endDateTime = startDateTime.add(Duration(days: days));

    List<String> list = [
      DateFormat(dateTimeFormat).format(startDateTime),
      DateFormat(dateTimeFormat).format(endDateTime)
    ];

    return list;
  }
}
