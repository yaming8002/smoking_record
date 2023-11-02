import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smoking_record/core/models/SmokingStatus.dart';
import 'package:smoking_record/utils/dateTimeUtil.dart';

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
                _buildHeader(provider),
                _buildTable(provider),
                _buildPageChanger(provider),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _paddedText(String text) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          children: [Text(text)],
        ),
      ),
    );
  }

  TableRow _tableRowFromItem(SmokingStatus item,
      Function(BuildContext, SmokingStatus) onNavigateToEditPage) {
    return TableRow(
      children: [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => onNavigateToEditPage(context, item),
        ),
        _paddedText('${item.count}'),
        _paddedText(item.startTime.toIso8601String().substring(11, 19)),
        _paddedText(item.endTime.toIso8601String().substring(11, 19)),
        _paddedText(
            DateTimeUtil.formatDuration(item.spacing ?? const Duration())),
      ],
    );
  }

  Widget _buildHeader(StatusListProvider provider) {
    return Row(
      children: [
        Text(S.current.time_date),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: TextField(
              controller: provider.dateController,
              readOnly: true,
              textAlign: TextAlign.right, // 讓文字靠右對齊
              decoration: const InputDecoration(
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
    );
  }

  Widget _buildTable(StatusListProvider provider) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: IntrinsicWidth(
          child: Table(
            border: TableBorder.all(),
            columnWidths: const {
              0: IntrinsicColumnWidth(),
              1: IntrinsicColumnWidth(),
              2: IntrinsicColumnWidth(),
              3: IntrinsicColumnWidth(),
              4: IntrinsicColumnWidth(),
            },
            children: [
              TableRow(
                children: [
                  _paddedText(S.current.setting_edit),
                  _paddedText(S.current.smokingStatus_smokeCount),
                  _paddedText(S.current.time_startTime),
                  _paddedText(S.current.time_endTime),
                  _paddedText(S.current.smokingStatus_spacing),
                ],
              ),
              ...provider.smokingList
                  .map((item) =>
                      _tableRowFromItem(item, provider.onNavigateToEditPage))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageChanger(StatusListProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: provider.currentPage > 0
              ? () {
                  if (provider.currentPage > 0) {
                    provider.currentPage--;
                    provider.loadData();
                  }
                }
              : null,
          child: Text(S.current.page_previous),
        ),
        Text(
            " ${provider.currentPage + 1}"), // Assuming currentPage is zero-based
        ElevatedButton(
          onPressed: provider.smokingList.length < provider.itemsPerPage
              ? null
              : () {
                  provider.currentPage++; // Fixed here
                  provider.loadData();
                },
          child: Text(S.current.page_next),
        ),
      ],
    );
  }
}
