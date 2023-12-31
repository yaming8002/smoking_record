import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../core/models/Summary.dart';
import '../../../core/providers/HomePageProvider.dart';
import '../../../generated/l10n.dart';
import '../SmokingListPage.dart';
import '../reportPage.dart';

class InfoCardByHome extends StatelessWidget {
  final String title;
  final Summary? thisSummaryDay;
  final Summary? beforeSummaryDay;
  final HomePageProvider provider;
  final bool isWeekly;

  const InfoCardByHome({
    Key? key,
    required this.title,
    required this.thisSummaryDay,
    required this.beforeSummaryDay,
    required this.provider,
    this.isWeekly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildHeader(context),
          const SizedBox(height: 8.0),
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: _buildInfoCard(
                        context,
                        S.current.smokingStatus_smokeCount,
                        thisSummaryDay?.startTime,
                        thisSummaryDay?.endTime,
                        thisSummaryDay?.count,
                        beforeSummaryDay?.count,
                        S.current.freq_unit)),
                const SizedBox(width: 8.0),
                Expanded(
                  child: _buildInfoCard(
                      context,
                      S.current.smokingStatus_total_time,
                      thisSummaryDay?.startTime,
                      thisSummaryDay?.endTime,
                      thisSummaryDay?.totalTime.inMinutes,
                      beforeSummaryDay?.totalTime.inMinutes,
                      S.current.time_minutes),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    provider.szieMap?.setSize(
        "formatH2", Theme.of(context).textTheme.headlineSmall!.fontSize!);
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.amber,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            flex: 7, // 85%
            child: AutoSizeText(
              title,
              minFontSize: 9,
              maxFontSize: 20,
              maxLines: 1,
              style: TextStyle(
                  fontSize: provider.szieMap?.getSize("formatH2"),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3, // 15%
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.bar_chart),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReportPage(isWeekly: isWeekly)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, String title, DateTime? startTime,
      DateTime? endTime, int? now, int? last, String? helpStr) {
    double formatDefault = Theme.of(context).textTheme.titleMedium!.fontSize!;
    double valueDefault = Theme.of(context).textTheme.titleLarge!.fontSize!;
    double iconformat = Theme.of(context).textTheme.labelSmall!.fontSize!;

    String content = '${now ?? 0} / ${last ?? 0}';
    double percentage = now != null && last != null && last != 0
        ? (now / last).clamp(0.0, 1.0) // 计算百分比并限制在 [0, 1] 范围内
        : 0.0; // 默认为 0.0，以防除零错误

    Color fillColor = Colors.white;
    if (percentage < 0.3) {
      fillColor = Colors.green;
    } else if (percentage < 0.7) {
      fillColor = Colors.amber;
    } else {
      fillColor = Colors.red;
    }

    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SmokingListPage(startTime, endTime)),
        );

        await provider.loadData();
        provider.notifyListeners();
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [fillColor, Colors.white], // 使用相同颜色创建渐变
            begin: Alignment.bottomCenter, // 从底部开始
            end: Alignment.topCenter, // 到顶部结束
            stops: [percentage, percentage], // 根据 percentage 设置颜色比例
          ),
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(3.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title 配置 3 的部分
            Flexible(
              flex: 3,
              child: Center(
                child: AutoSizeText(
                  title,
                  minFontSize: 10,
                  maxFontSize: 100,
                  style: TextStyle(fontSize: formatDefault),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // Content 配置 5 的部分
            Flexible(
              flex: 5,
              child: Center(
                child: AutoSizeText(
                  content,
                  minFontSize: 10,
                  maxFontSize: 100,
                  style: TextStyle(fontSize: valueDefault),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // helpStr 配置 2 的部分
            Flexible(
              flex: 2,
              child: Text(
                helpStr ?? 'Default help message',
                style: TextStyle(fontSize: iconformat),
                maxLines: 1,
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
