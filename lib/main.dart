import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import 'core/services/AppSettingService.dart';
import 'core/services/DatabaseManager.dart';
import 'core/services/SmokingSatusService.dart';
import 'core/services/SummaryService.dart';
import 'generated/l10n.dart';
import 'ui/pages/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSettingService.init();
  Database db = await DatabaseManager.initDB();

  runApp(MultiProvider(
    providers: [
      Provider<DatabaseManager>(
        create: (context) => DatabaseManager(db),
      ),
      ProxyProvider<DatabaseManager, SummaryService>(
        update: (context, databaseManager, previous) =>
            SummaryService(databaseManager),
      ),
      ProxyProvider2<DatabaseManager, SummaryService, SmokingSatusService>(
        update: (context, databaseManager, summaryService, previous) =>
            SmokingSatusService(databaseManager, summaryService),
      ),
    ],
    builder: (context, child) {
      return const MyApp();
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // 這個 widget 是你的應用的根（起點）。
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // 這是你應用的主題。
        //
        // 嘗試這個：用 "flutter run" 運行你的應用。你將看到應用有一個藍色的工具欄。
        // 然後，在不退出應用的情況下，嘗試將下面的 seedColor 改為 Colors.green，
        // 然後調用 "hot reload"（保存你的更改或在支持 Flutter 的 IDE 中按下 "hot reload" 按鈕，
        // 或者如果你是用命令行來啟動應用的，則按 "r"）。
        //
        // 注意，計數器沒有重置為零；在重新加載期間，應用狀態並未丟失。
        // 若要重置狀態，請使用熱重啟（hot restart）。
        //
        // 對於代碼也是如此，而不僅僅是值：大多數代碼更改都可以只使用熱重新加載（hot reload）來測試。
        primarySwatch: Colors.blue,
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
        // 如果语言是英语
        if (locale?.languageCode == 'en') {
          //注意大小写，返回美国英语
          return const Locale('en', 'US');
        } else {
          return locale;
        }
      },
      supportedLocales: S.delegate.supportedLocales,
      home: HomePage(),
    );
  }
}
