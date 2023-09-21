import 'package:flutter/material.dart';

import '../../core/models/summaryDay.dart';
import '../../core/providers/HomePageProvider.dart';
import '../../generated/l10n.dart';
import '../pages/ImageDisplayPage.dart';
import '../pages/reportPage.dart';
import 'buildInfoSection.dart';

class InfoSection extends StatelessWidget {
  final String title;
  final SummaryDay? thisSummaryDay;
  final SummaryDay? beforeSummaryDay;
  final HomePageProvider provider;

  InfoSection({
    super.key,
    required this.title,
    required this.thisSummaryDay,
    required this.beforeSummaryDay,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.blue.withOpacity(0.3),
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Colors.black, // 邊框顏色
            width: 0.5, // 邊框寬度
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.blue, // 設置底色
                borderRadius: BorderRadius.circular(8.0), // 設置圓角
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white), // 設置文字顏色為白色以與背景對比
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.share),
                        onPressed: () {
                          // First, perform the comparison and template generation
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageDisplayPage(),
                            ),
                          );

                          // TODO: Then, integrate with your sharing logic here
                          // For instance, if you're using a package like 'share', it might look something like:
                          // await Share.share('Your share message here');
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.report),
                        onPressed: () {
                          // TODO: Handle the report icon button's logic here
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReportPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0), // 添加一些間距在Container和Row之間
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: InfoCard(
                    title: S.current.smokingStatus_smokeCount,
                    content:
                        '${thisSummaryDay?.count ?? 0} (${beforeSummaryDay?.count ?? 0})',
                  ),
                ),
                SizedBox(width: 8.0), // 這是一個間隔，您可以根據需要調整
                Expanded(
                  child: InfoCard(
                    title: S.current.smokingStatus_cumulativeTime,
                    content:
                        // '${DateTimeUtil.formatDurationMinutes(thisSummaryDay?.totalTime ?? Duration.zero)} (${DateTimeUtil.formatDurationMinutes(beforeSummaryDay?.totalTime ?? Duration.zero)} )',
                        '${thisSummaryDay?.totalTime.inMinutes ?? 0} (${beforeSummaryDay?.totalTime.inMinutes ?? 0})',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
