import 'package:expenes_tracker/widget/chart/chart.dart';
import 'package:expenes_tracker/widget/expense-list/expenses_list.dart';
import 'package:expenes_tracker/models/expense.dart';
import 'package:expenes_tracker/widget/new_expenses.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _regesteredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.other,
    ),
    Expense(
      title: 'Transporation',
      amount: 20.55,
      date: DateTime.now(),
      category: Category.travel,
    ),
    Expense(
      title: 'Fast Food',
      amount: 24.55,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Electricity & Water',
      amount: 61.58,
      date: DateTime.now(),
      category: Category.bills,
    )
  ];

  void _openAddExp() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAdd: _addExpense),
    );
  }

  void _addExpense(Expense exp) {
    setState(() {
      _regesteredExpenses.add(exp);
    });
  }

  void _removeExpense(Expense expense) {
    final expIndex = _regesteredExpenses.indexOf(expense);
    setState(() {
      _regesteredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense Deleted"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _regesteredExpenses.insert(expIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    Widget mainContent = const Center(
      child: Text("No Expenses Found. Start "),
    );

    if (_regesteredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _regesteredExpenses,
        onRemove: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExp,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _regesteredExpenses),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: _regesteredExpenses),
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
