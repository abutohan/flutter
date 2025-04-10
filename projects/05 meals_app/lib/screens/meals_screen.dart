import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_details_screen.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    required this.onToggleFavorite,
    this.title,
    required this.meals,
    super.key,
  });

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavorite;

  void _onSelectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (ctx) => MealDetailsScreen(
              onToggleFavorite: onToggleFavorite,
              meal: meal,
            ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Uh oh! Nothing here.",
            style: textTheme.headlineLarge?.copyWith(
              color: colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Try selecting a different category.",
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onBackground,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealsList(BuildContext context) {
    return ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) {
        final meal = meals[index];
        return MealItem(
          key: ValueKey(meal.id), // Stable key for better diffing
          meal: meal,
          selectMeal: (meal) => _onSelectMeal(context, meal),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final content =
        meals.isEmpty ? _buildEmptyState(context) : _buildMealsList(context);

    if (title == null) return content;

    return SafeArea(
      child: Scaffold(appBar: AppBar(title: Text(title!)), body: content),
    );
  }
}
