import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smoking_record/ui/pages/subpage/PreferenceSettingsWidget.dart';

import '../../core/providers/SettingProvider.dart';
import '../../generated/l10n.dart';
import '../AppFrame.dart';
import 'subpage/AboutAppSettingsWidget.dart';
import 'subpage/DataProcessingSettingsWidget.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<SettingsProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingsProvider(context),
      child: Consumer<SettingsProvider>(
        builder: (context, provider, child) {
          return AppFrame(
            appBarTitle: S.current.page_setting,
            body: Scrollbar(
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  PreferenceSettingsWidget(provider),
                  DataProcessingSettingsWidget(provider),
                  AboutAppSettingsWidget(provider),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // 使标题靠左对齐
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                          child: ElevatedButton(
                            onPressed: () async {
                              await provider.testnutton();
                            },
                            child: Text("Test 訊息"),
                          ),
                        ),
                      ])
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
