import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/SmokingStatus.dart';
import '../../core/providers/AddPageProvider.dart';
import '../../generated/l10n.dart';
import '../../utils/dateTimeUtil.dart';
import '../widgets/AppFrame.dart';
import '../widgets/input/InterstitialState.dart';
import '../widgets/input/cigaretteAmountWidget.dart';

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

  Future<void> showAd() async {
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => InterstitialAdWidget()),
    );
    // 如果需要在廣告後進行其他操作，您可以在此處進行
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddPageProvider(context, widget.status),
      child: Consumer<AddPageProvider>(
        builder: (context, provider, child) {
          return AppFrame(
            appBarTitle: S.current.page_add,
            body: Center(
              child: Column(
                children: [
                  Container(
                    width: provider.cardWidth,
                    height: provider.cardHeight,
                    child: Card(
                      child: Column(
                        children: [
                          Text(S.current.smokingStatus_cumulativeTime),
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
                          Text(S.current.smokingStatus_spacing),
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
                          Text(S.current.smokingStatus_smokeCount),
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
                          Text(S.current.smokingStatus_evaluate),
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
                        child: Text(S.current.setting_save),
                        onPressed: () async {
                          await provider.insertSmokingStatus(
                              isByCount: false, status: widget.status);
                          Navigator.pop(context);
                        },
                      ),
                      ElevatedButton(
                        child: Text(S.current.setting_saveByCount),
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
