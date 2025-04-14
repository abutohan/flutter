import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/providers/grocery_provider.dart';
import 'package:shopping_list_app/screens/grocery_screen.dart';
import 'package:shopping_list_app/widgets/grocery_list.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _addItem(BuildContext context, WidgetRef ref) async {
    final grocery = await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const GroceryScreen()));

    if (grocery != null) {
      ref.read(groceryListProvider.notifier).addItem(grocery);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<GroceryItem> groceryList = ref.watch(groceryListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Groceries"),
        actions: [
          IconButton(
            onPressed: () => _addItem(context, ref),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body:
          groceryList.isEmpty
              ? const Center(child: Text("No items added yet"))
              : GroceryList(),
    );
  }
}
