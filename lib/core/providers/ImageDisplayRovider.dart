import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../generated/l10n.dart';
import '../../utils/dateTimeUtil.dart';
import '../models/summaryDay.dart';
import '../services/SummaryService.dart';

class ImageDisplayProvider with ChangeNotifier {
  bool _isImageVisible = true;
  String _textOnImage = 'Default Text';
  String _defaultOnImage = 'Default Text';
  final SummaryService summaryService;
  final GlobalKey _repaintKey = GlobalKey();

  BuildContext context;

  ImageDisplayProvider(this.context)
      : summaryService = Provider.of<SummaryService>(context) {
    _updateInitialText();
  }

  bool get isImageVisible => _isImageVisible;

  String get textOnImage => _textOnImage;

  bool _compareTodayAndYesterday = true; // 新增狀態

  bool get compareTodayAndYesterday => _compareTodayAndYesterday;

  Future<void> toggleComparison() async {
    _compareTodayAndYesterday = !_compareTodayAndYesterday;
    _updateInitialText();
    // 可能需要其他的邏輯來更新 _textOnImage
  }

  void _updateInitialText() async {
    String date = _compareTodayAndYesterday
        ? DateTimeUtil.getDate()
        : // 取得今天的日期
        DateTimeUtil.getDate(DateTimeUtil.getYesterday()); // 取得昨天的日期
    String yesterday =
        DateTimeUtil.getDate(DateTimeUtil.getYesterday(today: date));
    SummaryDay thisSummary = await summaryService.getDayTotalNum(date);
    SummaryDay beforeSummary = await summaryService.getDayTotalNum(yesterday);
    print(thisSummary);
    print(beforeSummary);
    if (thisSummary.count < beforeSummary.count) {
      _defaultOnImage = S.current.image_Smoking_Less(thisSummary.sDate);
      //  "${thisSummary.sDate} 吸菸數比前一天少${thisSummary.count - beforeSummary.count} \n 有開始減少數量\n";
    } else if (thisSummary.count == beforeSummary.count) {
      _defaultOnImage = S.current.image_Smoking_Equal(thisSummary.sDate);
      // "${thisSummary.sDate} 吸菸數跟前一天一樣\n  我們努力一天減少一根就好\n";
    } else {
      _defaultOnImage = S.current.image_Smoking_More(thisSummary.sDate);
      // "${thisSummary.sDate} 吸菸數比前一天多\n  我們再接再厲\n";
    }
    _textOnImage = _defaultOnImage;
    notifyListeners();
  }

  void toggleImageVisibility() {
    _isImageVisible = !_isImageVisible;
    notifyListeners();
  }

  void updateText(String newText) {
    _textOnImage = _defaultOnImage + newText;
    notifyListeners();
  }

  Future<void> shareImage() async {
    final currentFocus = WidgetsBinding.instance.focusManager.primaryFocus;
    if (currentFocus != null) {
      currentFocus.unfocus();
    }
    String path = await captureImageWithText();
    Share.shareFiles(
      [path],
    );
  }

  Future<File> _localFile(String filePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    String buildPath = '$path/$filePath';
    return File(buildPath);
  }

  Future<String> captureImageWithText() async {
    RenderRepaintBoundary boundary =
        _repaintKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    // 設定 pixelRatio 可以增加輸出圖片的解析度

    ui.Image image =
        await boundary!.toImage(pixelRatio: 3.0); // 你可以根據需要調整pixelRatio
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? uint8list = byteData?.buffer.asUint8List();

    final imgFile = await _localFile('temp.png');
    imgFile.writeAsBytesSync(uint8list!.toList());

    return imgFile.path;
  }

  Widget get imageWithText {
    if (!_isImageVisible) return Container();

    final screenWidth = MediaQuery.of(context).size.width;

    return RepaintBoundary(
      key: _repaintKey,
      child: Container(
        width: screenWidth,
        height: screenWidth,
        child: Stack(
          alignment: Alignment.center, // 這確保了 Stack 內的 children 能夠被置中
          children: <Widget>[
            Image.asset(
              'template/backgroud3.jpg',
              fit: BoxFit.cover,
              width: screenWidth,
              height: screenWidth,
            ),
            Text(
              _textOnImage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
