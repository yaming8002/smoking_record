import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../generated/l10n.dart';
import '../../utils/dateTimeUtil.dart';
import '../models/ReceivedNotification.dart';
import '../models/summaryDay.dart';
import 'AppSettingService.dart';
import 'SummaryService.dart';

class NotificationService {
  final SummaryService service;
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String? changTimeStr = AppSettingService.getTimeChange();

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
      id: 1,
      title: "my app notion",
      body: text,
      payload: null,
    );
  }

  // 設定定時執行的功能
  // Future<void> scheduleDailyNotification() async {
  //   var time = Time(10, 0, 0); // 每天上午10點
  //
  //   var platformDetails = NotificationDetails(android: android);
  //
  //   await flutterLocalNotificationsPlugin!.showDailyAtTime(
  //     1, // 通知的ID
  //     '定期通知', // 通知的標題
  //     '這是每天上午10點的通知', // 通知的內容
  //     time,
  //     platformDetails,
  //   );
  // }

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
