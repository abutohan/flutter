import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.gluttenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();

    if (identifier == "filters") {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: (ctx) => const FiltersScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);

    final filteredMeals = ref.watch(filteredMealsProvide);

    final pageTitles = ['Categories', 'Your Favorites'];

    final pages = [
      CategoriesScreen(filteredMeals: filteredMeals),
      MealsScreen(meals: favoriteMeals),
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(pageTitles[_selectedPageIndex])),
        body: pages[_selectedPageIndex],
        drawer: MainDrawer(onSelectScreen: _setScreen),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => setState(() => _selectedPageIndex = index),
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.set_meal),
              label: "Categories",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
          ],
        ),
      ),
    );
  }
}
