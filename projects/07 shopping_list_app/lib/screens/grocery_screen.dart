import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/categories.dart';

class GroceryScreen extends StatefulWidget {
  const GroceryScreen({super.key});

  @override
  State<GroceryScreen> createState() => _GroceryScreenState();
}

class _GroceryScreenState extends State<GroceryScreen> {
  Widget _buildFormTextField({
    required String label,
    String? initialValue,
    required int maxLength,
  }) {
    return TextFormField(
      maxLength: maxLength,
      decoration: InputDecoration(label: Text(label)),
      initialValue: initialValue,
      validator: (value) {
        return "Demoo";
      },
    );
  }

  Widget _buildFormQtyAndCategory() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: _buildFormTextField(
            label: "Quantity",
            initialValue: "1",
            maxLength: 5,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: DropdownButtonFormField(
            items: [
              for (final category in categories.entries)
                DropdownMenuItem(
                  value: category.value,
                  child: Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        color: category.value.legend,
                      ),
                      const SizedBox(width: 6),
                      Text(category.value.name),
                    ],
                  ),
                ),
            ],
            onChanged: (value) {},
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      child: Column(
        children: [
          _buildFormTextField(label: "Name", maxLength: 50),
          _buildFormQtyAndCategory(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add a new item")),
      body: Padding(padding: const EdgeInsets.all(12), child: _buildForm()),
    );
  }
}
