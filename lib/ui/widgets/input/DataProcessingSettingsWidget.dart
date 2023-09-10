import 'package:flutter/material.dart';

import '../../../core/providers/SettingProvider.dart';
import '../../pages/SmokingListPage.dart';
import '../SettingsTile.dart';

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
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Colors.blue, // 設置底色
            // borderRadius: BorderRadius.circular(8.0), // 設置圓角
          ),
          child: Text(
            '資料處裡',
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
            _buildImportDataSetting(provider),
            const Divider(),
            _buildExportDataSetting(provider),
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
    title: '單筆資料編輯',
    trailing: ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SmokingListPage()),
        );
      },
      child: Text('Go'),
    ),
  );
}

Widget _buildExportDataSetting(SettingsProvider provider) {
  return SettingsTile(
    title: '資料匯出CSV',
    trailing: ElevatedButton(
      onPressed: () => provider.exportDataToCsv(),
      child: Text('Outport CSV'),
    ),
  );
}

Widget _buildImportDataSetting(SettingsProvider provider) {
  return SettingsTile(
    title: '資料匯入',
    trailing: ElevatedButton(
      onPressed: () => provider.importDataToCsv(),
      child: Text("Import CSV"),
    ),
  );
}
