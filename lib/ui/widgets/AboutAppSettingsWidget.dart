import 'package:flutter/material.dart';
import 'package:smoking_record/core/services/AppSettingService.dart';

import '../../core/providers/SettingProvider.dart';
import 'SettingsTile.dart';

class AboutAppSettingsWidget extends StatelessWidget {
  final SettingsProvider provider;

  AboutAppSettingsWidget(this.provider);

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
            '關於本程式',
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white), // 設置文字顏色為白色以與背景對比
          ),
        ),
        const Divider(),
        Column(
          children: [
            _buildADMode(provider),
            const Divider(),
            _buildAboutAppSetting(provider),
            const Divider(),
            _buildContactAuthorSetting(provider),
            const Divider(),
            // 这里您可以添加 "隱私與服務條款" 的设置项
          ],
        ),
      ],
    );
  }
}

Widget _buildADMode(SettingsProvider provider) {
  return SettingsTile(
    title: '停用廣告',
    trailing: Switch(
      value: AppSettingService.getisStopAd(),
      onChanged: (value) {
        AppSettingService.setIsStopAd(value);
      },
    ),
  );
}

// 關於我們
Widget _buildAboutAppSetting(SettingsProvider provider) {
  return SettingsTile(
    title: '關於本程式',
    trailing: Text(provider.aboutApp ?? "---"), // 後續把版本資訊包在其中
  );
}

Widget _buildContactAuthorSetting(SettingsProvider provider) {
  return SettingsTile(
    title: '聯繫作者',
    trailing: Text('Contact'),
    //   ElevatedButton(
    //     onPressed: provider.contactAuthor,
    //     child: Text('Contact'),
    //   ),
  );
}
