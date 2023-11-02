import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../generated/l10n.dart';
import '../models/ReceivedNotification.dart';
import '../models/Summary.dart';
import 'SummaryService.dart';

class NotificationService {
  final SummaryService service;
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // String? changTimeStr = AppSettingService.getTimeChange();

  NotificationService(this.service) {
    init();
  }

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
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(const Duration(days: 1));
    Summary summaryForYesterday = await service.getSummaryDay(yesterday);
    DateTime dayBeforeYesterday = yesterday.subtract(const Duration(days: 1));
    Summary summaryForDayBeforeYesterday =
        await service.getSummaryDay(dayBeforeYesterday);

    int count = summaryForYesterday.count - summaryForDayBeforeYesterday.count;
    String text = "";

    if (count > 0) {
      text = S.current
          .msg_congratulationsReduced(count, yesterday, dayBeforeYesterday);
    } else {
      text = S.current.msg_keepItUp;
    }

    return ReceivedNotification(
      id: 1,
      title: "my app notion",
      body: text,
      payload: null,
    );
  }

  showNotifications() async {
    ReceivedNotification? notion = await _getDataFromDatabase();
    print(notion.toString());
    if (notion != null) {
      var platform = NotificationDetails(android: androidDetails);
      await flutterLocalNotificationsPlugin!
          .show(0, notion.title, notion.body, platform);
      // payload: 'Nitish Kumar Singh is part time Youtuber');
      // payload 用於點擊呼叫其他的功能所以當前可以省略
    }
  }
}
