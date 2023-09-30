import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final String title;
  final Widget? trailing; // 讓 trailing 可為 null
  final VoidCallback? onTap; // 讓 onTap 可為 null

  const SettingsTile({
    super.key,
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: trailing ?? null, // 如果 trailing 為 null 則不顯示
      onTap: onTap, // 如果 onTap 為 null，ListTile 會自動處理成不可點擊
    );
  }
}
