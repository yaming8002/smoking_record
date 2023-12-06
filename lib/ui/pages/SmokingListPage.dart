import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smoking_record/core/models/SmokingStatus.dart';
import 'package:smoking_record/utils/dateTimeUtil.dart';

import '../../core/providers/StatusListProvider.dart';
import '../../generated/l10n.dart';
import '../AppFrame.dart';

class SmokingListPage extends StatefulWidget {
  final DateTime? startTime;
  final DateTime? endTime;
  const SmokingListPage(
    this.startTime,
    this.endTime, {
    Key? key,
  }) : super(key: key);

  @override
  _SmokingListPageState createState() => _SmokingListPageState();
}

class _SmokingListPageState extends State<SmokingListPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          StatusListProvider(context, widget.startTime, widget.endTime),
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
            DateTimeUtil.formatDuration(item.interval ?? Duration.zero )),
      ],
    );
  }

  Widget _buildHeader(StatusListProvider provider) {
    return Row(
      children: [
        const SizedBox(width: 10.0),
        Ink(
          width: 35.0,
          height: 35.0,
          decoration: const ShapeDecoration(
            color: Colors.green, // 设置为绿色
            shape: CircleBorder(),
          ),
          child: InkWell(
            onTap: () {
              provider.addEdit(context);
            },
            customBorder: const CircleBorder(),
            child: const Center(
              child: Icon(
                Icons.add,
                color: Colors.white, // 设置图标颜色，这里为白色
              ),
            ),
          ),
        ),
        const SizedBox(width: 5.0),
        Expanded(
          child: ElevatedButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero, // 移除内部填充以允许文本填满整个按钮
              alignment: Alignment.center, // 确保按钮内容（文本）靠右对齐
            ),
            onPressed: () {
              if (provider.isMultiDate) {
                provider.selectDateRange();
              } else {
                provider.selectDate();
              }
            },
            child: Text(provider.dateController.text),
          ),
        ),
        const SizedBox(width: 10.0),
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
                  _paddedText(S.current.smokingStatus_interval),
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
