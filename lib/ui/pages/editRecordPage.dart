import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/SmokingStatus.dart';
import '../../core/providers/EditRecordProvider.dart';
import '../../utils/ReferenceBool.dart';
import '../widgets/AppFrame.dart';
import '../widgets/SetSmokStatusWidget.dart';

class EditSomkingPage extends StatefulWidget {
  final SmokingStatus status;

  EditSomkingPage({Key? key, required this.status}) : super(key: key);

  @override
  _EditSomkingPageState createState() => _EditSomkingPageState();
}

class _EditSomkingPageState extends State<EditSomkingPage> {
  static const List<int> ratings = [1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditRecordProvider(context, widget.status),
      child: Consumer<EditRecordProvider>(
        builder: (context, provider, child) {
          return AppFrame(
              appBarTitle: 'Edit Page',
              body: SetSmokStatusWidget(
                status: provider.status,
                isAdd: false,
                startBaseswitch: ReferenceBool(false),
                endBaseswitch: ReferenceBool(false),
                savestatus: (byStart, byEnd, newStatus) async {
                  await provider.updateSmokingStatus();
                  Navigator.pop(context);
                },
              ));
        },
      ),
    );
  }
}
