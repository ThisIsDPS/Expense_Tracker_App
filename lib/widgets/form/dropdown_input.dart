import 'package:expense_tracker_3/main.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_3/models/expense.dart';

// ignore: must_be_immutable
class DropDownInput extends StatefulWidget {
  DropDownInput({super.key, required this.selectedCategory});

  Category selectedCategory;

  @override
  State<DropDownInput> createState() => _DropDownInputState();
}

class _DropDownInputState extends State<DropDownInput> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: widget.selectedCategory,
      style: TextStyle(
        color: kColorScheme.primary,
      ),
      items: Category.values
          .map(
            (category) => DropdownMenuItem(
              value: category,
              child: Text(
                category.name.toUpperCase(),
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value == null) return;
        setState(() {
          widget.selectedCategory = value;
        });
      },
    );
  }
}
