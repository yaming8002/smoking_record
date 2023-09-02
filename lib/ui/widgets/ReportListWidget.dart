import 'package:flutter/material.dart';

import '../../core/models/summaryDay.dart';

class ReportListWidget extends StatefulWidget {
  final List<SummaryDay> summaryDayList;

  const ReportListWidget({Key? key, required this.summaryDayList})
      : super(key: key);

  @override
  _ReportListWidget createState() => _ReportListWidget();
}

class _ReportListWidget extends State<ReportListWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.summaryDayList.length,
        itemBuilder: (context, index) {
          final data = widget.summaryDayList[index];
          return ListTile(
            title: Text(data.sDate),
            subtitle: Table(
              children: [
                TableRow(children: [
                  Text('總數吸菸數: ${data.count}'),
                  Text('總計抽菸時間: ${data.totalTime.inMinutes}分鐘'),
                ]),
                TableRow(children: [
                  Text('平均時間間隔:  ${data.spacing.inMinutes}分鐘'),
                  Text('平均吸菸間隔時間: ${data.avgTime.inMinutes}分鐘'),
                ]),
              ],
            ),
          );
        },
      ),
    );
  }
}
