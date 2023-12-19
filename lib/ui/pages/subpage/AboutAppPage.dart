import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../AppFrame.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppFrame(
      appBarTitle: S.of(context).aboutAppTitle, // "關於本程式" 標題
      body: SingleChildScrollView(
        // 使用 SingleChildScrollView
        child: Column(
          // 包裹 Column
          children: <Widget>[
            _sectionTitle(S.current.appGoalTitle), // "目標" 標題
            _sectionContent(S.current.appGoalContent), // 目標內容
            _sectionTitle(S.current.versionNumberTitle), // "版本號" 標題
            _sectionContent("1.0.0"), // 版本號
            _sectionTitle(S.current.authorTitle), // "作者" 標題
            _sectionContent("yaming"), // 作者名稱
            ExpansionTile(
              title: Text(S.current.privacyPolicyTitle), // "隱私權說明" 可展開標題
              children: <Widget>[
                _sectionContent(S.current.privacyPolicyContent), // 隱私政策內容
                // 可以在這裡添加更多的隱私政策相關內容
              ],
            ),
            ExpansionTile(
              title: Text(S.current.legalNoticeTitle), // "法律聲明" 可展開標題
              children: <Widget>[
                _sectionContent(S.current.legalNoticeContent), // 法律聲明內容
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _sectionContent(String content) {
    print(content) ;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        content,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
