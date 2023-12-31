import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core/services/AppSettingService.dart';

class DateTimeUtil {
  static const String dateFormat = "yyyy-MM-dd";
  static const String TimeFormat = "HH:mm:ss";
  static const String MinuteFormat = "HH:mm";
  static const String dateTimeFormat = "yyyy-MM-dd HH:mm:ss";
  static const String dateTimeFormatTotal = "yyyy-MM-dd HH:mm:ss.SSS";
  static const String hideyear = "MM-dd HH:mm";

  /// 格式化Duration為時:分:秒
  static String formatDuration(Duration d) {
    String hours = d.inHours.remainder(24).toString().padLeft(2, '0');
    String minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  /// 格式化Duration為時:分
  static String formatDurationMinutes(Duration d) {
    String hours = d.inHours.remainder(24).toString().padLeft(2, '0');
    String minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    // String seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    // return '$hours:$minutes:$seconds';
    return '$hours:$minutes';
  }

  /// 獲取格式化的時間
  static String getDateTimeTotal([DateTime? date]) {
    date = date ?? DateTime.now();

    return DateFormat(dateTimeFormatTotal).format(date);
  }

  /// 獲取格式化的時間
  static String getDateTime([DateTime? date, String? format]) {
    date = date ?? DateTime.now();

    return DateFormat(format ?? dateTimeFormat).format(date);
  }

  /// 獲取格式化的日期
  static String getDate([DateTime? date, String? format]) {
    date = date ?? DateTime.now();
    return DateFormat(format ?? dateFormat).format(date);
  }

  /// 獲取格式化的時間
  static String getTime({DateTime? date, TimeOfDay? time, String? format}) {
    format = format ?? TimeFormat;
    if (date != null) return DateFormat(format).format(date);

    if (time != null) {
      date = DateTime.now();
      DateTime timeFromNow =
          DateTime(date.year, date.month, date.day, time.hour, time.minute);
      return DateFormat(format).format(timeFromNow);
    }
    date = DateTime.now();
    return DateFormat(format).format(date);
  }

  /// 獲取昨天的日期
  static DateTime getYesterday([String? today, String? format]) {
    DateTime todayDateTime =
        today == null ? DateTime.now() : DateTime.parse(today);
    return todayDateTime.subtract(const Duration(days: 1));
  }

  static TimeOfDay? parseTimeFromDateTime(DateTime datetime) {
    return TimeOfDay(hour: datetime.hour, minute: datetime.minute);
  }

  /// 將時間字符串解析為TimeOfDay
  static TimeOfDay? parseTimeFromString(String timeString) {
    try {
      DateTime parsedDateTime = DateTime.parse(timeString);
      return parseTimeFromDateTime(parsedDateTime);
    } catch (e) {
      return null;
    }
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

  static List<DateTime> getOneDateRange([DateTime? now]) {
    now = now ?? DateTime.now();
    // Create a new DateTime at the beginning of the day (midnight)
    DateTime startDateTime = DateTime(now.year, now.month, now.day, 0, 0, 0, 0);

    // Create a new DateTime at the very end of the day, just one millisecond before the next day
    DateTime endDateTime =
        DateTime(now.year, now.month, now.day, 23, 59, 59, 999);

    return [startDateTime, endDateTime];
  }

  static List<DateTime> getWeekRange([DateTime? now]) {
    now = now ?? DateTime.now();
    bool? isWeekStartMonday = AppSettingService.getIsWeekStartMonday() ?? false;
    DateTime startDate;
    DateTime endDate;

    if (isWeekStartMonday) {
      // 找到最近的星期一
      startDate = now.subtract(Duration(days: now.weekday - 1));
      // 找到最近的星期日
      endDate = startDate.add(const Duration(days: 6));
    } else {
      // 找到最近的星期日
      startDate = now.subtract(Duration(days: now.weekday % 7));
      // 找到最近的星期六
      endDate = startDate.add(const Duration(days: 6));
    }

    startDate =
        DateTime(startDate.year, startDate.month, startDate.day, 0, 0, 0, 0);

    // Create a new DateTime at the very end of the day, just one millisecond before the next day
    endDate =
        DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59, 999);

    return [startDate, endDate];
  }

  static List<DateTime> getRange(DateTime startDate, DateTime endDate) {
    bool? isWeekStartMonday = AppSettingService.getIsWeekStartMonday() ?? false;

    startDate =
        DateTime(startDate.year, startDate.month, startDate.day, 0, 0, 0, 0);

    // Create a new DateTime at the very end of the day, just one millisecond before the next day
    endDate =
        DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59, 999);

    return [startDate, endDate];
  }

  /// 日期比較
  static bool isSameDay(DateTime? a, DateTime? b) {
    final date1 = getDate(a);
    final date2 = getDate(b);
    return date1 == date2;
  }
}
