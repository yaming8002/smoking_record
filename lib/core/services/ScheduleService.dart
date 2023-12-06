import 'package:smoking_record/utils/DateTimeUtil.dart';
import 'package:workmanager/workmanager.dart';

import 'AppSettingService.dart';
import 'NotificationService.dart';

class ScheduleManager {
  static final ScheduleManager _instance = ScheduleManager._internal();
  factory ScheduleManager() => _instance;
  ScheduleManager._internal();

  Future<void> initialize() async {
    await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
    final now = DateTime.now();
    var scheduledDate = DateTime(
        now.year, now.month, now.hour < 3 ? now.day : now.day + 1, 2, 30, 0);

    final scheduledTime = scheduledDate.difference(now);

    await Workmanager().registerOneOffTask(
      // await Workmanager().registerPeriodicTask(
      "smoking_notification", // 任務名稱
      "smoking_notification", // 任務標籤
      initialDelay: scheduledTime,
      inputData: <String, dynamic>{
        'languageCode': AppSettingService.getLanguage(),
        'now': DateTimeUtil.getDateTime(now),
        'scheduledDate': DateTimeUtil.getDateTime(scheduledDate),
        'scheduledTime': DateTimeUtil.formatDuration(scheduledTime),
      },
    );
  }

  Future<void> cancelTask() async {
    await Workmanager().cancelByTag('simpleTask');
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    String languageCode = inputData!['languageCode'];
    String debugInfo = '';
    debugInfo += 'Debug Info:\n';
    debugInfo += 'now: ${inputData!['now']}\n';
    debugInfo += 'scheduledDate:${inputData!['scheduledDate']}\n';
    debugInfo += 'scheduledTime: ${inputData!['scheduledTime']}\n';
    await NotificationService.instance.showNotifications(languageCode);
    return Future.value(true);
  });
}
