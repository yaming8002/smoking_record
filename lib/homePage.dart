import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'addSomkingPage.dart';
import 'databace/DatabaseHelper.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'databace/SmokingStatus.dart';
import 'layoutFormat/InfoCardBuild.dart';

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

  Future<void> getLastEndTime() async {
    final maps = await db
        ?.rawQuery('SELECT * FROM SmokingStatus ORDER BY id DESC LIMIT 1');
    if (maps != null && maps.isNotEmpty) {
      SmokingStatus lastStatus = SmokingStatus.fromMap(maps.first);
      setState(() {
        _targetTime = lastStatus.smokingEndTime;
      });
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

  Future<void> getDayAndWeekTotalNum() async {
    await getLastEndTime();

    DateTime now = DateTime.now();
    DateTime todayStart = DateTime(now.year, now.month, now.day);
    DateTime weekStart = now.subtract(Duration(days: now.weekday - 1));
    weekStart =
        DateTime(weekStart.year, weekStart.month, weekStart.day, 0, 0, 0);

    // Query for the week data
    final weekTotalres = await db?.rawQuery(
        'SELECT *, SUM(smokeCount) as smokeCount, SUM(totalSmokingTime) as totalSmokingTime, avg(smokingInterval) as smokingInterval '
        'FROM SmokingStatus WHERE smokingStartTime >= ?',
        [weekStart.toIso8601String()]);

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

    // Query for the day data
    final res = await db?.rawQuery(
        'SELECT *, SUM(smokeCount) as smokeCount, SUM(totalSmokingTime) as totalSmokingTime, avg(smokingInterval) as smokingInterval '
        'FROM SmokingStatus WHERE smokingStartTime >= ?',
        [todayStart.toIso8601String()]);

    if (res != null && res.isNotEmpty) {
      setState(() {
        dayTotalNum = (res.first['smokeCount'] ?? 0) as int;
        dayAllTime =
            Duration(milliseconds: (res.first['totalSmokingTime'] ?? 0) as int);
        daySpacing = Duration(
            milliseconds:
                (res.first['smokingInterval'] as double? ?? 0.0).round());
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

    // 提供廣告視窗
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Advertisement'),
          content: Text('This is where the ad goes.'),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double radius = constraints.maxWidth < constraints.maxHeight
                      ? constraints.maxWidth / 2
                      : constraints.maxHeight / 2;
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
              child: GridView.count(
                crossAxisCount: 3,
                children: <Widget>[
                  InfoCardBuild(
                    rowCount: 3,
                    title: '今天的總抽菸數',
                    child: dayTotalNum?.toString() ?? "0",
                  ),
                  InfoCardBuild(
                    rowCount: 3,
                    title: '總抽菸時間',
                    child: _formatDuration(dayAllTime ?? Duration.zero),
                  ),
                  InfoCardBuild(
                    rowCount: 3,
                    title: '時間平均間隔',
                    child: _formatDuration(daySpacing ?? Duration.zero),
                  ),
                  InfoCardBuild(
                    rowCount: 3,
                    title: '本週的總抽菸數',
                    child: dayTotalNum?.toString() ?? "0",
                  ),
                  InfoCardBuild(
                    rowCount: 3,
                    title: '本週的總抽菸時間',
                    child: _formatDuration(weekAllTime ?? Duration.zero),
                  ),
                  InfoCardBuild(
                    rowCount: 3,
                    title: '本週的平均抽菸間距',
                    child: _formatDuration(weekSpacing ?? Duration.zero),
                  ),

                  // buildCard('今天的總抽菸數:', dayTotalNum?.toString() ?? "0"),
                  // // Replace 0 with actual data
                  // buildCard(
                  //     '總抽菸時間:', _formatDuration(dayAllTime ?? Duration.zero)),
                  // // Replace 0 with actual data
                  // buildCard(
                  //     '平均時間間距:', _formatDuration(daySpacing ?? Duration.zero)),
                  // // Replace 0 with actual data
                  // buildCard('本週的總抽菸數:', weekTotalNum?.toString() ?? "0"),
                  // // Replace 0 with actual data
                  // buildCard(
                  //     '總抽菸時間:', _formatDuration(weekAllTime ?? Duration.zero)),
                  // // Replace 0 with actual data
                  // buildCard('本週平均抽菸間距:',
                  //     _formatDuration(weekSpacing ?? Duration.zero)),
                  // Replace 0 with actual data
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
//
// Card buildCard(String title, String data) {
//   return Card(
//     child: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             title,
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           Text(
//             data,
//             style: TextStyle(fontSize: 24),
//           ),
//         ],
//       ),
//     ),
//   );
// }
}
