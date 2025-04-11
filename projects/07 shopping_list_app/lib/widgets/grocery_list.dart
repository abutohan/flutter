import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/dummy_items.dart';
import 'package:shopping_list_app/models/grocery_item.dart';

class GroceryList extends StatelessWidget {
  const GroceryList({super.key});

  Widget _buildGroceryItem(GroceryItem groceryItem) {
    return ListTile(
      title: Text(groceryItem.name),
      leading: Container(
        width: 24,
        height: 24,
        color: groceryItem.category!.legend,
      ),
      trailing: Text('${groceryItem.quantity}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<GroceryItem> groceryItemList = groceryItems;
    return ListView.builder(
      itemCount: groceryItemList.length,
      itemBuilder: (context, index) {
        final GroceryItem groceryItem = groceryItemList[index];
        return _buildGroceryItem(groceryItem);
      },
    );
  }
}
