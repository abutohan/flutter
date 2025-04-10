import 'package:flutter/material.dart';
import 'package:meals_app/data/meal_data.dart';
import 'package:meals_app/models/meal.dart';
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

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final Set<Meal> _favoriteMeals = {};
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();

    if (identifier == "filters") {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(currentFilter: _selectedFilters),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
        _showInfoMessage("Removed from favorites");
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _showInfoMessage("Added to favorites");
      });
    }
  }

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  bool _isMealFiltered(Meal meal) {
    for (var filter in _selectedFilters.entries) {
      if (filter.value) {
        switch (filter.key) {
          case Filter.gluttenFree:
            if (!meal.isGlutenFree) return false;
            break;
          case Filter.lactoseFree:
            if (!meal.isLactoseFree) return false;
            break;
          case Filter.vegetarian:
            if (!meal.isVegetarian) return false;
            break;
          case Filter.vegan:
            if (!meal.isVegan) return false;
            break;
        }
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final filteredMeals = dummyMeals.where(_isMealFiltered).toList();
    final pageTitles = ['Categories', 'Your Favorites'];

    final pages = [
      CategoriesScreen(
        filteredMeals: filteredMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
      ),
      MealsScreen(
        meals: _favoriteMeals.toList(),
        onToggleFavorite: _toggleMealFavoriteStatus,
      ),
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
