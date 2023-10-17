import 'package:flutter/material.dart';

import '../../../core/providers/SettingProvider.dart';
import '../../../generated/l10n.dart';
import '../../widgets/SettingsTile.dart';
import '../SmokingListPage.dart';

class DataProcessingSettingsWidget extends StatelessWidget {
  final SettingsProvider provider;

  DataProcessingSettingsWidget(this.provider);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 使标题靠左对齐
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: const BoxDecoration(
            color: Colors.blue, // 設置底色
            // borderRadius: BorderRadius.circular(8.0), // 設置圓角
          ),
          child: Text(
            S.current.setting_dataProcessing,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white), // 設置文字顏色為白色以與背景對比
          ),
        ),
        const Divider(),
        Column(
          children: [
            _buildEditDataSetting(context),
            const Divider(),
            _buildImportDataSetting(provider, context),
            const Divider(),
            _buildExportDataSetting(provider),
            const Divider(),
            _buildDataRecount(provider, context),
            const Divider(),
          ],
        ),
      ],
    );
  }
}

// 資料設定
Widget _buildEditDataSetting(BuildContext context) {
  return SettingsTile(
    title: S.current.setting_edit_one,
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SmokingListPage()),
      );
    },
  );
}

Widget _buildExportDataSetting(SettingsProvider provider) {
  return SettingsTile(
    title: S.current.setting_exportData,
    onTap: () => provider.exportDataToCsv(),
  );
}

Widget _buildImportDataSetting(
    SettingsProvider provider, BuildContext context) {
  return SettingsTile(
    title: S.current.setting_importData,
    onTap: () => _showProcessingDialog(context, provider.importDataToCsv),
  );
}

Widget _buildDataRecount(SettingsProvider provider, BuildContext context) {
  return SettingsTile(
    title: S.current.setting_data_recalculation,
    onTap: () => _showProcessingDialog(context, provider.dataRecount),
  );
}

void _showProcessingDialog(
    BuildContext context, Future<void> Function() processFunction) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return FutureBuilder(
        future: processFunction(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return AlertDialog(
              content: Row(
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(width: 20),
                  Flexible(
                    child: Text(S.current.setting_data_processing_in_progress),
                  ),
                ],
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            Navigator.of(context).pop();
            return const SizedBox.shrink();
          } else {
            return const SizedBox.shrink();
          }
        },
      );
    },
  );
}
