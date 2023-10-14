import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../utils/dateTimeUtil.dart';

/// `DateTimePicker` 是一個小部件，允許用戶觀看或修改日期和時間。
/// 它還具有一個切換按鈕，以決定是否使用某個基準時間。
class DateTimePicker extends StatefulWidget {
  final bool isAdd; // 是否為添加模式
  final bool useReferenceTime; // 是否使用參考時間
  final DateTime referenceDateTime; // 參考日期和時間
  final Function(DateTime datetime) onDateTimeChanged; // 日期或時間更改時的回調
  final ValueChanged<bool> onReferenceToggleChanged; // 切換參考時間時的回調

  const DateTimePicker({
    Key? key,
    this.isAdd = true,
    this.useReferenceTime = false,
    required this.referenceDateTime,
    required this.onDateTimeChanged,
    required this.onReferenceToggleChanged,
  }) : super(key: key);

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime selectedDateTime = DateTime.now();
  String selectedDate = DateTimeUtil.getDate();
  String selectedTime = DateTimeUtil.getTime();
  double? formatDefault;

  @override
  void didUpdateWidget(DateTimePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      selectedDateTime = widget.referenceDateTime;
      selectedDate = DateTimeUtil.getDate(selectedDateTime);
      selectedTime = DateTimeUtil.getTime(date: selectedDateTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    formatDefault = Theme.of(context).textTheme.titleLarge!.fontSize!;
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        if (!widget.isAdd)
          TextButton(
            onPressed: widget.isAdd
                ? null
                : () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDateTime,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null && pickedDate != selectedDateTime) {
                      setState(() {
                        selectedDateTime = DateTime(
                          pickedDate.year,
                          pickedDate.month,
                          pickedDate.day,
                          selectedDateTime.hour,
                          selectedDateTime.minute,
                          selectedDateTime.second,
                        );
                      });
                      widget.onDateTimeChanged(selectedDateTime);
                    }
                  },
            child: AutoSizeText(
              selectedDate,
              style: TextStyle(fontSize: formatDefault),
              minFontSize: 8,
              maxFontSize: 30,
            ),
          ),
        if (!widget.isAdd) const SizedBox(width: 3.0),
        TextButton(
          onPressed: widget.isAdd
              ? null
              : () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(selectedDateTime),
                  );
                  if (pickedTime != null &&
                      pickedTime != TimeOfDay.fromDateTime(selectedDateTime)) {
                    setState(() {
                      selectedDateTime = DateTime(
                        selectedDateTime.year,
                        selectedDateTime.month,
                        selectedDateTime.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );
                    });
                    widget.onDateTimeChanged(selectedDateTime);
                  }
                },
          child: AutoSizeText(
            selectedTime,
            style: TextStyle(fontSize: formatDefault),
            minFontSize: 8,
            maxFontSize: 30,
          ),
        ),
        if (widget.isAdd) const Spacer(),
        if (widget.isAdd)
          AutoSizeText(
            S.current.add_Estimate,
            style: TextStyle(fontSize: formatDefault),
            minFontSize: 10,
            maxFontSize: 30,
          ),
        if (widget.isAdd)
          CupertinoSwitch(
            value: widget.useReferenceTime,
            onChanged: widget.onReferenceToggleChanged,
          ),
      ],
    );
  }
}
