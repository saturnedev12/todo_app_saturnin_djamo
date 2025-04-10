import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'add_task_compoent.dart';

class ReminderPicker extends StatefulWidget {
  final DateTime? initialDateTime;
  final ValueChanged<DateTime> onChanged;

  const ReminderPicker({
    super.key,
    this.initialDateTime,
    required this.onChanged,
  });

  @override
  State<ReminderPicker> createState() => _ReminderPickerState();
}

class _ReminderPickerState extends State<ReminderPicker> {
  DateTime? _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.initialDateTime;
  }

  Future<void> _pickDateTime() async {
    isPopupClosingManually = false;
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(_selectedDateTime ?? DateTime.now()),
      );

      if (time != null) {
        final newDateTime = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );

        setState(() {
          _selectedDateTime = newDateTime;
        });

        widget.onChanged(newDateTime);
      }
    }

    isPopupClosingManually = true;
  }

  @override
  Widget build(BuildContext context) {
    final formatted = _selectedDateTime != null
        ? DateFormat('dd-MM-yyyy à HH:mm').format(_selectedDateTime!)
        : '';

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: (_selectedDateTime != null)
            ? CupertinoColors.systemFill
            : Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      width: _selectedDateTime != null ? 200 : 80,
      child: Row(
        children: [
          IconButton(
            onPressed: _pickDateTime,
            icon: Icon(
              FontAwesomeIcons.solidBell,
              size: 18,
              color: (_selectedDateTime != null)
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
            ),
          ),
          Flexible(
            child: Visibility(
              visible: _selectedDateTime != null,
              child: Text(
                formatted,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
