import 'package:flutter/material.dart';
import 'package:meals_app/data/category_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({required this.filteredMeals, super.key});
  final List<Meal> filteredMeals;

  void _selectCategory(
    BuildContext context,
    Category category,
    Map<String, List<Meal>> mealsByCategory,
  ) {
    final availableMeals = mealsByCategory[category.id] ?? [];

    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (ctx) => MealsScreen(title: category.title, meals: availableMeals),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealsByCategory = <String, List<Meal>>{};
    for (final meal in filteredMeals) {
      for (final categoryId in meal.categories) {
        mealsByCategory.putIfAbsent(categoryId, () => []).add(meal);
      }
    }

    return GridView.builder(
      padding: const EdgeInsets.all(22),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      itemCount: availableCategories.length,
      itemBuilder: (context, index) {
        final category = availableCategories[index];
        return CategoryGridItem(
          key: ValueKey(category.id), // Add key for better diffing
          category: category,
          onSelectCategory:
              () => _selectCategory(context, category, mealsByCategory),
        );
      },
    );
  }
}
