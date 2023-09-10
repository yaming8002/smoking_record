import 'package:flutter/material.dart';

import '../../../core/providers/SettingProvider.dart';
import '../SettingsTile.dart';
import 'ChangeTimeSettingWidget.dart';
import 'LanguageSettingWidget.dart';
import 'SingleCigaretteTimeWidget.dart';

class PreferenceSettingsWidget extends StatelessWidget {
  final SettingsProvider provider;

  const PreferenceSettingsWidget(this.provider, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 使标题靠左对齐
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Colors.blue, // 設置底色
            // borderRadius: BorderRadius.circular(8.0), // 設置圓角
          ),
          child: Text(
            '偏好設定',
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white), // 設置文字顏色為白色以與背景對比
          ),
        ),
        const Divider(),
        Column(
          children: [
            SettingsTile(
              title: '語言設定',
              trailing: LanguageSettingWidget(provider, context),
            ),
            const Divider(),
            SettingsTile(
              title: '換日時間',
              trailing: ChangeTimeSettingWidget(provider),
            ),
            const Divider(),
            SettingsTile(
              title: '單根菸的時間',
              trailing: SingleCigaretteTimeWidget(provider),
            ),
            const Divider(),
            SettingsTile(
              title: '換日通知',
              trailing: Switch(
                value: provider.dayChangeNotification,
                onChanged: (value) {
                  provider.dayChangeNotification = value;
                },
              ),
            ),
            const Divider(),
            SettingsTile(
              title: '紀錄通知',
              trailing: Switch(
                value: provider.recordNotification,
                onChanged: (value) {
                  provider.recordNotification = value;
                },
              ),
            ),
            const Divider(),
            SettingsTile(
              title: '紀錄通知的時間',
              trailing: Container(
                width: 100.0,
                child: TextField(
                  controller: TextEditingController(text: "sss"),
                  keyboardType: TextInputType.datetime,
                  onChanged: (value) {
                    // provider.recordNotificationTime = value;
                  },
                ),
              ),
            ),
            const Divider(),
          ],
        ),
      ],
    );
  }
}
