import 'package:flutter/cupertino.dart';

import '../../../generated/l10n.dart';
import '../../AppFrame.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppFrame(
      appBarTitle: S.current.privacyPolicy_title,
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          _sectionTitle(S.current.privacyPolicy_section1_title),
          _sectionContent(S.current.privacyPolicy_section1_content),
          _sectionTitle(S.current.privacyPolicy_section2_title),
          _sectionContent(S.current.privacyPolicy_section2_content),
          _sectionTitle(S.current.privacyPolicy_section3_title),
          _sectionContent(S.current.privacyPolicy_section3_content),
          _sectionTitle(S.current.privacyPolicy_section4_title),
          _sectionContent(S.current.privacyPolicy_section4_content),
          _sectionTitle(S.current.privacyPolicy_section5_title),
          _sectionContent(S.current.privacyPolicy_section5_content),
          _sectionTitle(S.current.privacyPolicy_section6_title),
          _sectionContent(S.current.privacyPolicy_section6_content),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _sectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        content,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
