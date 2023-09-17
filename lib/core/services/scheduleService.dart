import 'package:shared_preferences/shared_preferences.dart';
import 'package:smoking_record/core/services/AppSettingService.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:workmanager/workmanager.dart';

import '../providers/notification_service.dart';

class ScheduleManager {
  static final ScheduleManager _instance = ScheduleManager._internal();
  factory ScheduleManager() => _instance;
  ScheduleManager._internal();

  Future<void> initialize() async {
    tz.initializeTimeZones();
    await Workmanager().initialize(callbackDispatcher);
  }

  Future<Duration> _nextInstanceOfCustomTime() async {
    List<String> timeParts = AppSettingService.getTimeChange().split(":");
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate.difference(now);
  }

  Future<void> scheduleTask() async {
    Duration scheduledTime = await _nextInstanceOfCustomTime();
    await Workmanager().registerPeriodicTask(
      'id_unique',
      'simplePeriodicTask',
      frequency: Duration(days: 1),
      initialDelay: scheduledTime,
      inputData: <String, dynamic>{'key': 'value'},
    );
  }

  Future<void> updateTimeChange(String newTime) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('time_change', newTime);

    await cancelTask();
    await scheduleTask();
  }

  Future<void> cancelTask() async {
    await Workmanager().cancelByTag('id_unique');
  }
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    NotificationService notion = await NotificationService.instance;
    notion.showNotifications();
    return Future.value(true);
  });
}
