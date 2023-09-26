import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../core/models/summaryDay.dart';
import '../../core/providers/HomePageProvider.dart';
import '../../generated/l10n.dart';
import '../ScalableIconButton.dart';
import '../pages/ImageDisplayPage.dart';
import '../pages/reportPage.dart';

class InfoSection2 extends StatelessWidget {
  final String title;
  final SummaryDay? thisSummaryDay;
  final SummaryDay? beforeSummaryDay;
  final HomePageProvider provider;
  final double? heights;

  const InfoSection2({
    Key? key,
    required this.title,
    required this.thisSummaryDay,
    required this.beforeSummaryDay,
    required this.provider,
    required this.heights,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = (heights! - 4) * 0.95;
    double titleSectionHeight = height * 0.4;
    double infoCardSectionHeight = height * 0.6;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: heights ?? double.infinity),
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.black, width: 0.3),
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: titleSectionHeight,
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: AutoSizeText(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                      maxLines: 1,
                      minFontSize: 10,
                      maxFontSize: 30,
                    ),
                  ),
                  Row(
                    children: [
                      ScalableIconButton(
                        iconData: Icons.share,
                        size: titleSectionHeight,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageDisplayPage(),
                            ),
                          );
                        },
                      ),
                      ScalableIconButton(
                        iconData: Icons.bar_chart,
                        size: titleSectionHeight,
                        onPressed: () {
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
            SizedBox(height: 4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: _InfoCard(
                    title: S.current.smokingStatus_smokeCount,
                    content:
                        '${thisSummaryDay?.count ?? 0} (${beforeSummaryDay?.count ?? 0})',
                    heights: infoCardSectionHeight,
                  ),
                ),
                SizedBox(width: 4.0),
                Expanded(
                  child: _InfoCard(
                    title: S.current.smokingStatus_cumulativeTime,
                    content:
                        '${thisSummaryDay?.totalTime.inMinutes ?? 0} (${beforeSummaryDay?.totalTime.inMinutes ?? 0})',
                    heights: infoCardSectionHeight,
                    helpStr: S.current.time_unit,
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

class _InfoCard extends StatelessWidget {
  final String title;
  final String content;
  final String? helpStr;
  final double heights;

  const _InfoCard({
    required this.title,
    required this.content,
    this.helpStr,
    required this.heights,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heights,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AutoSizeText(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            minFontSize: 1,
            maxFontSize: 20,
          ),
          AutoSizeText(
            content,
            textAlign: TextAlign.center,
            maxLines: 1,
            minFontSize: 1,
            maxFontSize: 20,
          ),
          if (helpStr != null)
            Tooltip(
              message: helpStr!,
              child: Icon(
                Icons.help_outline,
                size: 12,
              ),
            ),
        ],
      ),
    );
  }
}
