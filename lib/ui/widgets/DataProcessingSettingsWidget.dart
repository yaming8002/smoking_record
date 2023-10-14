import 'package:flutter/material.dart';

import '../../core/providers/SettingProvider.dart';
import '../pages/SmokingListPage.dart';
import 'SettingsTile.dart';

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

Widget _buildDataRecount(SettingsProvider provider, BuildContext context) {
  return SettingsTile(
    title: '資料重新計算',
    trailing: ElevatedButton(
      onPressed: () => _showProcessingDialog(context, provider.dataRecount),
      child: Text('資料重新計算'),
    ),
  );
}

Widget _buildImportDataSetting(
    SettingsProvider provider, BuildContext context) {
  return SettingsTile(
    title: '資料匯入',
    trailing: ElevatedButton(
      onPressed: () => _showProcessingDialog(context, provider.importDataToCsv),
      child: Text("Import CSV"),
    ),
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
                  CircularProgressIndicator(),
                  SizedBox(width: 20),
                  Text('資料處理中...'),
                ],
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            Navigator.of(context).pop();
            return SizedBox.shrink();
          } else {
            return SizedBox.shrink();
          }
        },
      );
    },
  );
}
