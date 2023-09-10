import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smoking_record/core/models/SmokingStatus.dart';
import 'package:smoking_record/core/services/SmokingSatusService.dart';

import '../../utils/dateTimeUtil.dart';
import '../services/SummaryService.dart';

class EditRecordProvider with ChangeNotifier {
  final SmokingSatusService service;
  final SummaryService summaryService;
  final SmokingStatus status;
  TextEditingController? countController;
  TextEditingController? startDateController;
  TextEditingController? startTimeController;
  TextEditingController? endDateController;
  TextEditingController? endTimeController;

  EditRecordProvider(BuildContext context, this.status)
      : service = Provider.of<SmokingSatusService>(context),
        summaryService = Provider.of<SummaryService>(context) {
    loadData();
  }

  Future<void> loadData() async {
    countController = TextEditingController(text: status.count.toString());
    startDateController =
        TextEditingController(text: DateTimeUtil.getDate(status.startTime));
    startTimeController = TextEditingController(
        text: DateTimeUtil.getTime(date: status.startTime));
    endDateController =
        TextEditingController(text: DateTimeUtil.getDate(status.endTime));
    endTimeController =
        TextEditingController(text: DateTimeUtil.getTime(date: status.endTime));

    notifyListeners();
  }

  updateSmokingStatus() async {
    status.totalTime = status.endTime.difference(status.startTime);
    service.updateSmokingStatus(status.toMap());
    await summaryService
        ?.updateSummaryDay(status.endTime.toIso8601String().substring(0, 10));
  }
}
