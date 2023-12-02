import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:smoking_record/ui/pages/HomePage.dart';
import 'package:sqflite/sqflite.dart';

import 'core/services/AppSettingService.dart';
import 'core/services/DatabaseManager.dart';
import 'core/services/ScheduleService.dart';
import 'core/services/SmokingSatusService.dart';
import 'core/services/SummaryService.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSettingService.init();
  Database db = await DatabaseManager.initDB();
  ScheduleManager manager = ScheduleManager();
  await manager.initialize();

  runApp(MultiProvider(
    providers: [
      Provider<DatabaseManager>(
        create: (context) => DatabaseManager(db),
      ),
      ProxyProvider<DatabaseManager, SummaryService>(
        update: (context, databaseManager, previous) =>
            SummaryService(databaseManager),
      ),
      ProxyProvider<DatabaseManager, SmokingSatusService>(
        update: (context, databaseManager, previous) =>
            SmokingSatusService(databaseManager),
      ),
    ],
    builder: (context, child) {
      return MyApp();
    },
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  @override
  // void initState() {
  //   super.initState();
  //   // Load ads.
  // }

  late Locale _locale =
      AppSettingService.getLanguageLocale() ?? Locale('en', 'US');

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      title: 'smokingRecord',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        // 如果 locale 已經設置，則優先使用它
        if (AppSettingService.getLanguage() != null) {
          return _locale;
        }

        // 否則，根據手機的當前語言設置來選擇
        if (locale?.languageCode == 'zh') {
          AppSettingService.setLanguage('zh');
          _locale = const Locale('zh', 'CN');
        } else if (locale?.countryCode == 'TW') {
          AppSettingService.setLanguage('zh_TW');
          _locale = const Locale('zh', 'TW');
        } else {
          AppSettingService.setLanguage('en');
          _locale = const Locale('en', 'US');
        }
        return _locale;
      },
      supportedLocales: S.delegate.supportedLocales,
      home: HomePage(),
    );
  }
}
