import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final dateFormatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({required this.onAddExpense, super.key});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  // String _enteredTitle = "";

  // void _saveTitleInput(String inputValue) {
  //   _enteredTitle = inputValue;
  // }
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  Category _selectedCategory = Category.leisure;
  DateTime? _selectedDate;

  void _onSelectCategory(Category value) {
    setState(() {
      _selectedCategory = value;
    });
  }

  void _showDatePicker() async {
    final DateTime now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year - 1, now.month, now.day),
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _onSubmitExpenseData() {
    final double? enteredAmount = double.tryParse(_amountController.text);
    if (_titleController.text.trim().isEmpty ||
        enteredAmount == null ||
        enteredAmount <= 0 ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: const Text("Invalid input"),
              content: const Text("Please correct your inputs"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text("Okay"),
                ),
              ],
            ),
      );
      return;
    }

    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            // onChanged: _saveTitleInput,
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(label: Text("Title")),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  maxLength: 5,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText: "Php ",
                    label: Text("Amount"),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? "No selected date"
                          : dateFormatter.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: _showDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: [
                  ...Category.values.map(
                    (category) => DropdownMenuItem(
                      value: category,
                      child: Text(category.name.toUpperCase()),
                    ),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) return;
                  _onSelectCategory(value);
                },
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _onSubmitExpenseData,
                child: const Text("Save"),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
