import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/HomePageProvider.dart';
import '../../generated/l10n.dart';
import '../widgets/AppFrame.dart';
import '../widgets/InfoCardByHome.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  double? bodyWidth;
  double? bodyHeight;
  double? formatH1;

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
              bodyWidth = constraints.maxWidth;
              bodyHeight = constraints.maxHeight;
              formatH1 = Theme.of(context).textTheme.headlineLarge!.fontSize!;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          double radius = (bodyHeight! - 40) * 0.24;
                          return GestureDetector(
                            onTap: () =>
                                provider.onNavigateToSecondPage(context),
                            child: CircleAvatar(
                                radius: radius,
                                backgroundColor: Colors.red,
                                child: AutoSizeText(
                                  provider.timeDiff,
                                  minFontSize: 10, // 這裡是最小的字體大小
                                  maxFontSize: 100, // 這裡是最大的字體大小
                                  style: TextStyle(fontSize: formatH1 ?? 30),
                                  maxLines: 1,
                                )),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Expanded(
                      flex: 22, // 這表示 InfoSection 將佔據 Column 中 25% 的空間
                      child: InfoSection(
                        title: S.current.time_by_day,
                        thisSummaryDay: provider.today,
                        beforeSummaryDay: provider.yesterday,
                        provider: provider,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Expanded(
                      flex: 22, // 這表示 InfoSection 將佔據 Column 中 25% 的空間
                      child: InfoSection(
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
        );
      }),
    );
  }
}
