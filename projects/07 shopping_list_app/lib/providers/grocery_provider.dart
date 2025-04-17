import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list_app/models/grocery_item.dart';

class GroceryNotifier extends StateNotifier<List<GroceryItem>> {
  GroceryNotifier() : super([]);

  void addItem(GroceryItem groceryItem) {
    state = [...state, groceryItem];
  }

  void removeItem(GroceryItem groceryItem) {
    state = state.where((i) => i.id != groceryItem.id).toList();
  }

  void initData(Future<List<GroceryItem>> groceryItems) async {
    final items = await groceryItems;
    state = [...items];
  }

  void revertDeletion(List<GroceryItem> groceryItems) {
    state = groceryItems;
  }
}

final groceryListProvider = StateNotifierProvider((ref) {
  return GroceryNotifier();
});
