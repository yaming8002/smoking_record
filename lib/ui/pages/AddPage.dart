import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/SmokingStatus.dart';
import '../../core/providers/AddPageProvider.dart';
import '../../generated/l10n.dart';
import '../widgets/AppFrame.dart';
import '../widgets/SetSmokStatusWidget.dart';
import '../widgets/input/InterstitialState.dart';

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
              )
              // ListView(
              //   children: <Widget>[
              //     ListTile(
              //       title: AutoSizeText(
              //         S.current.time_startTime,
              //         minFontSize: 10,
              //         maxFontSize: 60,
              //       ),
              //       subtitle: DateTimePicker(
              //         isAdd: true,
              //         useReferenceTime: provider.startBaseswitch,
              //         referenceDateTime: provider.status!.startTime,
              //         onDateTimeChanged: (newDateTime) {},
              //         onReferenceToggleChanged: (bool value) {
              //           provider.startBaseswitch = value;
              //           provider.endBaseswitch =
              //               value ? !value : provider.endBaseswitch;
              //         },
              //       ),
              //     ),
              //     const Divider(),
              //     ListTile(
              //       title: AutoSizeText(
              //         S.current.time_endTime,
              //         minFontSize: 10,
              //         maxFontSize: 60,
              //       ),
              //       subtitle: DateTimePicker(
              //         isAdd: true,
              //         useReferenceTime: provider.endBaseswitch,
              //         referenceDateTime: provider.status!.endTime,
              //         onDateTimeChanged: (newDateTime) {},
              //         onReferenceToggleChanged: (bool value) {
              //           provider.endBaseswitch = value;
              //           provider.startBaseswitch =
              //               value ? !value : provider.startBaseswitch;
              //         },
              //       ),
              //     ),
              //     const Divider(),
              //     ListTile(
              //       title: Text(S.current.smokingStatus_cumulativeTime),
              //       subtitle: Row(
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: [
              //           TextButton(
              //             onPressed: () {},
              //             child: AutoSizeText(
              //               provider.timeDiff,
              //               style: TextStyle(fontSize: 18),
              //               minFontSize: 10,
              //               maxFontSize: 60,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     const Divider(),
              //     ListTile(
              //       title: Text(S.current.smokingStatus_smokeCount),
              //       subtitle: SmokingCounter(
              //         onCountChanged: (newAmoun) {
              //           provider.status!.count = newAmoun;
              //         },
              //       ),
              //     ),
              //     const Divider(),
              //     ListTile(
              //       title: ElevatedButton(
              //         child: AutoSizeText(
              //           S.current.setting_save,
              //           style: const TextStyle(fontSize: 18),
              //           minFontSize: 10,
              //           maxFontSize: 60,
              //         ),
              //         onPressed: () async {
              //           await provider.insertSmokingStatus(
              //               isByCount: false, status: widget.status);
              //           Navigator.pop(context);
              //         },
              //       ),
              //       // TODO 後續提供新增後再紀錄的功能
              //       // ElevatedButton(
              //       //   onPressed: () async {
              //       //     await provider.insertSmokingStatus(
              //       //         isByCount: false, status: widget.status);
              //       //     await provider.reAdd(
              //       //         isByCount: false, status: widget.status);
              //       //   },
              //       //   child: AutoSizeText(
              //       //     provider.timeDiff,
              //       //     style: TextStyle(fontSize: 18),
              //       //     minFontSize: 10,
              //       //     maxFontSize: 30,
              //       //   ),
              //       // ),
              //     ),
              //   ],
              // ),
              );
        },
      ),
    );
  }
}
