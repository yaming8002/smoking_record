import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:locale_plus/locale_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:smoking_record/ui/pages/HomePage.dart';
import 'package:sqflite/sqflite.dart';

import 'core/services/AppSettingService.dart';
import 'core/services/DatabaseManager.dart';
import 'core/services/SmokingSatusService.dart';
import 'core/services/SummaryService.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSettingService.init();
  Database db = await DatabaseManager.initDB();

  Locale? locale = AppSettingService.getLanguageLocale();
  if (locale == null) {
    var language = await LocalePlus().getLanguageCode();
    var region = await LocalePlus().getRegionCode();
    locale = Locale(language!, region);
    AppSettingService.setLanguageLocale(locale);
  }

  await requestPermissions([
    Permission.notification,
    Permission.accessNotificationPolicy,
    Permission.storage,
    Permission.accessMediaLocation,
    Permission.mediaLibrary,
    Permission.reminders,
    Permission.scheduleExactAlarm,
  ]);

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
      return MyApp(locale: locale);
    },
  ));
  // final scheduleManager = ScheduleManager();
  // await scheduleManager.initialize();
}

Future<void> requestPermissions(List<Permission> permissions) async {
  for (var permission in permissions) {
    if (await permission.isDenied) {
      await permission.request();
    }
  }
}

class MyApp extends StatefulWidget {
  Locale? locale;

  MyApp({super.key, this.locale});

  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  void setLocale(Locale newLocale) async {
    widget.locale = newLocale;
    AppSettingService.setLanguageLocale(newLocale);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: widget.locale,
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
      supportedLocales: S.delegate.supportedLocales,
      home: const HomePage(),
    );
  }
}
