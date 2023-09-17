import 'dart:async';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smoking_record/utils/dateTimeUtil.dart';

import '../models/SmokingStatus.dart';
import 'SmokingSatusService.dart';
import 'SummaryService.dart';

class CsvManager {
  late SmokingSatusService satusService;
  late SummaryService summaryService;

  CsvManager(BuildContext context) {
    satusService = Provider.of<SmokingSatusService>(context, listen: false);
    summaryService = Provider.of<SummaryService>(context, listen: false);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _localFile([String? filePath]) async {
    final path = await _localPath;
    String buildPath = '$path/${filePath ?? 'basefile.txt'}';
    return File(buildPath);
  }

  /// 导出数据到CSV文件并分享
  Future<void> exportDataToCsv() async {
    // 1. 将数据转换为CSV格式

    final csvString = await satusService.selectAll();
    final file = await _localFile('smokingRcord${DateTimeUtil.getDate()}.csv');
    file.writeAsString(csvString);

    List<XFile> xFiles = [XFile(file.path)];
    Share.shareXFiles(xFiles,
        subject: 'SmokingRecords${DateTimeUtil.getDate()}.csv');
  }

  Future<void> importCsvAndSaveToDatabase() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    try {
      File file = File(result!.files.single.path!);
      satusService.deleteAll();
      // final List<SmokingStatus> statusList = [];
      final lines = await file.readAsLines();
      Set<String> dates = {};
      for (var line in lines.skip(1)) {
        List<dynamic> csvRow = const CsvToListConverter().convert(line).first;
        SmokingStatus status = SmokingStatus.fromCsv(csvRow);
        dates.add(DateTimeUtil.getDate(status.endTime));
        satusService.insertSmokingStatus(status.toMap());
      }
      print(dates);
      await summaryService.generateSummaries(dates);

      // return int.parse(contents);
    } catch (e, s) {
      print('Exception: $e');
      print('Stack Trace: $s');
      // If encountering an error, return 0
      // return 0;
    }
  }
}
