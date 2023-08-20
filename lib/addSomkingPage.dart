import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smoking_record/settingPage.dart';
import 'databace/DatabaseHelper.dart';
import 'databace/SmokingStatus.dart';

class AddSomkingPage extends StatefulWidget {
  final SmokingStatus status;

  AddSomkingPage({Key? key, required this.status}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}


class _AddPageState extends State<AddSomkingPage> {
  static const double cardWidth = 200; // Adjust as needed
  static const double cardHeight = 100; // Adjust as needed
  static const List<int> ratings = [1, 2, 3, 4, 5];
  AppSettings appSettings = AppSettings();

  Timer? _timer;
  int? _selectedNum;
  int? _smokingEvaluate = 3;

  String _timeDiff = "00:00:00";
  Duration? _smokingSpacing;

  @override
  void initState() {
    super.initState();
    _selectedNum = widget.status.count;
    _smokingEvaluate = widget.status.evaluate;
    _smokingSpacing = widget.status.spacing;
    _startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 這裡可以安全地顯示對話框或進行其他UI操作
      _showAdv();
    });
  }

  Future<void> _initAppSettings() async {
    // await appSettings.init();
    _showAdv();
  }

  Future<void> _showAdv() async {
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
  }


  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _timeDiff = _formatDuration(
            DateTime.now().difference(widget.status.startTime));
      });
    });
  }

  String _formatDuration(Duration d) {
    if (d == null) {
      return '00:00:00';
    }
    String hours = d.inHours.remainder(24).toString().padLeft(2, '0');
    String minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  Future<int> getUserSettings(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 5; // 如果找不到對應的設定值，返回一個默認值
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
        title: Text('Add Page'),
      ),
      body: Center(
        child: Column(
          //   InputCardFormatCard(
          //     title: '距離上一次',
          //     subtitle: '$_spacing',
          //   ),
          children: [
            Container(
              width: cardWidth,
              height: cardHeight,
              child: Card(
                child: Column(
                  children: [
                    Text('持續時間'),
                    ListTile(
                      subtitle: Text(_timeDiff),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: cardWidth,
              height: cardHeight,
              child: Card(
                child: Column(
                  children: [
                    Text('距離上一次'),
                    ListTile(
                      title:Text(_smokingSpacing == null ? "00:00:00" : _formatDuration(_smokingSpacing!) ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: cardWidth,
              height: cardHeight,
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('抽菸數'),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (_selectedNum! > 0) {
                                _selectedNum = _selectedNum! - 1;
                              }
                            });
                          },
                        ),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: TextEditingController(text: '$_selectedNum'),
                            onSubmitted: (value) {
                              setState(() {
                                _selectedNum = int.tryParse(value) ?? _selectedNum;
                              });
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              _selectedNum = _selectedNum! + 1;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: cardWidth,
              height: cardHeight,
              child: Card(
                child: Column(
                  children: [
                    Text('心情評分'),
                    SizedBox(
                      height: 50, // Adjust based on your requirements
                      child: Row(
                        children: ratings.map((rating) {
                          return Expanded(
                            child: RadioListTile<int>(
                              value: rating,
                              groupValue: _smokingEvaluate,
                              onChanged: (value) {
                                setState(() {
                                  _smokingEvaluate = value!;
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () async {
                // Update the history data
                widget.status.count = _selectedNum!;
                widget.status.evaluate = _smokingEvaluate!;
                widget.status.endTime = DateTime.now();
                widget.status.totalTime = DateTime.now().difference(widget.status.startTime);
                widget.status.spacing = _smokingSpacing ;

                // Insert into the database
                await DBHelper.insertSmokingStatus( widget.status.toMap());

                // Pop the current page off the navigation stack
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: Text('Save by count '),
              onPressed: () async {
                // Update the history data
                widget.status.count = _selectedNum!;
                widget.status.evaluate = _smokingEvaluate!;
                int totalSmokingTimeInSeconds = _selectedNum! * (AppSettings.getAverageSmokingTime() );
                widget.status.totalTime = Duration(seconds: totalSmokingTimeInSeconds);
                widget.status.endTime =  widget.status.startTime.add( widget.status.totalTime) ;
                widget.status.spacing = _smokingSpacing ;

                // Check if smokingEndTime is greater than now
                if (widget.status.endTime.isAfter(DateTime.now())) {
                  // Show a message to the user or handle this condition as needed
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('End time cannot be in the future!')),
                  );
                  return;
                }

                // Insert into the database
                await DBHelper.insertSmokingStatus( widget.status.toMap());

                // Pop the current page off the navigation stack
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}