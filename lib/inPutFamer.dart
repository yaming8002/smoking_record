import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputCardFormatCard extends StatelessWidget {
  final String title;
  final String subtitle;

  InputCardFormatCard({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth * 0.9;  // 90% of the screen width
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: (screenWidth - cardWidth) / 2), // Center the card horizontally
      child: Container(
        width: cardWidth,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Align text to the center of the Card
              children:[
                Text(title),
                Text(subtitle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}