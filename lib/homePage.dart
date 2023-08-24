import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smoking_record/reportPage.dart';
import 'package:smoking_record/settingPage.dart';
import 'package:sqflite/sqflite.dart';

import 'SmokingListPage.dart';
import 'addSomkingPage.dart';
import 'databace/SmokingStatus.dart';

class HomePage extends StatefulWidget {
  final Database database;

  HomePage({super.key, required this.database});

  // 這個 widget , required Database database是你應用的主頁。它是有狀態的，意味著
  // 它有一個狀態對象（在下面定義），該對象包含影響其外觀的字段。

  // 這個類別是狀態的配置。它保存了由父級（在本例中為 App widget）提供的值，
  // 被 State 的 build 方法使用。在一個 Widget 子類中的字段總是標記為 "final"。

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  Timer? _timer;
  DateTime? _targetTime;
  String timeDiff = "00:00:00";
  int? dayTotalNum;
  int? weekTotalNum;
  Duration? dayAllTime;
  Duration? weekAllTime;
  Duration? daySpacing;
  Duration? weekSpacing;
  Database? db;

  @override
  void initState() {
    super.initState();
    db = widget.database;
    loadData().then((_) {
      _startTimer();
    });
  }

  Future<void> loadData() async {
    await getDayAndWeekTotalNum();
  }


  String? formatDate(String? isoDate) {
    if (isoDate == null) {
      return isoDate ;
    }
    DateTime parsedDate = DateTime.parse(isoDate);
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(parsedDate);
  }

