import 'package:expense_tracker_3/widgets/expenses.dart';
import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);
void main() {
  runApp(
    MaterialApp(
      title: 'Expense Tracker App',
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
          elevation: 10,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.onPrimaryContainer),
        ),
        dialogTheme: const DialogTheme().copyWith(
            titleTextStyle: TextStyle(
              color: kColorScheme.primary,
              fontSize: 18,
            ),
            contentTextStyle: TextStyle(
              color: kColorScheme.primary,
              fontSize: 14,
            )),
        textTheme: const TextTheme().copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: kColorScheme.onSecondaryContainer,
            fontSize: 19,
          ),
        ),
      ),
      home: const Expenses(),
    ),
  );
}
