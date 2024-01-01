import 'dart:io' show Platform;

import 'package:flutter/material.dart';

import '../../../core/providers/SettingProvider.dart';
import '../../../generated/l10n.dart';
import '../../widgets/SettingsTile.dart';
import 'ShowCustomMessageAndRequestReview.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: const BoxDecoration(
            color: Colors.amber, // 設置底色
          ),
          child: Text(
            S.current.about_app,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ), // 設置文字顏色為白色以與背景對比
          ),
        ),
        const Divider(),
        Column(
          children: [
            // _buildADMode(provider),
            // const Divider(),
            // _buildPrivacyPolicyPage(context),
            // const Divider(),
            // _buildLegalPage(context),
            // const Divider(),
            // _buildAboutAppSetting(context),
            _buildAboutAppSetting(context),
            // const Divider(),
            // _buildContactAuthorSetting(context),
            // const Divider(),
            // 这里您可以添加 "隱私與服務條款" 的设置项
          ],
        ),
      ],
    );
  }
}

// 關於我們
Widget _buildAboutAppSetting(BuildContext context) {
  return SettingsTile(
    title: S.current.about_app,
    onTap: () {
      showCustomMessageAndRequestReview(context);
    },
  );
}

Future<String> encodeQueryParameters() async {
  Map<String, String> params = <String, String>{
    'subject': 'Support Request from SmokingRecord User',
    'body': '''os:${Platform.operatingSystem}
         version:${Platform.operatingSystemVersion}
         app:${Platform.operatingSystemVersion}''',
  };

  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}