  Future<void> getLastEndTime() async {
    final maps = await db?.rawQuery(
        "SELECT endTime FROM SmokingStatus ORDER BY endTime DESC LIMIT 1");

    if (maps != null && maps.isNotEmpty) {
      final   formattedEndTime = formatDate((maps.first['endTime'] as String?)) ;
      String now = DateFormat('yyyy-MM-dd').format(DateTime.now()) ;
      print(formattedEndTime) ;
      final timeChange = '$now ${AppSettings.getTimeChange()}';

      print(timeChange) ;
      if (formattedEndTime != null &&
          formattedEndTime.compareTo(timeChange) >= 0) {
        setState(() {
          _targetTime = DateTime.parse(formattedEndTime);
        });
      }
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_targetTime != null) {
          timeDiff = _formatDuration(DateTime.now().difference(_targetTime!));
        } else {
          timeDiff = "00:00:00";
        }
      });
    });
  }

  String _formatDuration(Duration d) {
    String hours = d.inHours.remainder(24).toString().padLeft(2, '0');
    String minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  List<String> daterange(DateTime now) {
    String timeChange = AppSettings.getTimeChange();
    String formattedStartOfWeekDate = DateFormat("yyyy-MM-dd")
        .format(now.subtract(Duration(days: now.weekday - 1)));
    DateTime startDateTime =
        DateTime.parse('$formattedStartOfWeekDate $timeChange');
    DateTime endDateTime = startDateTime.add(Duration(days: 7));
    List<String> list = [
      DateFormat("yyyy-MM-dd").format(startDateTime),
      DateFormat("yyyy-MM-dd").format(endDateTime)
    ];
    return list;
  }

  Future<void> getDayAndWeekTotalNum() async {
    await getLastEndTime();

    DateTime now = DateTime.now();
    String todayStart = DateFormat("yyyy-MM-dd").format(now);
    List<String> rangeDate = daterange(now);
    String weekSelect = '''SELECT  
      SUM(count) as smokeCount, 
      SUM(totalTime) as totalSmokingTime, 
      avg(spacing) as smokingInterval 
      FROM summaryDay WHERE sDate >= ? and  sDate <= ? ''';

    // Query for the week data
    final weekTotalres = await db?.rawQuery(weekSelect, rangeDate);
    if (weekTotalres != null && weekTotalres.isNotEmpty) {
      setState(() {
        weekTotalNum = (weekTotalres.first['smokeCount'] ?? 0) as int;
        weekAllTime = Duration(
            milliseconds: (weekTotalres.first['totalSmokingTime'] ?? 0) as int);
        weekSpacing = Duration(
            milliseconds:
                (weekTotalres.first['smokingInterval'] as double? ?? 0.0)
                    .round());
      });
    }
    String daySelect = '''SELECT * FROM summaryDay WHERE sDate = ? ''';
    // Query for the day data
    final res = await db?.rawQuery(daySelect, [todayStart]);

    if (res != null && res.isNotEmpty) {
      setState(() {
        dayTotalNum = (res.first['count'] ?? 0) as int;
        dayAllTime =
            Duration(milliseconds: (res.first['totalTime'] ?? 0) as int);
        daySpacing =
            Duration(milliseconds: (res.first['spacing'] as int? ?? 0).round());
      });
    }
  }

  void _navigateToSecondPage() async {
    // 创建 HistoryList 并设置当前时间
    SmokingStatus newStatus = SmokingStatus(
      null,
      // 此處設定為 null 以便 SQLite 自動生成一個 ID
      1,
      // 這是一個代表菸數的範例數值，請替換為實際菸數
      DateTime.now(),
      // 這是抽菸開始時間，現在設定為當前時間
      DateTime.now(),
      // 這是抽菸結束時間，現在設定為當前時間
      3,
      // 這是一個代表評價等級的範例數值，請替換為實際評價等級
      DateTime.now().difference(DateTime.now()),
      // 此處為總抽菸時間，目前為 0，因為起始和結束時間相同
      _targetTime == null
          ? null
          : DateTime.now().difference(_targetTime!), // 這是抽菸的間隔時間，
    );

    print(newStatus.toString());
    await Navigator.push(
      // 必須新增 await 否則會先執行厚片的代碼 getDayAndWeekTotalNum()
      context,
      MaterialPageRoute(
          builder: (context) => AddSomkingPage(status: newStatus)),
    );
    // 从 addSomkingPage 返回后，重新获取 _targetTime
    getDayAndWeekTotalNum();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getLastEndTime();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Home'),
        actions: <Widget>[
          /*
          IconButton(
            icon: Icon(Icons.edit), // 編輯圖標
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SmokingListPage(database: widget.database,)),
              );
            },
          ),*/
          IconButton(
            icon: Icon(Icons.settings), // 設定圖標
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double radius = constraints.maxWidth < constraints.maxHeight
                      ? constraints.maxWidth / 3
                      : constraints.maxHeight / 3;
                  return GestureDetector(
                    onTap: _navigateToSecondPage,
                    child: CircleAvatar(
                      radius: radius,
                      backgroundColor: Colors.red,
                      child: Text(
                        timeDiff!,
                        style: TextStyle(fontSize: radius / 5),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  // 今日區塊
                  _buildInfoSection('今日','一週', dayTotalNum, dayAllTime, daySpacing),
                  SizedBox(height: 20.0), // 間距
                  // 本週區塊
                  _buildInfoSection(
                      '本週', '一週', weekTotalNum, weekAllTime, weekSpacing),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildAdBanner(),
    );
  }

  Widget _buildAdBanner() {
    return Container(
      height: 50, // 這是廣告的高度，可以根據你的需要調整
      color: Colors.grey[300], // 廣告的背景顏色
      child: Center(
        child: Text(
          '這裡是廣告',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildInfoSection(
      String title,String dropdownValue, int? totalNum, Duration? allTime, Duration? spacing) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ReportPage(dropdownValue:dropdownValue)),
          );
        },
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: <Widget>[
              Text(title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _buildInfoCard(context, '吸菸數', totalNum?.toString() ?? "0"),
                  _buildInfoCard(context, '累計時間',
                      _formatDuration(allTime ?? Duration.zero)),
                  _buildInfoCard(context, '平均間隔',
                      _formatDuration(spacing ?? Duration.zero)),
                ],
              ),
            ],
          ),
        ));
  }

  Widget _buildInfoCard(BuildContext context, String title, String content) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = (screenWidth - (4 * 8)) / 3; // 減去邊界和間距

    return Container(
      width: cardWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(4.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 使內容居中
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center, // 文字居中
            ),
            SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center, // 文字居中
            ),
          ],
        ),
      ),
    );
  }
}
