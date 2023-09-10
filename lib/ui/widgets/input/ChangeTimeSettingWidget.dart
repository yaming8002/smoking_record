import 'package:flutter/material.dart';

import '../../../core/providers/SettingProvider.dart';

Widget ChangeTimeSettingWidget(SettingsProvider provider) {
  return SizedBox(
    width: 100.0,
    child: TextField(
      controller: TextEditingController(text: provider.timeChange),
      keyboardType: TextInputType.datetime,
      onChanged: (value) {
        provider.timeChange = value;
      },
    ),
  );
}
