import 'AppSettingService.dart';

class DayTimeManager {
  static final DayTimeManager _instance = DayTimeManager._internal();
  DateTime? _startTime;
  DateTime? _endTime;

  factory DayTimeManager() {
    return _instance;
  }

  DayTimeManager._internal();

  void initialize() {
    _setDayTimesBasedOn(AppSettingService.getTimeChange());
  }

  DateTime get startTime => _startTime!;
  DateTime get endTime => _endTime!;

  void updateTimesBasedOnChangeTime([String? changeTime]) {
    if (changeTime != null) {
      AppSettingService.setTimeChange(changeTime);
    }
    _setDayTimesBasedOn(AppSettingService.getTimeChange());
  }

  void _setDayTimesBasedOn(String changeTime) {
    DateTime now = DateTime.now();
    DateTime lastChangeTime = DateTime(now.year, now.month, now.day).add(
        Duration(
            hours: int.parse(changeTime.split(':')[0]),
            minutes: int.parse(changeTime.split(':')[1])));

    if (now.isBefore(lastChangeTime)) {
      _startTime = lastChangeTime.subtract(Duration(days: 1));
      _endTime = lastChangeTime;
    } else {
      _startTime = lastChangeTime;
      _endTime = lastChangeTime.add(Duration(days: 1));
    }
  }

  bool isTimeWithin(DateTime? inputTime) {
    if (inputTime == null) {
      return false;
    }
    return inputTime.isAfter(_startTime!) && inputTime.isBefore(_endTime!);
  }
}
