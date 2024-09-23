import 'package:expenses_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expenses_tracker/widgets/new_expense_form.dart';
import 'package:flutter/material.dart';
import 'package:expenses_tracker/models/expenses.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Lunch',
      amount: 10.99,
      date: DateTime.now(),
      category: Category.travel,
    ),
    Expense(
      title: 'Keyboard',
      amount: 37.99,
      date: DateTime.now(),
      category: Category.work,
    ),
  ];

  void _addNewExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpenseForm(onAddExpense: _addNewExpense),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expenses Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text('The chart'),
          Expanded(
            child: ExpensesList(
                expenses: _registeredExpenses, onRemoveExpense: _removeExpense),
          ),
        ],
      ),
    );
  }
}
