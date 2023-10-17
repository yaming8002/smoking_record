import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

/// `SmokingCounter` 是一個小部件，用於跟踪和顯示用戶抽煙的次數。
/// 它提供了增加和減少計數的功能按鈕。
class SmokingCounter extends StatefulWidget {
  // 初始的煙的數量
  final int? initialCount;
  // 煙的數量更改時的回調函數
  final Function(int) onCountChanged;

  // 構造函數
  const SmokingCounter(
      {Key? key, this.initialCount, required this.onCountChanged})
      : super(key: key);

  @override
  _SmokingCounterState createState() => _SmokingCounterState();
}

class _SmokingCounterState extends State<SmokingCounter> {
  late TextEditingController countController; // 控制器，用於管理計數的文本字段
  int count; // 當前的計數

  _SmokingCounterState() : count = 1;

  @override
  void initState() {
    super.initState();
    count = widget.initialCount ?? 1;
    countController = TextEditingController(text: count.toString());

    countController.addListener(() {
      int? newCount = int.tryParse(countController.text);
      if (newCount != null) {
        count = newCount;
        widget.onCountChanged(count); // 通知父小部件計數已更改
      }
    });
  }

  void increment() {
    setState(() {
      count++;
      countController.text = count.toString();
      widget.onCountChanged(count); // 通知父小部件計數已更改
    });
  }

  void decrement() {
    setState(() {
      if (count > 1) {
        count--;
        countController.text = count.toString();
        widget.onCountChanged(count); // 通知父小部件計數已更改
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double formatDefault = Theme.of(context).textTheme.titleLarge!.fontSize!;
    return Row(
      children: <Widget>[
        TextButton(
          onPressed: () {},
          child: AutoSizeText(
            count.toString(),
            style: TextStyle(fontSize: formatDefault),
            minFontSize: 10,
            maxFontSize: 30,
          ),
        ),
        const Spacer(),
        IconButton(
          icon: Icon(
            Icons.remove,
            size: formatDefault,
          ),
          onPressed: decrement,
        ),
        IconButton(
          icon: Icon(
            Icons.add,
            size: formatDefault,
          ),
          onPressed: increment,
        ),
      ],
    );
  }
}
