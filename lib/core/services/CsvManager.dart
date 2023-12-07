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
    print(csvString);
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
      Set<DateTime> dates = {};
      List<SmokingStatus> list = [];
      for (var line in lines.skip(1)) {
        List<dynamic> csvRow = const CsvToListConverter().convert(line).first;
        list.add(SmokingStatus.fromCsv(csvRow));
        dates.add(list[list.length - 1].startTime);
      }

      list.sort((a, b) => a.startTime.compareTo(b.startTime));
      list[0].interval = Duration.zero;
      for (int i = 1; i < list.length; i += 1) {
        satusService.insertSmokingStatus(list[i - 1].toMap());
        list[i].interval =
            _checkIntervalValid(list[i - 1].endTime, list[i].startTime);
      }
      await summaryService.deleteAll();
      await summaryService.generateSummaries(dates);
      // return int.parse(contents);
    } catch (e, s) {
      print('Exception: $e');
      print('Stack Trace: $s');
      // If encountering an error, return 0
      // return 0;
    }
  }

  Duration _checkIntervalValid(DateTime a /*last end */, DateTime b /*start*/) {
    Duration interval = b.difference(a);
    if (DateTimeUtil.getDate(a) == DateTimeUtil.getDate(b) &&
        interval > Duration.zero &&
        interval.inHours < 6) {
      return interval;
    }
    return Duration.zero; // startTime.difference(endTime);
  }
}
