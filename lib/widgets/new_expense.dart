import 'dart:io';
import 'package:expense_tracker_3/models/expense.dart';
import 'package:expense_tracker_3/widgets/form/amount_input.dart';
import 'package:expense_tracker_3/widgets/form/date_input.dart';
import 'package:expense_tracker_3/widgets/form/dropdown_input.dart';
import 'package:expense_tracker_3/widgets/form/title_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  final Category _selectedCategory = Category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1, now.month, now.day),
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitForm() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = (enteredAmount == null || enteredAmount <= 0);
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }
    widget.onAddExpense(Expense(
      title: _titleController.text,
      amount: enteredAmount,
      date: _selectedDate!,
      category: _selectedCategory,
    ));
    Navigator.pop(context);
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
                title: const Text('Invalid input'),
                content: const Text(
                    'Please make sure a valid title, amount, date and category was enterted.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text('Okay'),
                  )
                ],
              ));
    } else {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Invalid input'),
            content: const Text(
                'Please make sure a valid title, amount, date and category was enterted.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'),
              )
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 50, 20, 20 + keyboardSpace),
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child:
                                TitleInput(titleController: _titleController)),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                            child: AmountInput(
                                amountController: _amountController)),
                      ],
                    ),
                  if (width < 600)
                    TitleInput(titleController: _titleController),
                  if (width >= 600)
                    Row(
                      children: [
                        DropDownInput(selectedCategory: _selectedCategory),
                        const Spacer(),
                        DateInput(
                            selectedDate: _selectedDate,
                            presentDatePicker: _presentDatePicker),
                      ],
                    ),
                  if (width < 600)
                    Row(
                      children: [
                        Expanded(
                            child: AmountInput(
                                amountController: _amountController)),
                        Expanded(
                          child: DateInput(
                              selectedDate: _selectedDate,
                              presentDatePicker: _presentDatePicker),
                        ),
                      ],
                    ),
                  if (width < 600)
                    const SizedBox(
                      height: 10,
                    ),
                  Row(
                    children: [
                      if (width < 600)
                        DropDownInput(selectedCategory: _selectedCategory),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: const Text('Save Expense'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
