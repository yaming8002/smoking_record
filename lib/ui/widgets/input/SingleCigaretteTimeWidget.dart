import 'package:flutter/material.dart';

import '../../../core/providers/SettingProvider.dart';

Widget SingleCigaretteTimeWidget(SettingsProvider provider) {
  return Container(
    width: 100.0,
    child: TextField(
      controller:
          TextEditingController(text: provider.averageSmokingTime.toString()),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        provider.averageSmokingTime = int.tryParse(value) ?? 300;
      },
    ),
  );
}
