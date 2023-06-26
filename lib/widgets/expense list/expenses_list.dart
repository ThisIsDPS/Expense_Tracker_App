import 'package:expense_tracker_3/widgets/expense%20list/expense_item.dart';
import 'package:expense_tracker_3/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.registeredExpenses,
    required this.onRemoveExpense,
  });

  final List<Expense> registeredExpenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: registeredExpenses.length,
        itemBuilder: (ctx, index) {
          return Dismissible(
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(0.8),
              margin: EdgeInsets.symmetric(
                  horizontal: Theme.of(context).cardTheme.margin!.horizontal),
            ),
            onDismissed: (direction) =>
                onRemoveExpense(registeredExpenses[index]),
            direction: DismissDirection.startToEnd,
            key: ValueKey(registeredExpenses[index]),
            child: ExpenseItem(
              expense: registeredExpenses[index],
            ),
          );
        },
      ),
    );
  }
}
