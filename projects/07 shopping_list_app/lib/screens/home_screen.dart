import 'package:flutter/material.dart';
import 'package:shopping_list_app/screens/grocery_screen.dart';
import 'package:shopping_list_app/widgets/grocery_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _addItem() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const GroceryScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Groceries"),
        actions: [IconButton(onPressed: _addItem, icon: const Icon(Icons.add))],
      ),
      body: const GroceryList(),
    );
  }
}
