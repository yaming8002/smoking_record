import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:smoking_record/core/services/AppSettingService.dart';

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
            color: Colors.amber, // 設置底色
            borderRadius: BorderRadius.circular(8.0), // 設置圓角
          ),
          child: Text(
            S.current.setting_settings,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ), // 設置文字顏色為白色以與背景對比
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
              title: S.current.setting_isWeekStartMonday,
              trailing: _buildWeekStartByMon(provider, context),
            ),
            const Divider(),
            SettingsTile(
              title:
                  "${S.current.setting_singleCigaretteTime}${S.current.time_seconds}",
              trailing: _buildNumberEditButton(
                context,
                "${S.current.setting_singleCigaretteTime}${S.current.time_seconds}",
                provider.averageSmokingTime,
                (newValue) => provider.averageSmokingTime = newValue,
              ),
            ),
            const Divider(),
            SettingsTile(
              title: "${S.current.time_intervalTime}${S.current.time_hours}",
              trailing: _buildNumberEditButton(
                context,
                "${S.current.time_intervalTime}${S.current.time_hours}",
                provider.intervalTime.inHours,
                (newValue) => provider.intervalTime = Duration(hours: newValue),
              ),
            ),
            const Divider(),
            SettingsTile(
              title: "${S.current.time_stopTime}${S.current.time_minutes}",
              trailing: _buildNumberEditButton(
                context,
                "${S.current.time_stopTime}${S.current.time_minutes}",
                provider.stopTime.inMinutes,
                (newValue) {
                  provider.stopTime = Duration(minutes: newValue);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Widget _buildNumberEditButton(BuildContext context, String title,
    int currentValue, Function(int) onValueChange) {
  return TextButton(
    onPressed: () async {
      final String? newValue =
          await _showEditDialog(context, title, currentValue.toString());
      if (newValue != null && newValue.isNotEmpty) {
        int? newValueInt = int.tryParse(newValue);
        if (newValueInt != null) {
          onValueChange(newValueInt);
        }
      }
    },
    child: AutoSizeText(
      currentValue.toString(),
      minFontSize: 10,
      maxFontSize: 60,
    ),
  );
}

Widget _buildWeekStartByMon(SettingsProvider provider, BuildContext context) {
  return Switch(
      value: AppSettingService.getIsWeekStartMonday(),
      onChanged: (newValue) {
        provider.updateWeekStartMonday(newValue);
        //  AppSettingService.setIsWeekStartMonday(newValue);
      });
}

Future<String?> _showEditDialog(
    BuildContext context, String title, String initialValue) async {
  final TextEditingController controller =
      TextEditingController(text: initialValue);
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
        ),
        actions: <Widget>[
          TextButton(
            child: Text(S.current.cancel),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(S.current.submit),
            onPressed: () {
              Navigator.of(context).pop(controller.text);
            },
          ),
        ],
      );
    },
  );
}
