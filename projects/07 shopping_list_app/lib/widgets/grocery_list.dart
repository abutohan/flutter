import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/providers/grocery_provider.dart';

class GroceryList extends ConsumerWidget {
  const GroceryList({super.key});

  void _removeItem(GroceryItem groceryItem, WidgetRef ref) {
    ref.read(groceryListProvider.notifier).removeItem(groceryItem);
  }

  Widget _buildGroceryItem(GroceryItem groceryItem, WidgetRef ref) {
    return Dismissible(
      key: ValueKey(groceryItem.id),
      direction: DismissDirection.endToStart,
      background: Container(
        // 4. Add visual feedback for dismissal
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        _removeItem(groceryItem, ref);
      },
      child: ListTile(
        title: Text(groceryItem.name),
        leading: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            // 5. Use BoxDecoration for better styling
            color: groceryItem.category!.legend,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        trailing: Text('${groceryItem.quantity}'),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<GroceryItem> groceryItems = ref.watch(groceryListProvider);

    return ListView.separated(
      itemCount: groceryItems.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final GroceryItem groceryItem = groceryItems[index];
        return _buildGroceryItem(groceryItem, ref);
      },
    );
  }
}
