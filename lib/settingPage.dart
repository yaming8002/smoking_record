
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'SmokingListPage.dart';
import 'databace/DatabaseHelper.dart';

class AppSettings {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String getLanguage() {
    return _prefs.getString('language') ?? '中文';
  }

  static String getTimeChange() {
    return _prefs.getString('time_change') ?? '07:00:00';
  }

  static int getAverageSmokingTime() {
    return _prefs.getInt('average_smoking_time') ?? 300;
  }

  static double getAppVersion() {
    return _prefs.getDouble('app_version') ?? 0.1;
  }

  static Future<void> setLanguage(String language) async {
    await _prefs.setString('language', language);
  }

  static Future<void> setTimeChange(String timeChange) async {
    await _prefs.setString('time_change', timeChange);
  }

  static Future<void> setAverageSmokingTime(int averageSmokingTime) async {
    await _prefs.setInt('average_smoking_time', averageSmokingTime);
  }

  static Future<void> setAppVersion(double appVersion) async {
    await _prefs.setDouble('app_version', appVersion);
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final Database database;
  final TextEditingController _timeChangeController = TextEditingController();
  final TextEditingController _averageSmokingTimeController = TextEditingController();
  String _language = '中文'; // 預設語言
  String _timeChange = '07:00'; // 預設換日時間，24小時制
  int _averageSmokingTime = 300; // 預設抽菸時間，300秒
  double _appVersion = 0.1; // 預設抽菸時間，300秒

  @override
  void initState() {
    super.initState();
    _initializeState();
  }

  void _initializeState() {
    loadSettings();
    DBHelper.database.then((dbInstance) {
      database = dbInstance;
      setState(() {
        // 設定控制器的 text 屬性為預設值
        _timeChangeController.text = _timeChange;
        _averageSmokingTimeController.text = _averageSmokingTime.toString();
      });
    });
  }

  Future<void> loadSettings() async {
    // await AppSettings.init();  // 使用靜態方法
    setState(() {
      _language = AppSettings.getLanguage() ?? _language; // 使用靜態方法
      _timeChange = AppSettings.getTimeChange() ?? _timeChange; // 使用靜態方法
      _averageSmokingTime =
          AppSettings.getAverageSmokingTime() ?? _averageSmokingTime; // 使用靜態方法
      _appVersion = AppSettings.getAppVersion() ?? _appVersion;
      // 在這裡也更新控制器的 text 屬性
      _timeChangeController.text = _timeChange;
      _averageSmokingTimeController.text = _averageSmokingTime.toString();
    });
  }

  Future<void> saveSettings() async {
    await AppSettings.setLanguage(_language); // 使用靜態方法
    await AppSettings.setTimeChange(_timeChange); // 使用靜態方法
    await AppSettings.setAverageSmokingTime(_averageSmokingTime); // 使用靜態方法
    await AppSettings.setAppVersion(_appVersion); // 使用靜態方法
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Settings'),
      ),
      body: Scrollbar(
        child: ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: 10, // 6 ListTiles 和 6 Dividers
          itemBuilder: (BuildContext context, int index) {
            if (index % 2 == 1) {
              return Divider();
            }
            switch (index) {
              case 0:
                return ListTile(
                  title: Text('Language'),
                  trailing: DropdownButton<String>(
                    value: _language,
                    onChanged: (value) {
                      setState(() {
                        _language = value!;
                        saveSettings() ;
                      });
                    },
                    items: ['中文', 'English'].map<DropdownMenuItem<String>>((
                        String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                );
              case 2:
                return ListTile(
                  title: Text('Time Change (hh:mm:ss)'),
                  trailing: Container(
                    width: 100.0,
                    child: TextField(
                      controller: _timeChangeController,
                      keyboardType: TextInputType.datetime,
                      onChanged: (value) {
                        setState(() {
                          _timeChange = value;
                          saveSettings();
                        });
                      },
                    ),
                  ),
                );
              case 4:
                return ListTile(
                  title: Text('Average Smoking Time (s)'),
                  trailing: Container(
                    width: 100.0,
                    child: TextField(
                      controller: _averageSmokingTimeController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _averageSmokingTime = int.tryParse(value) ?? 300;
                          saveSettings();
                        });
                      },
                    ),
                  ),
                );
              case 6:
                return ListTile(
                  title: Text('Edit Records'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            SmokingListPage(database: database,)),
                      );
                    },
                    child: Text('Go'),
                  ),
                );
              case 8:
                return ListTile(
                  title: Text('App Version'),
                  trailing: Text(AppSettings.getAppVersion().toString()),
                );
              default:
                return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}