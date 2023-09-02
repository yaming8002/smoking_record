import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/SmokingStatus.dart';
import '../../core/providers/AddPageProvider.dart';
import '../../generated/l10n.dart';
import '../../utils/dateTimeUtil.dart';
import '../widgets/AppFrame.dart';
import '../widgets/input/cigaretteAmountWidget.dart';

class AddPage extends StatefulWidget {
  final SmokingStatus status;

  const AddPage({Key? key, required this.status}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddPageProvider(context, widget.status),
      child: Consumer<AddPageProvider>(
        builder: (context, provider, child) {
          return AppFrame(
            appBarTitle: S.current.addPage,
            body: Center(
              child: Column(
                children: [
                  Container(
                    width: provider.cardWidth,
                    height: provider.cardHeight,
                    child: Card(
                      child: Column(
                        children: [
                          Text('持續時間'),
                          ListTile(
                            subtitle: Text(provider.timeDiff),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: provider.cardWidth,
                    height: provider.cardHeight,
                    child: Card(
                      child: Column(
                        children: [
                          Text('距離上一次'),
                          Text(DateTimeUtil.formatDuration(
                              provider.status.spacing ?? Duration.zero))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: provider.cardWidth,
                    height: provider.cardHeight,
                    child: Card(
                      child: Column(
                        children: [
                          Text('抽菸數'),
                          CigaretteAmountWidget(
                            onAmountChanged: (newAmoun) {
                              provider.status.count = newAmoun;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: provider.cardWidth,
                    height: provider.cardHeight,
                    child: Card(
                      child: Column(
                        children: [
                          Text('心情評分'),
                          SizedBox(
                            height: 50, // Adjust based on your requirements
                            child: Row(
                              children: provider.ratings.map((rating) {
                                return Expanded(
                                  child: RadioListTile<int>(
                                    value: rating,
                                    groupValue: provider.status.evaluate,
                                    onChanged: (value) {
                                      setState(() {
                                        provider.status.evaluate = value!;
                                      });
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: Text('Save'),
                        onPressed: () async {
                          await provider.insertSmokingStatus(
                              isByCount: false, status: widget.status);
                          Navigator.pop(context);
                        },
                      ),
                      ElevatedButton(
                        child: Text('Save by count'),
                        onPressed: () async {
                          await provider.insertSmokingStatus(
                              isByCount: true,
                              status: widget.status,
                              onError: (errorMessage) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(errorMessage)),
                                );
                              });
                          // Handle the SnackBar message here if the end time is in the future.
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
