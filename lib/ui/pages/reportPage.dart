import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/ReportProvider.dart';
import '../../generated/l10n.dart';
import '../../utils/dateTimeUtil.dart';
import '../widgets/AppFrame.dart';
import '../widgets/ReportChartWidget.dart';

class ReportPage extends StatefulWidget {
  final bool isWeekly;

  const ReportPage({
    super.key,
    required this.isWeekly,
  });

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> with TickerProviderStateMixin {
  late TabController _chartTabController;

  @override
  void initState() {
    super.initState();
    _chartTabController =
        TabController(length: 4, vsync: this); // 全部、count、total time、spacing
  }

  @override
  void dispose() {
    _chartTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          ReportProvider(context: context, isWeekly: widget.isWeekly),
      child: Consumer<ReportProvider>(
        builder: (context, provider, child) {
          return AppFrame(
            appBarTitle: S.current.page_report,
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _showReportDialog(context, provider);
                    },
                    child: Text(S.current.query),
                  ),
                  _buildContent(provider),
                  _buildTableWidget(provider),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(ReportProvider provider) {
    return DefaultTabController(
      length: 4, // 根據您的標籤數量調整
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            controller: _chartTabController,
            tabs: [
              Tab(text: S.current.all),
              Tab(text: S.current.smokingStatus_smokeCount),
              Tab(text: S.current.smokingStatus_total_time),
              Tab(text: S.current.smokingStatus_spacing)
            ],
          ),
          SizedBox(
            height: 200, // 這裡你可以調整或根據內容動態設定
            child: TabBarView(
              controller: _chartTabController,
              children: [
                ReportChatWidget(
                    summaryDayList: provider.summaryDayList,
                    column: null,
                    maxBarValue: provider.maxBarValue),
                ReportChatWidget(
                    summaryDayList: provider.summaryDayList,
                    column: 'count',
                    maxBarValue: provider.maxBarValue),
                ReportChatWidget(
                    summaryDayList: provider.summaryDayList,
                    column: 'totalTime',
                    maxBarValue: provider.maxBarValue),
                ReportChatWidget(
                    summaryDayList: provider.summaryDayList,
                    column: 'spacing',
                    maxBarValue: provider.maxBarValue),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showReportDialog(
      BuildContext context, ReportProvider provider) {
    bool localIsWeekly = provider.isWeekly; // 局部变量，用于追踪此对话框中的状态
    DateTimeRange? dateRange = provider.dateRange; // 局部变量，用于追踪此对话框中的状态

    return showDialog(
      useRootNavigator: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text(S.current.query_criteria),
              content: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.7,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(S.current.item),
                        subtitle: Row(
                          children: [
                            Text(localIsWeekly
                                ? S.current.weekly
                                : S.current.daily),
                            const Spacer(),
                            Switch(
                              value: localIsWeekly,
                              onChanged: (value) {
                                setState(() {
                                  localIsWeekly = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        title: Text(S.current.date_range),
                        subtitle: Row(
                          children: [
                            Text(
                                '${DateTimeUtil.getDate(dateRange!.start)} ~ ${DateTimeUtil.getDate(dateRange!.end)}'),
                            IconButton(
                              icon: const Icon(Icons.date_range),
                              onPressed: () async {
                                dateRange = await showDateRangePicker(
                                  context: context,
                                  firstDate: DateTime(DateTime.now().year - 5),
                                  lastDate: DateTime(DateTime.now().year + 5),
                                );
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  child: Text(S.current.cancel),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(S.current.submit),
                  onPressed: () {
                    provider.isWeekly = localIsWeekly; // 局部变量，用于追踪此对话框中的状态
                    provider.dateRange = dateRange; // 局部变量，用于追踪此对话框中的状态
                    provider.loadData(
                        picked: dateRange,
                        Week: localIsWeekly); // 更新provider的状态
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildTableWidget(ReportProvider provider) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
                label: Text(
              S.current.time_date,
            )),
            DataColumn(
                label: Text(
              S.current.smokingStatus_smokeCount,
            )),
            DataColumn(
                label: Text(
              S.current.smokingStatus_total_time,
            )),
            DataColumn(
                label: Text(
              S.current.time_spacingTime,
            )),
          ],
          rows: provider.summaryDayList.map((data) {
            return DataRow(
              cells: [
                DataCell(
                  // Expanded(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // 按需對齊
                    children: [
                      Expanded(
                          child:
                              Text(DateTimeUtil.getDateTime(data.startTime))),
                      Expanded(
                          child: Text(
                              "~ ${DateTimeUtil.getDateTime(data.endTime)}")),
                    ],
                  ),
                  // ),
                ),
                DataCell(Text('${data.count}')),
                DataCell(
                    Text('${data.totalTime.inMinutes}${S.current.time_unit}')),
                DataCell(
                    Text('${data.spacing.inMinutes}${S.current.time_unit}')),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
