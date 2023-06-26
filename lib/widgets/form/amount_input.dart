import 'package:expense_tracker_3/main.dart';
import 'package:flutter/material.dart';

class AmountInput extends StatelessWidget {
  const AmountInput({super.key, required this.amountController});

  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        color: kColorScheme.onBackground,
      ),
      controller: amountController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        prefixText: '\$ ',
        labelText: 'Amount',
      ),
    );
  }
}
