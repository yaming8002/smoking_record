import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/SmokingStatus.dart';
import '../../core/providers/EditRecordProvider.dart';
import '../../generated/l10n.dart';
import '../widgets/AppFrame.dart';
import '../widgets/input/DateTimePickerWidget.dart';
import '../widgets/input/cigaretteAmountWidget.dart';

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
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTextField(
                      'Count',
                      CigaretteAmountWidget(
                        onAmountChanged: (newAmoun) {
                          provider.status.count = newAmoun;
                        },
                      ),
                    ),
                    Text(S.current.time_startTime,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    DateTimePickerWidget(
                      dateController: provider.startDateController!,
                      timeController: provider.startTimeController!,
                      onDateTimeChanged: (newDateTime) {
                        provider.status.startTime = newDateTime;
                      },
                    ),
                    Text(S.current.time_endTime,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    DateTimePickerWidget(
                      dateController: provider.endDateController!,
                      timeController: provider.endTimeController!,
                      onDateTimeChanged: (newDateTime) {
                        provider.status.endTime = newDateTime;
                      },
                    ),
                    ListTile(
                      title: Text(S.current.smokingStatus_evaluate),
                      trailing: DropdownButton<int>(
                        value: provider.status.evaluate,
                        onChanged: (value) {
                          setState(() {
                            provider.status.evaluate = value!;
                          });
                        },
                        items: ratings.map((rating) {
                          return DropdownMenuItem<int>(
                            value: rating,
                            child: Text(rating.toString()),
                          );
                        }).toList(),
                      ),
                    ),
                    ElevatedButton(
                      child: Text(S.current.setting_save),
                      onPressed: () async {
                        await provider.updateSmokingStatus();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget _buildTextField(String label, StatefulWidget widget) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Text(label),
        Expanded(
          child: widget,
        ),
      ],
    ),
  );
}
