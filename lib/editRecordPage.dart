import 'package:flutter/material.dart';
import 'databace/DatabaseHelper.dart';
import 'databace/SmokingStatus.dart';

class EditSomkingPage extends StatefulWidget {
  final SmokingStatus status;

  EditSomkingPage({Key? key, required this.status}) : super(key: key);

  @override
  _EditSomkingPageState createState() => _EditSomkingPageState();
}

class _EditSomkingPageState extends State<EditSomkingPage> {
  static const List<int> ratings = [1, 2, 3, 4, 5];
  late TextEditingController _countController;
  late TextEditingController _startDateController;
  late TextEditingController _startTimeController;
  late TextEditingController _endDateController;
  late TextEditingController _endTimeController;
  late TextEditingController _totalTimeController;
  late TextEditingController _spacingController;
  int? _smokingEvaluate;

  @override
  void initState() {
    super.initState();
    _countController = TextEditingController(text: widget.status.count.toString());
    _startDateController = TextEditingController(text: _formatDate(widget.status.startTime));
    _startTimeController = TextEditingController(text: _formatTime(TimeOfDay.fromDateTime(widget.status.startTime)));
    _endDateController = TextEditingController(text: _formatDate(widget.status.endTime));
    _endTimeController = TextEditingController(text: _formatTime(TimeOfDay.fromDateTime(widget.status.endTime)));
    _totalTimeController = TextEditingController(text: widget.status.totalTime.inMilliseconds.toString());
    _spacingController = TextEditingController(text: (widget.status.spacing ?? Duration.zero).inMilliseconds.toString());
    _smokingEvaluate = widget.status.evaluate;
  }
  Future<void> _selectDate(TextEditingController controller) async {
    DateTime? initialDate = DateTime.tryParse(controller.text) ?? DateTime.now();
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null && selectedDate != initialDate) {
      setState(() {
        controller.text = _formatDate(selectedDate);
      });
    }
  }

  Future<void> _selectTime(TextEditingController controller) async {
    TimeOfDay? initialTime = _parseTime(controller.text);
    if (initialTime == null) {
      initialTime = TimeOfDay.now();
    }

    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (selectedTime != null && selectedTime != initialTime) {
      setState(() {
        controller.text = _formatTime(selectedTime);
      });
    }
  }

  TimeOfDay? _parseTime(String time) {
    final parts = time.split(':');
    if (parts.length != 2) return null;

    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return null;

    return TimeOfDay(hour: hour, minute: minute);
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField('Count', _countController),
              Text("開始時間", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              _buildDateTimeField('Start Date', 'Start Time', _startDateController, _startTimeController),
              Text("結束時間", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              _buildDateTimeField('End Date', 'End Time', _endDateController, _endTimeController),

              ListTile(
                title: Text('情緒評分'),
                trailing: DropdownButton<int>(
                  value: _smokingEvaluate,
                  onChanged: (value) {
                    setState(() {
                      _smokingEvaluate = value;
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
                child: Text('Save'),
                onPressed: () async {
                  widget.status.count = int.parse(_countController.text);
                  widget.status.startTime = DateTime.parse('${_startDateController.text} ${_startTimeController.text}');
                  widget.status.endTime = DateTime.parse('${_endDateController.text} ${_endTimeController.text}');
                  widget.status.totalTime = widget.status.endTime.difference(widget.status.startTime);
                  widget.status.evaluate = _smokingEvaluate!;
                   await DBHelper.updateSmokingStatus(widget.status.toMap());
                  Navigator.pop(context,true);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDateTimeField(String dateLabel, String timeLabel, TextEditingController dateController, TextEditingController timeController) {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            title: Text(dateLabel),
            subtitle: Text(dateController.text),
            trailing: IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () {
                _selectDate(dateController);
              },
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: ListTile(
            title: Text(timeLabel),
            subtitle: Text(timeController.text),
            trailing: IconButton(
              icon: Icon(Icons.access_time),
              onPressed: () {
                _selectTime(timeController);
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _countController.dispose();
    _startDateController.dispose();
    _startTimeController.dispose();
    _endDateController.dispose();
    _endTimeController.dispose();
    _totalTimeController.dispose();
    _spacingController.dispose();
    super.dispose();
  }
}
