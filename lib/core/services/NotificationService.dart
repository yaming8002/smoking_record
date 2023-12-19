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

  Future<void> showNotifications(Locale languageCode, [String? testMsg]) async {
    try {
      await S.load(languageCode); // 確保本地化完成
      String text =
          await _getLocalizedKeepItUpMessage(languageCode); // 獲取本地化的消息
      String title = await _getLocalizedAppName(languageCode);
      var platform =
          NotificationDetails(android: androidDetails, iOS: iosDetails);
      await flutterLocalNotificationsPlugin.show(
          0,
          title, // 獲取本地化的應用名稱
          '$text \n ${testMsg ?? ""}',
          platform);
    } catch (e) {
      // 处理异常
      print('Error showing notification: $e');
    }
  }

  Future<String> _getLocalizedKeepItUpMessage(Locale languageCode) async {
    List<String> messages = await _getLocalizedKeepItUpMessages(languageCode);
    var randomIndex = Random().nextInt(messages.length);
    return messages[randomIndex];
  }

  Future<List<String>> _getLocalizedKeepItUpMessages(
      Locale languageCode) async {
    var s = await S.load(languageCode); // 確保本地化資源已加載
    var messages = [
      s.notification_msg1,
      s.notification_msg2,
      s.notification_msg3,
      s.notification_msg4,
    ];
    return messages;
  }

  Future<String> _getLocalizedAppName(Locale languageCode) async {
    var s = await S.load(languageCode);
    return s.appName; // 返回本地化後的應用名稱
  }
}
