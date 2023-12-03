import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TitleWithContentTemplate extends StatelessWidget {
  final String title;
  final Widget child;

  const TitleWithContentTemplate(
      {super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black)),
              ),
              child: AutoSizeText(
                title,
                minFontSize: 10, // 這裡是最小的字體大小
                maxFontSize: 20, // 這裡是最大的字體大小
                style: const TextStyle(fontSize: 20),
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned.fill(
            top: 40, // or adjust this value according to the title's height
            child: Padding(
              padding:
                  EdgeInsets.only(top: 10.0), // gap between title and content
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
