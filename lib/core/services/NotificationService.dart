import 'dart:io' show Platform;
import 'dart:math';
import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../generated/l10n.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static NotificationService get instance => _instance;

  final androidDetails = const AndroidNotificationDetails(
    'reminders_channel_id',
    'Reminders',
    importance: Importance.high,
    priority: Priority.high,
  );

  final iosDetails = const DarwinNotificationDetails();

  NotificationService._internal() {
    _initializeNotifications();
  }

  void _initializeNotifications() async {
    if (Platform.isAndroid) {
      var channel = const AndroidNotificationChannel(
        'reminders_channel_id',
        'Reminders',
        description: 'Notifications for reminders',
        importance: Importance.max,
      );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }

    if (Platform.isIOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }

    var initializationSettings = const InitializationSettings(
      android: AndroidInitializationSettings('img'),
      // F:\smokingRecord\smoking_record\android\app\src\main\res\mipmap-xxxhdpi\ic_launcher.png
      iOS: DarwinInitializationSettings(),
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotifications(String languageCode, [String? testMsg]) async {
    await initializeLocalization(languageCode); // 確保本地化完成
    String text = await _getLocalizedKeepItUpMessage(languageCode); // 獲取本地化的消息
    var platform =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    await flutterLocalNotificationsPlugin.show(
        0,
        await _getLocalizedAppName(languageCode), // 獲取本地化的應用名稱
        '$text \n ${testMsg ?? ""}',
        platform);
  }

  Future<void> initializeLocalization(String languageCode) async {
    var locale = Locale(languageCode);
    await S.load(locale); // 加載本地化資源
  }

  Future<String> _getLocalizedKeepItUpMessage(String languageCode) async {
    List<String> messages = await _getLocalizedKeepItUpMessages(languageCode);
    var randomIndex = Random().nextInt(messages.length);
    return messages[randomIndex];
  }

  Future<List<String>> _getLocalizedKeepItUpMessages(
      String languageCode) async {
    var s = await S.load(Locale(languageCode)); // 確保本地化資源已加載
    var messages = [
      s.notification_msg1,
      s.notification_msg2,
      s.notification_msg3,
      s.notification_msg4,
    ];
    return messages;
  }

  Future<String> _getLocalizedAppName(String languageCode) async {
    var s = await S.load(Locale(languageCode));
    return s.appName; // 返回本地化後的應用名稱
  }
}
