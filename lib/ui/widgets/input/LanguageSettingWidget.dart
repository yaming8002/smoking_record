import 'package:flutter/material.dart';

import '../../../core/providers/SettingProvider.dart';
import '../../../core/services/AppSettingService.dart';
import '../../../main.dart';

Widget LanguageSettingWidget(SettingsProvider provider, BuildContext context) {
  // 對應語言名稱到語言代碼
  Map<String, String> languageMap = {
    '繁體中文': 'zh_TW',
    '簡體中文': 'zh',
    'English': 'en'
  };

  String currentLanguageName = languageMap.entries
      .firstWhere(
        (entry) => entry.value == provider.language,
        orElse: () => MapEntry('English', 'en'),
      )
      .key;

  return DropdownButton<String>(
    value: currentLanguageName,
    onChanged: (value) {
      provider.language = languageMap[value!]!;
      AppSettingService.setLanguage(languageMap[value]!); // 保存到偏好設定
      MyApp.of(context)?.setLocale(AppSettingService.getLanguageLocale());
    },
    items: languageMap.keys.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  );
}
