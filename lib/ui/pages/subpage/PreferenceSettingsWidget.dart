import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../core/providers/SettingProvider.dart';
import '../../../generated/l10n.dart';
import '../../widgets/SettingsTile.dart';
import '../../widgets/input/LanguageSettingWidget.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Colors.blue, // 設置底色
            borderRadius: BorderRadius.circular(8.0), // 設置圓角
          ),
          child: Text(
            S.current.setting_settings,
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
              title: S.current.setting_languageSettings,
              trailing: LanguageSettingWidget(provider, context),
            ),
            const Divider(),
            SettingsTile(
              title: S.current.setting_crossoverTime,
              trailing: TextButton(
                onPressed: () async {
                  final String? newValue = await _showEditDialog(
                      context, provider.intervalTime.inHours.toString());
                  if (newValue != null) {
                    provider.intervalTime =
                        Duration(hours: int.parse(newValue));
                  }
                },
                child: AutoSizeText(
                  provider.intervalTime.inHours
                      .toString(), // display the current setting
                  minFontSize: 10,
                  maxFontSize: 60,
                ),
              ),
            ),
            const Divider(),
            SettingsTile(
              title: S.current.setting_singleCigaretteTime,
              trailing: TextButton(
                onPressed: () async {
                  final String? newValue = await _showEditDialog(
                      context, provider.averageSmokingTime.toString());
                  if (newValue != null) {
                    provider.averageSmokingTime = int.tryParse(newValue) ?? 300;
                  }
                },
                child: AutoSizeText(
                  provider.averageSmokingTime
                      .toString(), // display the current setting
                  minFontSize: 10,
                  maxFontSize: 60,
                ),
              ),
            ),
            const Divider(),
            SettingsTile(
              title: S.current.setting_notifications,
              trailing: Switch(
                value: provider.dayChangeNotification,
                onChanged: (value) {
                  provider.dayChangeNotification = value;
                },
              ),
            ),
            const Divider(),
          ],
        ),
      ],
    );
  }
}

Future<String?> _showEditDialog(
    BuildContext context, String initialValue) async {
  final TextEditingController controller =
      TextEditingController(text: initialValue);
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Edit Value'),
        content: TextField(
          controller: controller,
          keyboardType:
              TextInputType.text, // or TextInputType.number for numerical input
          decoration: const InputDecoration(hintText: 'Enter new value'),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(controller.text);
            },
          ),
        ],
      );
    },
  );
}
