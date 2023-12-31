import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/providers/HomePageProvider.dart';
import '../core/providers/SettingProvider.dart';
import '../generated/l10n.dart';
import 'pages/settingPage.dart';
import 'widgets/AdBanner.dart';

class AppFrame extends StatelessWidget {
  final Widget body;
  final String? appBarTitle;
  final List<Widget>? appBarActions;
  final HomePageProvider? provider;

  const AppFrame({
    Key? key,
    required this.body,
    this.appBarTitle,
    this.appBarActions,
    this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Colors.amber, // 设置 AppBar 背景颜色为琥珀色
        title: Text(appBarTitle ?? S.current.page_home),
        actions: <Widget>[
          if (appBarActions != null) ...appBarActions!,
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (context) => SettingsProvider(context),
                    child: SettingsPage(),
                  ),
                ),
              );
              // 当从设置页面返回时，此处的代码将被执行

              await provider?.loadData();
            },
          ),
        ],
      ),
      body: body,
      bottomNavigationBar: AdBanner(),
    );
  }
}
