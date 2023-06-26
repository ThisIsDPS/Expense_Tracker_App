import 'package:expense_tracker_3/main.dart';
import 'package:flutter/material.dart';

class TitleInput extends StatelessWidget {
  const TitleInput({super.key, required this.titleController});

  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        color: kColorScheme.onBackground,
      ),
      controller: titleController,
      maxLength: 50,
      decoration: const InputDecoration(
        labelText: 'Title',
      ),
    );
  }
}
