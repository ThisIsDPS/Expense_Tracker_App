import 'package:expense_tracker_3/main.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_3/models/expense.dart';

class DateInput extends StatelessWidget {
  const DateInput(
      {super.key, required this.selectedDate, required this.presentDatePicker});

  final DateTime? selectedDate;
  final void Function() presentDatePicker;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          selectedDate == null
              ? 'No date selected'
              : formatter.format(selectedDate!),
          style: TextStyle(
            color: kColorScheme.primary,
          ),
        ),
        IconButton(
          onPressed: presentDatePicker,
          icon: const Icon(Icons.calendar_month),
        ),
      ],
    );
  }
}
