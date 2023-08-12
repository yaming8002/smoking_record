// 提取的 Container Widget
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoCardBuild extends StatelessWidget {
  final double rowCount;
  final String title;
  final String child;
  final double width;
  final double height;

  const InfoCardBuild({
    Key? key,
    required this.rowCount,
    required this.title,
    required this.child,
    this.width = double.infinity,
    this.height = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final width = constraints.maxWidth;
        final fontSize = (width / rowCount) * 0.5; // Adjust the font size based on the width of the parent widget.
        return Container(
          width: width,
          height: height,
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: fontSize),
                ),
                Text(
                  child,
                  style: TextStyle(fontSize: fontSize),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}