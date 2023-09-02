import 'package:flutter/material.dart';

import '../../core/models/summaryDay.dart';
import '../../utils/dateTimeUtil.dart';
import '../pages/reportPage.dart';
import 'buildInfoSection.dart';

class InfoSection extends StatelessWidget {
  final String title;
  final SummaryDay? thisSummaryDay;
  final SummaryDay? beforeSummaryDay;

  InfoSection({
    super.key,
    required this.title,
    required this.thisSummaryDay,
    required this.beforeSummaryDay,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.blue.withOpacity(0.3),
      borderRadius: BorderRadius.circular(8.0),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReportPage(),
          ),
        );
      },
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
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white), // 設置文字顏色為白色以與背景對比
              ),
            ),
            SizedBox(height: 8.0), // 添加一些間距在Container和Row之間
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: InfoCard(
                    title: '吸菸數',
                    content:
                        '${thisSummaryDay?.count ?? 0} (${beforeSummaryDay?.count ?? 0} )',
                  ),
                ),
                SizedBox(width: 8.0), // 這是一個間隔，您可以根據需要調整
                Expanded(
                  child: InfoCard(
                    title: '累計時間',
                    content:
                        '${DateTimeUtil.formatDuration(thisSummaryDay?.totalTime ?? Duration.zero)} (${DateTimeUtil.formatDuration(beforeSummaryDay?.totalTime ?? Duration.zero)} )',
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
