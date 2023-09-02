// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../core/providers/SettingProvider.dart';
// import '../widgets/AppFrame.dart';
// import '../widgets/SettingsTile.dart';
// import 'SmokingListPage.dart';
//
// class SettingsPage extends StatefulWidget {
//   @override
//   _SettingsPageState createState() => _SettingsPageState();
// }
//
// class _SettingsPageState extends State<SettingsPage> {
//   @override
//   void initState() {
//     super.initState();
//     final provider = Provider.of<SettingsProvider>(context, listen: false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => SettingsProvider(),
//       child: Consumer<SettingsProvider>(
//         builder: (context, provider, child) {
//           return AppFrame(
//             appBarTitle: 'Settings',
//             body: Scrollbar(
//               child: ListView(
//                 padding: EdgeInsets.all(16.0),
//                 children: [
//                   _buildLanguageSetting(provider),
//                   Divider(),
//                   _buildDayChangeTimeSetting(provider),
//                   Divider(),
//                   _buildSingleCigaretteTimeSetting(provider),
//                   Divider(),
//                   _buildDayChangeNotificationSetting(provider),
//                   Divider(),
//                   _buildRecordNotificationSetting(provider),
//                   Divider(),
//                   _buildRecordNotificationTimeSetting(provider),
//                   Divider(),
//                   _buildEditDataSetting(),
//                   Divider(),
//                   _buildExportDataSetting(provider),
//                   Divider(),
//                   _buildImportDataSetting(provider),
//                   Divider(),
//                   _buildAboutAppSetting(provider),
//                   Divider(),
//                   _buildAppVersionSetting(provider),
//                   Divider(),
//                   _buildContactAuthorSetting(provider),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   // 偏好設定
//   Widget _buildLanguageSetting(SettingsProvider provider) {
//     return SettingsTile(
//       title: '語言設定',
//       trailing: DropdownButton<String>(
//         value: provider.language,
//         onChanged: (value) {
//           provider.language = value!;
//         },
//         items: ['中文', 'English'].map<DropdownMenuItem<String>>((String value) {
//           return DropdownMenuItem<String>(
//             value: value,
//             child: Text(value),
//           );
//         }).toList(),
//       ),
//     );
//   }
//
//   Widget _buildDayChangeTimeSetting(SettingsProvider provider) {
//     return SettingsTile(
//       title: '換日時間',
//       trailing: Container(
//         width: 100.0,
//         child: TextField(
//           controller: TextEditingController(text: provider.timeChange),
//           keyboardType: TextInputType.datetime,
//           onChanged: (value) {
//             provider.timeChange = value;
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSingleCigaretteTimeSetting(SettingsProvider provider) {
//     return SettingsTile(
//       title: '單根菸的時間',
//       trailing: Container(
//         width: 100.0,
//         child: TextField(
//           controller: TextEditingController(
//               text: provider.averageSmokingTime.toString()),
//           keyboardType: TextInputType.number,
//           onChanged: (value) {
//             provider.averageSmokingTime = int.tryParse(value) ?? 300;
//           },
//         ),
//       ),
//     );
//   }
//
//   // 通知設定
//   Widget _buildDayChangeNotificationSetting(SettingsProvider provider) {
//     return SettingsTile(
//       title: '換日通知',
//       trailing: Switch(
//         value: provider.dayChangeNotification,
//         onChanged: (value) {
//           provider.dayChangeNotification = value;
//         },
//       ),
//     );
//   }
//
//   Widget _buildRecordNotificationSetting(SettingsProvider provider) {
//     return SettingsTile(
//       title: '紀錄通知',
//       trailing: Switch(
//         value: provider.recordNotification,
//         onChanged: (value) {
//           provider.recordNotification = value;
//         },
//       ),
//     );
//   }
//
//   Widget _buildRecordNotificationTimeSetting(SettingsProvider provider) {
//     return SettingsTile(
//       title: '紀錄通知的時間',
//       trailing: Container(
//         width: 100.0,
//         child: TextField(
//           controller:
//           TextEditingController(text: provider.recordNotificationTime),
//           keyboardType: TextInputType.datetime,
//           onChanged: (value) {
//             provider.recordNotificationTime = value;
//           },
//         ),
//       ),
//     );
//   }
//
//   // 資料設定
//   Widget _buildEditDataSetting() {
//     return SettingsTile(
//       title: '單筆資料編輯',
//       trailing: ElevatedButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => SmokingListPage()),
//           );
//         },
//         child: Text('Go'),
//       ),
//     );
//   }
//
//   Widget _buildExportDataSetting(SettingsProvider provider) {
//     return SettingsTile(
//       title: '資料匯出CSV',
//       trailing: ElevatedButton(
//         onPressed: provider.exportDataToCSV,
//         child: Text('Export'),
//       ),
//     );
//   }
//
//   Widget _buildImportDataSetting(SettingsProvider provider) {
//     return SettingsTile(
//       title: '資料匯入',
//       trailing: ElevatedButton(
//         onPressed: provider.importDataFromCSV,
//         child: Text('Import'),
//       ),
//     );
//   }
//
//   // 關於我們
//   Widget _buildAboutAppSetting(SettingsProvider provider) {
//     return SettingsTile(
//       title: '關於本程式',
//       trailing: Text(provider.aboutApp),
//     );
//   }
//
//   Widget _buildAppVersionSetting(SettingsProvider provider) {
//     return SettingsTile(
//       title: '版本資訊',
//       trailing: Text(provider.appVersion.toString()),
//     );
//   }
//
//   Widget _buildContactAuthorSetting(SettingsProvider provider) {
//     return SettingsTile(
//       title: '聯繫作者',
//       trailing: ElevatedButton(
//         onPressed: provider.contactAuthor,
//         child: Text('Contact'),
//       ),
//     );
//   }
// }
