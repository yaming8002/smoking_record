import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../core/models/Summary.dart';
import '../../../core/providers/HomePageProvider.dart';
import '../../../generated/l10n.dart';
import '../ImageDisplayPage.dart';
import '../reportPage.dart';

class InfoSection extends StatelessWidget {
  final String title;
  final Summary? thisSummaryDay;
  final Summary? beforeSummaryDay;
  final HomePageProvider provider;
  final bool isWeekly;

  const InfoSection({
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
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
      // decoration: BoxDecoration(
      //   color: Colors.yellow,
      //   borderRadius: BorderRadius.circular(8.0),
      //   border: Border.all(color: Colors.black, width: 0.5),
      // ),
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
                        '${thisSummaryDay?.count ?? 0} (${beforeSummaryDay?.count ?? 0})')),
                const SizedBox(width: 8.0),
                Expanded(
                  child: _buildInfoCard(
                      context,
                      S.current.smokingStatus_total_time,
                      '${thisSummaryDay?.totalTime.inMinutes ?? 0} (${beforeSummaryDay?.totalTime.inMinutes ?? 0})',
                      helpStr: S.current.time_unit),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    // double formatH2 = Theme.of(context).textTheme.headlineSmall!.fontSize!;
    provider.szieMap
        ?.setSize("formatH2", Theme.of(context).textTheme.bodySmall!.fontSize!);
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 7, // 85%
            child: AutoSizeText(
              title,
              minFontSize: 9,
              maxFontSize: 20,
              maxLines: 1,
              style: TextStyle(
                  fontSize: provider.szieMap?.getSize("formatH2"),
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Expanded(
            flex: 3, // 15%
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ImageDisplayPage()),
                  ),
                ),
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

  Widget _buildInfoCard(BuildContext context, String title, String content,
      {String? helpStr}) {
    double formatDefault = Theme.of(context).textTheme.titleLarge!.fontSize!;
    double iconformat = Theme.of(context).textTheme.bodyLarge!.fontSize!;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(3.0),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1))
        ],
      ),
      child: Column(
        children: [
          // Title 配置3的部分
          Flexible(
            flex: 4,
            child: Stack(
              children: [
                Center(
                  child: AutoSizeText(
                    title,
                    minFontSize: 10,
                    maxFontSize: 100,
                    style: TextStyle(fontSize: formatDefault),
                    maxLines: 1,
                  ),
                ),
                if (helpStr != null)
                  Positioned(
                    right: 8,
                    child: Tooltip(
                      message: helpStr,
                      waitDuration: const Duration(milliseconds: 50),
                      showDuration: const Duration(milliseconds: 500),
                      child: Icon(Icons.help_outline, size: iconformat),
                    ),
                  ),
              ],
            ),
          ),

          // Content 配置7的部分
          Flexible(
            flex: 6,
            child: Center(
              child: AutoSizeText(
                content,
                minFontSize: 10,
                maxFontSize: 100,
                style: TextStyle(fontSize: formatDefault),
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // "?" 標示在右上角
        ],
      ),
    );
  }
}
