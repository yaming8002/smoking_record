import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:workmanager/workmanager.dart';

import '../../utils/DateTimeUtil.dart';
import 'AppSettingService.dart';
import 'NotificationService.dart';

class ScheduleManager {
  ScheduleManager._privateConstructor();
  static final ScheduleManager _instance =
      ScheduleManager._privateConstructor();
  static ScheduleManager get instance => _instance;

  factory ScheduleManager() {
    return _instance;
  }

  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await cancelTask();
    await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
    await scheduleNextTask();
  }

  Future<void> scheduleNextTask() async {
    final now = DateTime.now();
    var scheduledDate = DateTime(
        now.year, now.month, now.hour < 8 ? now.day : now.day + 1, 8, 0, 0);

    final scheduledTime = scheduledDate.difference(now);
    final scheduledTime_test = const Duration(minutes: 20);
    await Workmanager().registerOneOffTask(
      "1",
      "smoking_notification",
      initialDelay: scheduledTime_test,
      tag: "apifetchtag",
      inputData: <String, dynamic>{
        'languageCode': AppSettingService.getLanguageLocale(),
        'now': DateTimeUtil.getDateTime(now), // test
        'scheduledDate': DateTimeUtil.getDateTime(scheduledDate), // test
        'scheduledTime': DateTimeUtil.formatDuration(scheduledTime), // test
      },
    );
  }

  Future<void> cancelTask() async {
    await Workmanager().cancelAll();
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      Locale languageCode = inputData!['languageCode'];
      await NotificationService.instance.showNotifications(languageCode);
      await ScheduleManager.instance.scheduleNextTask();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return Future.value(true);
  });
}
