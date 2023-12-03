import 'package:workmanager/workmanager.dart';

import 'AppSettingService.dart';
import 'NotificationService.dart';

class ScheduleManager {
  static final ScheduleManager _instance = ScheduleManager._internal();
  factory ScheduleManager() => _instance;
  ScheduleManager._internal();

  Future<void> initialize() async {
    await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
    final now = DateTime.now();
    var scheduledDate = DateTime(
        now.year, now.month, now.hour < 8 ? now.day : now.day + 1, 8, 0, 0);

    final scheduledTime = scheduledDate.difference(now);

    await Workmanager().registerPeriodicTask(
      "simpleTask", // 任務名稱
      "simpleTask", // 任務標籤
      initialDelay: scheduledTime,
      inputData: <String, dynamic>{
        'languageCode': AppSettingService.getLanguage(),
        // 可以加入更多需要的數據
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
    await NotificationService.instance.showNotifications(languageCode);
    return Future.value(true);
  });
}
