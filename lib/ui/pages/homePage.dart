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
  @override
  Widget build(BuildContext context) {
    // 使用 ChangeNotifierProvider
    return ChangeNotifierProvider(
      create: (_) => HomePageProvider(context),
      child: Consumer<HomePageProvider>(
        builder: (context, provider, child) {
          return AppFrame(
            appBarTitle: S.current.page_home,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double radius =
                            constraints.maxWidth < constraints.maxHeight
                                ? constraints.maxWidth / 3
                                : constraints.maxHeight / 3;
                        return GestureDetector(
                          onTap: () => provider.onNavigateToSecondPage(context),
                          child: CircleAvatar(
                            radius: radius,
                            backgroundColor: Colors.red,
                            child: Text(
                              provider.timeDiff,
                              style: TextStyle(fontSize: radius / 5),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        InfoSection(
                          title: S.current.time_by_day,
                          thisSummaryDay: provider.today,
                          beforeSummaryDay: provider.yesterday,
                          provider: provider,
                        ),
                        SizedBox(height: 5.0),
                        InfoSection(
                          title: S.current.time_by_week,
                          thisSummaryDay: provider.thisWeek,
                          beforeSummaryDay: provider.beforeWeek,
                          provider: provider,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
