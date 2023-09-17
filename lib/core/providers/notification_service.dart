import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../generated/l10n.dart';
import '../../utils/dateTimeUtil.dart';
import '../models/ReceivedNotification.dart';
import '../models/summaryDay.dart';
import '../services/AppSettingService.dart';
import '../services/DatabaseManager.dart';
import '../services/SummaryService.dart';

class NotificationService {
  final SummaryService service;
  static NotificationService? _instance;

  // 获取单例实例
  static Future<NotificationService> get instance async {
    if (_instance == null) {
      final dbManager = DatabaseManager(await DatabaseManager.initDB());
      final summaryService = SummaryService(dbManager);
      _instance = NotificationService._internal(summaryService);
    }
    return _instance!;
  }

  NotificationService._internal(this.service) {
    init();
  }

  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String? changTimeStr = AppSettingService.getTimeChange();

  var androidDetails = const AndroidNotificationDetails(
    'SmokingApp',
    'SmokingApp',
    importance: Importance.high,
    priority: Priority.high,
  );

  void init() async {
    flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestPermission();
    const AndroidInitializationSettings android =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: android);

    flutterLocalNotificationsPlugin!.initialize(initializationSettings);
  }

  Future<ReceivedNotification?> _getDataFromDatabase() async {
    String yesterday = DateTimeUtil.getDate(DateTimeUtil.getYesterday());
    SummaryDay summaryForYesterday = await service.getDayTotalNum(yesterday);

    String dayBeforeYesterday =
        DateTimeUtil.getDate(DateTimeUtil.getYesterday(today: yesterday));
    SummaryDay summaryForDayBeforeYesterday =
        await service.getDayTotalNum(dayBeforeYesterday);

    int count = summaryForYesterday.count - summaryForDayBeforeYesterday.count;
    String text = "";

    if (count > 0) {
      text = S.current
          .msg_congratulationsReduced(count, yesterday, dayBeforeYesterday);
    } else {
      text = S.current.msg_keepItUp;
    }

    return ReceivedNotification(
      id: Random().nextInt(1000),
      title: "my app notion",
      body: text,
      payload: null,
    );
  }

  tz.TZDateTime _nextInstanceOfTimeChange() {
    List<String> changeTimeParts = AppSettingService.getTimeChange().split(":");
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month,
        now.day, int.parse(changeTimeParts[0]), int.parse(changeTimeParts[1]));
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  showNotifications() async {
    ReceivedNotification? notion = await _getDataFromDatabase();
    if (notion != null) {
      var platform = NotificationDetails(android: androidDetails);
      await flutterLocalNotificationsPlugin!
          .show(0, notion.title, notion.body, platform);
      // payload: 'Nitish Kumar Singh is part time Youtuber');
      // payload 用於點擊呼叫其他的功能所以當前可以省略
    }
  }
}
