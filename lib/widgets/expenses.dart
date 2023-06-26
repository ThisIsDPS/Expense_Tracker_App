import 'package:expense_tracker_3/main.dart';
import 'package:expense_tracker_3/widgets/chart/chart.dart';
import 'package:expense_tracker_3/widgets/expense%20list/expenses_list.dart';
import 'package:expense_tracker_3/models/expense.dart';
import 'package:expense_tracker_3/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Goa',
      amount: 99.99,
      date: DateTime.now(),
      category: Category.travel,
    ),
    Expense(
      title: 'Dosa',
      amount: 2.99,
      date: DateTime.now(),
      category: Category.food,
    ),
  ];

  void _openExpenseFillForm() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return NewExpense(
            onAddExpense: _addExpenses,
          );
        });
  }

  void _addExpenses(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpenses(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = Center(
      child: Text(
        'No expenses found. Start adding some!',
        style: TextStyle(color: kColorScheme.primary, fontSize: 15),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _openExpenseFillForm,
            icon: const Icon(Icons.add),
          ),
        ],
        title: const Text('Expense Tracker App'),
        centerTitle: false,
      ),
      body: SizedBox(
        width: double.infinity,
        child: width < 600
            ? Column(
                children: [
                  Chart(expenses: _registeredExpenses),
                  _registeredExpenses.isEmpty
                      ? Expanded(child: mainContent)
                      : ExpensesList(
                          registeredExpenses: _registeredExpenses,
                          onRemoveExpense: _removeExpenses,
                        ),
                ],
              )
            : Row(
                children: [
                  Expanded(child: Chart(expenses: _registeredExpenses)),
                  _registeredExpenses.isEmpty
                      ? Expanded(child: mainContent)
                      : ExpensesList(
                          registeredExpenses: _registeredExpenses,
                          onRemoveExpense: _removeExpenses,
                        ),
                ],
              ),
      ),
    );
  }
}
