import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddCardBuild extends StatelessWidget {
  final String title;
  final String data;
  final double width;
  final double height;

  const AddCardBuild({
    Key? key,
    required this.title,
    required this.data,
    this.width = double.infinity,
    this.height = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                data,
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
    );
  }
}
