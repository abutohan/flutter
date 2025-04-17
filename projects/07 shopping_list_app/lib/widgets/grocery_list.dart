import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/providers/grocery_provider.dart';
import 'package:http/http.dart' as http;

class GroceryList extends ConsumerWidget {
  const GroceryList({super.key});

  Future<void> _removeItem(GroceryItem item, WidgetRef ref, int index) async {
    // Optimistic deletion
    final previousState = ref.read(groceryListProvider);
    ref.read(groceryListProvider.notifier).removeItem(item);

    try {
      final url = Uri.https(
        "flutter-prep-fec5b-default-rtdb.asia-southeast1.firebasedatabase.app",
        "shopping-list/${item.id}.json",
      );
      final response = await http.delete(url);

      if (response.statusCode >= 400) {
        ref.read(groceryListProvider.notifier).revertDeletion(previousState);
      }
    } catch (e) {
      ref.read(groceryListProvider.notifier).revertDeletion(previousState);
      debugPrint('Failed to delete item: $e');
    }
  }

  Widget _buildGroceryItem(
    BuildContext context,
    GroceryItem item,
    WidgetRef ref,
    int index,
  ) {
    final categoryColor = item.category?.legend ?? Colors.grey;

    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return await showDialog<bool>(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: const Text('Confirm Delete'),
                    content: const Text(
                      'Are you sure you want to delete this item?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
            ) ??
            false;
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => _removeItem(item, ref, index),
      child: ListTile(
        title: Text(item.name),
        leading: CircleAvatar(
          backgroundColor: categoryColor,
          radius: 12,
          child: const SizedBox.shrink(),
        ),
        trailing: Text(
          '${item.quantity}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<GroceryItem> groceryItems = ref.watch(groceryListProvider);

    return ListView.separated(
      itemCount: groceryItems.length,
      physics: const AlwaysScrollableScrollPhysics(),
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = groceryItems[index];
        return _buildGroceryItem(context, item, ref, index);
      },
    );
  }
}
