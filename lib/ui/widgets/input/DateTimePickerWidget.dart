import 'package:flutter/material.dart';
import 'package:smoking_record/utils/dateTimeUtil.dart';

class DateTimePickerWidget extends StatefulWidget {
  final TextEditingController dateController;
  final TextEditingController timeController;
  final Function(DateTime) onDateTimeChanged; // callback for date

  const DateTimePickerWidget({
    Key? key,
    required this.dateController,
    required this.timeController,
    required this.onDateTimeChanged,
  }) : super(key: key);

  @override
  _DateTimePickerWidgetState createState() => _DateTimePickerWidgetState();
}

class _DateTimePickerWidgetState extends State<DateTimePickerWidget> {
  @override
  void initState() {
    super.initState();

    // 如果日期控制器沒有值，設定為當天日期
    if (widget.dateController.text.isEmpty) {
      widget.dateController.text = DateTimeUtil.getDate();
    }

    // 如果時間控制器沒有值，設定為00:00:00
    if (widget.timeController.text.isEmpty) {
      widget.timeController.text = DateTimeUtil.getTime();
    }
  }

  Future<void> _selectDate(TextEditingController controller) async {
    DateTime? initialDate =
        DateTime.tryParse(controller.text) ?? DateTime.now();
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null && selectedDate != initialDate) {
      setState(() {
        controller.text = DateTimeUtil.getDate(selectedDate);
      });
      _triggerDateTimeCallback(); // call the callback
    }
  }

  Future<void> _selectTime(TextEditingController controller) async {
    TimeOfDay initialTime =
        DateTimeUtil.parseTime(controller.text) ?? TimeOfDay.now();

    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (selectedTime != null && selectedTime != initialTime) {
      setState(() {
        controller.text = DateTimeUtil.getTime(time: selectedTime);
      });
      _triggerDateTimeCallback(); // call the callback
    }
  }

  void _triggerDateTimeCallback() {
    String combinedDateTime =
        "${widget.dateController.text} ${widget.timeController.text}";
    widget.onDateTimeChanged(DateTime.parse(combinedDateTime));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            title: Text('Date'), // 固定的標籤
            subtitle: Text(widget.dateController.text),
            trailing: IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () {
                _selectDate(widget.dateController);
              },
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: ListTile(
            title: Text('Time'), // 固定的標籤
            subtitle: Text(widget.timeController.text),
            trailing: IconButton(
              icon: Icon(Icons.access_time),
              onPressed: () {
                _selectTime(widget.timeController);
              },
            ),
          ),
        ),
      ],
    );
  }
}
