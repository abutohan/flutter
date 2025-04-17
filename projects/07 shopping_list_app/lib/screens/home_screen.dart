import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/providers/grocery_provider.dart';
import 'package:shopping_list_app/screens/grocery_screen.dart';
import 'package:shopping_list_app/widgets/grocery_list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends ConsumerState<HomeScreen> {
  bool _isLoading = true;

  Future<void> _handleRefresh() async {
    try {
      ref.read(groceryListProvider.notifier).initData(_loadItems());
    } catch (e) {
      debugPrint('Refresh failed: $e');
      // Optionally show error to user
    }
  }

  Future<List<GroceryItem>> _loadItems() async {
    final List<GroceryItem> groceryItems = [];
    try {
      final url = Uri.https(
        "flutter-prep-fec5b-default-rtdb.asia-southeast1.firebasedatabase.app",
        "shopping-list.json",
      );
      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw Exception('Failed to load items: ${response.statusCode}');
      }

      final decodedData =
          json.decode(response.body) as Map<String, dynamic>? ?? {};
      final categoryMap = {
        for (final entry in categories.entries) entry.value.name: entry.value,
      };

      for (final entry in decodedData.entries) {
        final value = entry.value;
        if (value is! Map<String, dynamic>) continue;

        final categoryName = value["category"] as String?;
        final category =
            categoryName != null ? categoryMap[categoryName] : null;

        // if (category != null)

        groceryItems.add(
          GroceryItem(
            id: entry.key,
            name: value["name"] as String,
            quantity: value["quantity"] as int,
            category: category,
          ),
        );
      }
    } catch (e) {
      debugPrint('Error loading items: $e');
      rethrow;
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
    return groceryItems;
  }

  Future<void> _addItem(BuildContext context) async {
    final grocery = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(builder: (_) => const GroceryScreen()),
    );

    if (grocery != null && mounted) {
      ref.read(groceryListProvider.notifier).addItem(grocery);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(groceryListProvider.notifier).initData(_loadItems());
    });
  }

  @override
  Widget build(BuildContext context) {
    final groceryList = ref.watch(groceryListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Groceries"),
        actions: [
          IconButton(
            onPressed: () => _addItem(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        displacement: 10,
        child:
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : groceryList.isEmpty
                ? _buildEmptyList()
                : GroceryList(),
      ),
    );
  }

  Widget _buildEmptyList() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: const Center(child: Text("No items added yet")),
        ),
      ],
    );
  }
}
