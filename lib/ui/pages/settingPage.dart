import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smoking_record/ui/widgets/input/PreferenceSettingsWidget.dart';

import '../../core/providers/SettingProvider.dart';
import '../../generated/l10n.dart';
import '../widgets/AppFrame.dart';
import '../widgets/input/AboutAppSettingsWidget.dart';
import '../widgets/input/DataProcessingSettingsWidget.dart';

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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
