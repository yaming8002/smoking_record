import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:smoking_record/utils/DateTimeUtil.dart';

import '../../../core/models/SmokingStatus.dart';
import '../../../generated/l10n.dart';
import '../../../utils/ReferenceBool.dart';
import '../../widgets/input/DateTimePicker.dart';
import '../../widgets/input/SmokingCounter.dart';

class SetSmokStatusWidget extends StatefulWidget {
  SmokingStatus? status;
  ReferenceBool startBaseswitch;
  ReferenceBool endBaseswitch;
  final bool isAdd;
  final Function(
          bool startBaseswitch, bool endBaseswitch, SmokingStatus? status)
      savestatus;

  SetSmokStatusWidget({
    required this.status,
    required this.isAdd,
    required this.startBaseswitch,
    required this.endBaseswitch,
    required this.savestatus,
    Key? key,
  }) : super(key: key);

  @override
  _SetSmokStatusWidget createState() => _SetSmokStatusWidget();
}

class _SetSmokStatusWidget extends State<SetSmokStatusWidget> {
  @override
  Widget build(BuildContext context) {
    double? formatH1 = Theme.of(context).textTheme.titleLarge!.fontSize!;
    double? formatH2 = Theme.of(context).textTheme.titleMedium!.fontSize!;
    return ListView(
      children: <Widget>[
        ListTile(
          title: AutoSizeText(
            S.current.time_startTime,
            style: TextStyle(fontSize: formatH1),
            minFontSize: 10,
            maxFontSize: 60,
          ),
          subtitle: DateTimePicker(
            isAdd: widget.isAdd,
            useReferenceTime: widget.startBaseswitch.value,
            referenceDateTime: widget.status!.startTime,
            onDateTimeChanged: (newDateTime) {
              setState(() {
                // 如果 `status` 是一个状态变量并且这个 widget 可以调用 setState，否则你可能需要调整这段逻辑
                widget.status!.startTime = newDateTime; // 更新 startTime 为新选择的时间
              });
            },
            onReferenceToggleChanged: (bool value) {
              widget.startBaseswitch.value = value;
              widget.endBaseswitch.value =
                  value ? !value : widget.endBaseswitch.value;
            },
          ),
        ),
        const Divider(),
        ListTile(
          title: AutoSizeText(
            S.current.time_endTime,
            style: TextStyle(fontSize: formatH1),
            minFontSize: 10,
            maxFontSize: 60,
          ),
          subtitle: DateTimePicker(
            isAdd: widget.isAdd,
            isRun: true,
            useReferenceTime: widget.endBaseswitch.value,
            referenceDateTime: widget.status!.endTime,
            onDateTimeChanged: (newDateTime) {
              setState(() {
                // 如果 `status` 是一个状态变量并且这个 widget 可以调用 setState，否则你可能需要调整这段逻辑
                widget.status!.endTime = newDateTime; // 更新 startTime 为新选择的时间
              });
            },
            onReferenceToggleChanged: (bool value) {
              widget.endBaseswitch.value = value;
              widget.startBaseswitch.value =
                  value ? !value : widget.startBaseswitch.value;
            },
          ),
        ),
        const Divider(),
        ListTile(
          title: AutoSizeText(
            S.current.smokingStatus_total_time,
            style: TextStyle(fontSize: formatH1),
            minFontSize: 10,
            maxFontSize: 60,
          ),
          subtitle: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {},
                child: AutoSizeText(
                  DateTimeUtil.formatDuration(widget.status!.endTime
                      .difference(widget.status!.startTime)),
                  style: TextStyle(fontSize: formatH2),
                  minFontSize: 10,
                  maxFontSize: 60,
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        ListTile(
          title: AutoSizeText(
            S.current.smokingStatus_smokeCount,
            style: TextStyle(fontSize: formatH1),
            minFontSize: 10,
            maxFontSize: 60,
          ),
          subtitle: SmokingCounter(
            initialCount: widget.status!.count,
            onCountChanged: (newAmoun) {
              widget.status!.count = newAmoun;
            },
          ),
        ),
        const Divider(),
        ListTile(
          title: ElevatedButton(
            child: AutoSizeText(
              S.current.setting_save,
              style: TextStyle(fontSize: formatH1),
              minFontSize: 10,
              maxFontSize: 60,
            ),
            onPressed: () async {
              await widget.savestatus(widget.startBaseswitch.value,
                  widget.endBaseswitch.value, widget.status);
            },
          ),
        ),
      ],
    );
  }
}
