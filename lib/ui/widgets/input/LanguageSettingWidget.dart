import 'package:flutter/material.dart';

import '../../../core/providers/SettingProvider.dart';
import '../../../main.dart';

Widget LanguageSettingWidget(SettingsProvider provider, BuildContext context) {
  // 對應語言名稱到語言代碼
  Map<String, Locale> languageMap = {
    '繁體中文': const Locale('zh', 'TW'),
    '簡體中文': const Locale('zh'),
    'English': const Locale('en'),
  };

  String currentLanguageName = languageMap.entries
      .firstWhere(
        (entry) => entry.value == provider.language,
        orElse: () => const MapEntry('English', Locale('en')),
      )
      .key;

  return DropdownButton<String>(
    value: currentLanguageName,
    onChanged: (value) {
      Locale languageLocale = languageMap[value!]!;
      MyApp.of(context)?.setLocale(languageLocale);
      provider.notifyListeners();
    },
    items: languageMap.keys.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  );
}
