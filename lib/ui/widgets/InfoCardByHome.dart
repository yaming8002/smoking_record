import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../core/models/summaryDay.dart';
import '../../core/providers/HomePageProvider.dart';
import '../../generated/l10n.dart';
import '../pages/ImageDisplayPage.dart';
import '../pages/reportPage.dart';

class InfoSection extends StatelessWidget {
  final String title;
  final SummaryDay? thisSummaryDay;
  final SummaryDay? beforeSummaryDay;
  final HomePageProvider provider;

  const InfoSection({
    Key? key,
    required this.title,
    required this.thisSummaryDay,
    required this.beforeSummaryDay,
    required this.provider,
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
          SizedBox(height: 8.0),
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: _buildInfoCard(S.current.smokingStatus_smokeCount,
                        '${thisSummaryDay?.count ?? 0} (${beforeSummaryDay?.count ?? 0})')),
                const SizedBox(width: 8.0),
                Expanded(
                  child: _buildInfoCard(S.current.smokingStatus_cumulativeTime,
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
    return Container(
      width: double.infinity,
      // padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ImageDisplayPage())),
              ),
              IconButton(
                icon: Icon(Icons.report),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ReportPage())),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String content, {String? helpStr}) {
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
            flex: 3,
            child: Stack(
              children: [
                Center(
                  child: AutoSizeText(
                    title,
                    minFontSize: 10,
                    maxFontSize: 100,
                    style: const TextStyle(fontSize: 40),
                    maxLines: 1,
                  ),
                ),
                if (helpStr != null)
                  Positioned(
                    right: 8,
                    child: Tooltip(
                      message: helpStr,
                      child: const Icon(Icons.help_outline, size: 20.0),
                    ),
                  ),
              ],
            ),
          ),

          // Content 配置7的部分
          Flexible(
            flex: 7,
            child: Center(
              child: AutoSizeText(
                content,
                minFontSize: 10,
                maxFontSize: 100,
                style: const TextStyle(fontSize: 50),
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
