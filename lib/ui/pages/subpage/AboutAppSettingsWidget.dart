import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/providers/SettingProvider.dart';
import '../../../generated/l10n.dart';
import '../../widgets/SettingsTile.dart';
import 'PrivacyPolicyPage.dart';

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
            color: Colors.amber, // 設置底色
            // borderRadius: BorderRadius.circular(8.0), // 設置圓角
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
            _buildPrivacyPolicyPage(context),
            const Divider(),
            _buildAboutAppSetting(context),
            const Divider(),
            _buildContactAuthorSetting(context),
            const Divider(),
            // 这里您可以添加 "隱私與服務條款" 的设置项
          ],
        ),
      ],
    );
  }
}

Widget _buildPrivacyPolicyPage(BuildContext context) {
  return SettingsTile(
    title: S.current.privacyPolicy_title,
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PrivacyPolicyPage()),
      );
    },
  );
}

// 關於我們
Widget _buildAboutAppSetting(BuildContext context) {
  return SettingsTile(
    title: S.current.about_app,
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PrivacyPolicyPage()),
      );
    },
  );
}

Widget _buildContactAuthorSetting(BuildContext context) {
  return FutureBuilder<String>(
    future: encodeQueryParameters(),
    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator(); // 返回一个加载指示器，表示等待
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        final Uri params = Uri(
          scheme: 'mailto',
          path: 'mountain0212@hotmail.com',
          query: snapshot.data, // 使用解析后的数据
        );
        return SettingsTile(
          title: S.current.contact_author,
          onTap: () async {
            // 将 onTap 方法标记为 async
            encodeQueryParameters();
            if (await canLaunchUrl(params)) {
              // 使用正确的函数名和 params
              await launchUrl(params); // 使用正确的函数名和 params
            } else {
              throw 'Could not launch $params'; // 使用正确的变量名
            }
          },
        );
      }
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
