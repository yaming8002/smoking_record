import 'package:flutter/material.dart';

class ScalableIconButton extends StatelessWidget {
  final IconData iconData; // Icon 的圖示
  final double size; // Icon 的最大寬度
  final VoidCallback onPressed; // Icon 的觸發項目

  ScalableIconButton({
    required this.iconData,
    required this.size,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Container(
          width: size,
          height: size,
          child: Icon(iconData),
        ),
      ),
    );
  }
}
