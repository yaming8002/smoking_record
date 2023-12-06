import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/models/SmokingStatus.dart';
import '../../ui/pages/editRecordPage.dart';
import '../../utils/dateTimeUtil.dart';
import '../services/SmokingSatusService.dart';

class StatusListProvider with ChangeNotifier {
  final SmokingSatusService service;
  BuildContext context;
  TextEditingController dateController = TextEditingController();
  DateTime? startTime;
  DateTime? endTime;
  // DateTime? selectedDate;
  bool isMultiDate = false;
  Database? db;
  List<String> dateList = [];
  List<SmokingStatus> smokingList = [];
  int currentPage = 0;
  final int itemsPerPage = 10;

  StatusListProvider(this.context, this.startTime, this.endTime)
      : service = Provider.of<SmokingSatusService>(context) {
    loadData();
  }

  Future<void> loadData() async {
    isMultiDate = !DateTimeUtil.isSameDay(startTime, endTime);
    smokingList = await service.selectByRang(
        currentPage, itemsPerPage, startTime, endTime);
    dateController.text = isMultiDate
        ? '${DateTimeUtil.getDate(startTime)}~${DateTimeUtil.getDate(endTime)}'
        : DateTimeUtil.getDate(startTime);

    notifyListeners();
  }

  selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: startTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != startTime) {
      startTime = pickedDate;
      dateController.text = DateTimeUtil.getDate(startTime);
      endTime = startTime;
      loadData();
      notifyListeners();
    }
  }

  selectDateRange() async {
    DateTimeRange? dateRange = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(
          start: startTime ?? DateTime.now(), end: endTime ?? DateTime.now()),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (dateRange != null) {
      startTime = dateRange.start;
      endTime = dateRange.end;

      dateController.text =
          '${DateTimeUtil.getDate(startTime)}~${DateTimeUtil.getDate(endTime)}';
      loadData();
      notifyListeners();
    }
  }

  void onNavigateToEditPage(context, item) async {
    SmokingStatus editItem = SmokingStatus.fromMap(item.toMap());
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditSomkingPage(status: editItem),
      ),
    );
    loadData();
  }

  void addEdit(context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditSomkingPage(
          status: null,
        ),
      ),
    );
    loadData();
  }
}
