import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/SmokingStatus.dart';
import '../../core/providers/EditRecordProvider.dart';
import '../../generated/l10n.dart';
import '../../utils/ReferenceBool.dart';
import '../AppFrame.dart';
import 'subpage/SetSmokStatusWidget.dart';

class EditSomkingPage extends StatefulWidget {
  final SmokingStatus? status;

  EditSomkingPage({Key? key, required this.status}) : super(key: key);

  @override
  _EditSomkingPageState createState() => _EditSomkingPageState();
}

class _EditSomkingPageState extends State<EditSomkingPage> {
  static const List<int> ratings = [1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    SmokingStatus status = widget.status ??
        SmokingStatus(null, 1, DateTime.now(), DateTime.now(), 0,
            DateTime.now().difference(DateTime.now()), null);

    return ChangeNotifierProvider(
      create: (_) => EditRecordProvider(context, status),
      child: Consumer<EditRecordProvider>(
        builder: (context, provider, child) {
          return AppFrame(
              appBarTitle: S.current.setting_edit,
              body: SetSmokStatusWidget(
                status: provider.status,
                isAdd: false,
                startBaseswitch: ReferenceBool(false),
                endBaseswitch: ReferenceBool(false),
                savestatus: (byStart, byEnd, newStatus) async {
                  print("ttttttttttttt");
                  await provider.updateSmokingStatus();
                  Navigator.pop(context);
                },
              ));
        },
      ),
    );
  }
}
