import 'package:expense_tracker/new_expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesController extends StatefulWidget {
  const ExpensesController({super.key});

  @override
  State<ExpensesController> createState() => _ExpensesControllerState();
}

class _ExpensesControllerState extends State<ExpensesController> {
  final List<Expense> _registeredExpensed = [];
  // = [
  //   Expense(
  //     title: "Flutter Course",
  //     amount: 19.99,
  //     date: DateTime.now(),
  //     category: Category.work,
  //   ),
  //   (Expense(
  //     title: "Cinema",
  //     amount: 15.69,
  //     date: DateTime.now(),
  //     category: Category.leisure,
  //   )),
  // ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpensed.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Expense Tracker"),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text("The chart"),
          Expanded(child: ExpensesList(expenses: _registeredExpensed)),
        ],
      ),
    );
  }
}
