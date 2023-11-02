import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/SmokingStatus.dart';
import '../../core/providers/AddPageProvider.dart';
import '../../generated/l10n.dart';
import '../widgets/AppFrame.dart';
import 'subpage/SetSmokStatusWidget.dart';

class AddPage extends StatefulWidget {
  final SmokingStatus status;

  const AddPage({Key? key, required this.status}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  void initState() {
    // 假設您已有一個顯示廣告的方法，並且它是異步的
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showAd();
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddPageProvider(context, widget.status),
      child: Consumer<AddPageProvider>(
        builder: (context, provider, child) {
          return AppFrame(
              appBarTitle: S.current.page_add,
              body: SetSmokStatusWidget(
                status: provider.status,
                isAdd: true,
                startBaseswitch: provider.startBaseswitch,
                endBaseswitch: provider.endBaseswitch,
                savestatus: (byStart, byEnd, newStatus) async {
                  await provider.insertSmokingStatus(
                      byStart: byStart, byEnd: byEnd, status: newStatus!);
                  Navigator.pop(context);
                },
              ));
        },
      ),
    );
  }
}
