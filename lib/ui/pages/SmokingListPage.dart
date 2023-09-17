import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/StatusListProvider.dart';
import '../../generated/l10n.dart';
import '../widgets/AppFrame.dart';

class SmokingListPage extends StatefulWidget {
  const SmokingListPage({super.key});

  @override
  _SmokingListPageState createState() => _SmokingListPageState();
}

class _SmokingListPageState extends State<SmokingListPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StatusListProvider(context),
      child: Consumer<StatusListProvider>(
        builder: (context, provider, child) {
          return AppFrame(
            appBarTitle: S.current.page_setting,
            body: Column(
              children: [
                Row(
                  children: [
                    Text(S.current.time_date),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextField(
                          controller: provider.dateController,
                          readOnly: true,
                          textAlign: TextAlign.right, // 讓文字靠右對齊
                          decoration: InputDecoration(
                            border: InputBorder.none, // 移除下劃線
                          ),
                          onTap: provider.selectDate,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: provider.selectDate,
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Table(
                      border: TableBorder.all(),
                      columnWidths: {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(2),
                        3: FlexColumnWidth(2),
                        4: FlexColumnWidth(1),
                      },
                      children: [
                        TableRow(
                          children: [
                            Center(child: Text(S.current.setting_edit)),
                            Center(
                                child:
                                    Text(S.current.smokingStatus_smokeCount)),
                            Center(child: Text(S.current.time_startTime)),
                            Center(child: Text(S.current.time_endTime)),
                            Center(
                                child: Text(S.current.smokingStatus_evaluate)),
                          ],
                        ),
                        ...provider.smokingList.map((item) {
                          return TableRow(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () => provider.onNavigateToEditPage(
                                    context, item),
                              ),
                              Center(child: Text('${item.count}')),
                              Center(
                                  child: Text(item.startTime
                                      .toIso8601String()
                                      .substring(11, 19))),
                              Center(
                                  child: Text(item.endTime
                                      .toIso8601String()
                                      .substring(11, 19))),
                              Center(child: Text('${item.evaluate}')),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      child: Text(S.current.page_previous),
                      onPressed: provider.currentPage > 0
                          ? () {
                              if (provider.currentPage > 0) {
                                provider.currentPage--;
                                provider.loadData();
                              }
                            }
                          : null,
                    ),
                    ElevatedButton(
                      child: Text(S.current.page_next),
                      onPressed: provider.smokingList.length < 10
                          ? null
                          : () {
                              provider.currentPage++; // Fixed here
                              provider.loadData();
                            },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
