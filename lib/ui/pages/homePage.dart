import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/HomePageProvider.dart';
import '../../generated/l10n.dart';
import '../AppFrame.dart';
import 'subpage/InfoCardByHome.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> with WidgetsBindingObserver {
  bool isAdBeingShown = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this); // 註冊觀察者
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this); // 移除觀察者
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 使用 ChangeNotifierProvider
    return ChangeNotifierProvider(
      create: (_) => HomePageProvider(context),
      child: Consumer<HomePageProvider>(builder: (context, provider, child) {
        return AppFrame(
            appBarTitle: S.current.page_home,
            body: LayoutBuilder(
              builder: (context, constraints) {
                provider.szieMap?.setSize("bodyWidth", constraints.maxWidth);
                provider.szieMap?.setSize("bodyHeight", constraints.maxHeight);
                provider.szieMap?.setSize("formatH1",
                    Theme.of(context).textTheme.headlineLarge!.fontSize!);
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            double radius =
                                (provider.szieMap!.getSize("bodyHeight")! -
                                        40) *
                                    0.24;
                            return GestureDetector(
                              onTap: () async {
                                if (provider.CircleColor == Colors.red) {
                                  isAdBeingShown = true;
                                  await provider
                                      .onNavigateToSecondPage(context);
                                  isAdBeingShown = false;
                                }
                              },
                              child: CircleAvatar(
                                  radius: radius,
                                  backgroundColor: provider.CircleColor,
                                  child: AutoSizeText(
                                    provider.timeDiff,
                                    minFontSize: 20, // 這裡是最小的字體大小
                                    maxFontSize: 100, // 這裡是最大的字體大小
                                    style: TextStyle(
                                      fontSize: provider.szieMap!
                                              .getSize("formatH1") ??
                                          30,
                                    ),
                                    textAlign: TextAlign.center,
                                  )),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Expanded(
                        flex: 22, // 這表示 InfoSection 將佔據 Column 中 25% 的空間
                        child: InfoCardByHome(
                          title: S.current.time_by_day,
                          thisSummaryDay: provider.today,
                          beforeSummaryDay: provider.yesterday,
                          provider: provider,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Expanded(
                        flex: 22, // 這表示 InfoSection 將佔據 Column 中 25% 的空間
                        child: InfoCardByHome(
                          title: S.current.time_by_week,
                          thisSummaryDay: provider.thisWeek,
                          beforeSummaryDay: provider.beforeWeek,
                          provider: provider,
                          isWeekly: true,
                        ),
                      ),
                      const SizedBox(height: 15.0),
                    ],
                  ),
                );
              },
            ),
            provider: provider);
      }),
    );
  }
}
