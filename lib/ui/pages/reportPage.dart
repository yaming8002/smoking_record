import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/ReportProvider.dart';
import '../widgets/AppFrame.dart';
import '../widgets/ReportChartWidget.dart';
import '../widgets/ReportListWidget.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReportProvider(context),
      child: Consumer<ReportProvider>(
        builder: (context, provider, child) {
          return AppFrame(
            appBarTitle: "Report",
            body: Column(children: [
              Row(children: [
                ElevatedButton(
                  onPressed: () async {
                    final picked = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      initialDateRange: provider.dateRange,
                    );
                    provider.loadData(picked);
                  },
                  child: Text(provider.dateShow ?? ""),
                ),
                DropdownButton<String>(
                  value: provider.column,
                  onChanged: (newValue) => provider.changColumn(newValue),
                  items: provider.columns
                      .map<DropdownMenuItem<String>>((String column) {
                    return DropdownMenuItem<String>(
                      value: column,
                      child: Text(column),
                    );
                  }).toList(),
                ),
              ]),
              ReportChatWidget(
                  summaryDayList: provider.summaryDayList,
                  column: provider.column,
                  maxBarValue: provider.maxBarValue),
              ReportListWidget(summaryDayList: provider.summaryDayList),
            ]),
          );
        },
      ),
    );
  }
}
