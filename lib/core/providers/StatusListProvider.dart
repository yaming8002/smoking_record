import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  DateTime? selectedDate;
  Database? db;
  List<String> dateList = [];
  List<SmokingStatus> smokingList = [];
  int currentPage = 0;
  final int itemsPerPage = 10;

  StatusListProvider(this.context)
      : service = Provider.of<SmokingSatusService>(context) {
    dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    loadData();
  }

  Future<void> loadData() async {
    final range =
        DateTimeUtil.getOneDateRange(DateTime.parse(dateController.text));
    smokingList = await service.selectByRang(currentPage, itemsPerPage, [
      DateTimeUtil.getDateTime(range[0]),
      DateTimeUtil.getDateTime(range[1])
    ]);
    notifyListeners();
  }

  selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      selectedDate = pickedDate;
      dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate!);
      loadData();
      notifyListeners();
    }
  }

  void onNavigateToEditPage(context, item) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditSomkingPage(status: item),
      ),
    );
    notifyListeners();
  }
}
