import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/models/category.dart';
import 'package:shopping_list_app/models/grocery_item.dart';

class GroceryScreen extends StatefulWidget {
  const GroceryScreen({super.key});

  @override
  State<GroceryScreen> createState() => _GroceryScreenState();
}

class _GroceryScreenState extends State<GroceryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _categoryItems = categories.entries.map(_buildDropdownItem).toList();
  String _enteredTitle = "";
  int _enteredQty = 1;
  Category _selectedCategory = categories[Categories.vegetables]!;

  static DropdownMenuItem<Category> _buildDropdownItem(
    MapEntry<Categories, Category> category,
  ) {
    return DropdownMenuItem(
      value: category.value,
      child: Row(
        children: [
          Container(width: 16, height: 16, color: category.value.legend),
          const SizedBox(width: 6),
          Text(category.value.name),
        ],
      ),
    );
  }

  void _saveItem(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();
      Navigator.pop(
        context,
        GroceryItem(
          id: DateTime.now().toString(),
          name: _enteredTitle,
          quantity: _enteredQty,
          category: _selectedCategory,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add a new item")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _GroceryFormField(
                label: "Name",
                maxLength: 50,
                onSaved: (value) => _enteredTitle = value!,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _GroceryFormField(
                      label: "Quantity",
                      initialValue: "1",
                      maxLength: 5,
                      isNumber: true,
                      onSaved: (value) => _enteredQty = int.parse(value!),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<Category>(
                      value: _selectedCategory,
                      items: _categoryItems,
                      onChanged:
                          (value) => setState(() => _selectedCategory = value!),
                      decoration: const InputDecoration(labelText: "Category"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _FormActions(
                onReset: () => _formKey.currentState?.reset(),
                onSave: () => _saveItem(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GroceryFormField extends StatelessWidget {
  final String label;
  final String? initialValue;
  final int maxLength;
  final bool isNumber;
  final FormFieldSetter<String>? onSaved;

  const _GroceryFormField({
    required this.label,
    this.initialValue,
    required this.maxLength,
    this.isNumber = false,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      initialValue: initialValue,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(labelText: label),
      validator: _validateField,
      onSaved: onSaved,
    );
  }

  String? _validateField(String? value) {
    if (value == null || value.isEmpty) return "This field cannot be empty";

    return isNumber ? _validateNumber(value) : _validateText(value);
  }

  String? _validateText(String value) {
    final trimmed = value.trim();
    return (trimmed.length <= 1 || trimmed.length > 50)
        ? "Must be between 2-50 characters"
        : null;
  }

  String? _validateNumber(String value) {
    final number = int.tryParse(value);
    return (number == null || number <= 0)
        ? "Must be a valid positive number"
        : null;
  }
}

class _FormActions extends StatelessWidget {
  final VoidCallback onReset;
  final VoidCallback onSave;

  const _FormActions({required this.onReset, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(onPressed: onReset, child: const Text("Reset")),
        const SizedBox(width: 16),
        ElevatedButton(onPressed: onSave, child: const Text("Add Item")),
      ],
    );
  }
}

// class GroceryScreen extends StatefulWidget {
//   const GroceryScreen({super.key});

//   @override
//   State<GroceryScreen> createState() => _GroceryScreenState();
// }

// class _GroceryScreenState extends State<GroceryScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String _enteredTitle = "";
//   int _enteredQty = 1;
//   Category _selectedCategory = categories[Categories.vegetables]!;

//   void _saveItem(BuildContext context) {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       Navigator.of(context).pop(
//         GroceryItem(
//           id: DateTime.now().toString(),
//           name: _enteredTitle,
//           quantity: _enteredQty,
//           category: _selectedCategory,
//         ),
//       );
//     }
//   }

//   Widget _buildFormTextField({
//     required String label,
//     String? initialValue,
//     required int maxLength,
//     bool isNumber = false,
//   }) {
//     return TextFormField(
//       maxLength: maxLength,
//       decoration: InputDecoration(label: Text(label)),
//       initialValue: isNumber ? initialValue.toString() : initialValue,
//       keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return "This field cannot be empty";
//         }

//         if (!isNumber) {
//           // String validation
//           if (value.trim().length <= 1 || value.trim().length > 50) {
//             return "Must be between 2 and 50 characters!";
//           }
//         } else {
//           // Number validation
//           final number = int.tryParse(value);
//           if (number == null || number <= 0) {
//             return "Must be a valid positive number!";
//           }
//         }
//         return null;
//       },
//       onSaved: (value) {
//         if (!isNumber) {
//           _enteredTitle = value!;
//         } else {
//           _enteredQty = int.parse(value!);
//         }
//       },
//     );
//   }

//   Widget _buildFormQtyAndCategory() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Expanded(
//           child: _buildFormTextField(
//             label: "Quantity",
//             initialValue: "1",
//             maxLength: 5,
//             isNumber: true,
//           ),
//         ),
//         const SizedBox(width: 8),
//         Expanded(
//           child: DropdownButtonFormField(
//             value: _selectedCategory,
//             items: [
//               for (final category in categories.entries)
//                 DropdownMenuItem(
//                   value: category.value,
//                   child: Row(
//                     children: [
//                       Container(
//                         width: 16,
//                         height: 16,
//                         color: category.value.legend,
//                       ),
//                       const SizedBox(width: 6),
//                       Text(category.value.name),
//                     ],
//                   ),
//                 ),
//             ],
//             onChanged: (value) {
//               setState(() {
//                 _selectedCategory = value!;
//               });
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildButtons(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         TextButton(
//           onPressed: () {
//             _formKey.currentState!.reset();
//           },
//           child: const Text("Reset"),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             _saveItem(context);
//           },
//           child: const Text("Add item"),
//         ),
//       ],
//     );
//   }

//   Widget _buildForm(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           _buildFormTextField(label: "Name", maxLength: 50),
//           _buildFormQtyAndCategory(),
//           const SizedBox(height: 12),
//           _buildButtons(context),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Add a new item")),
//       body: Padding(
//         padding: const EdgeInsets.all(12),
//         child: _buildForm(context),
//       ),
//     );
//   }
// }
