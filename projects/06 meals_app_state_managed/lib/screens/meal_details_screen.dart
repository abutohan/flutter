import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/favorites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({required this.meal, super.key});

  final Meal meal;

  Widget _buildSectionTitle(BuildContext context, String text) {
    final theme = Theme.of(context);
    return Text(
      text,
      style: theme.textTheme.titleLarge?.copyWith(
        color: theme.colorScheme.primary,
      ),
    );
  }

  Widget _buildListContent(BuildContext context, List<String> items) {
    final theme = Theme.of(context);
    return Column(
      children:
          items
              .map(
                (item) => Text(
                  item,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onBackground,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
              .toList(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);

    final isFavorite = favoriteMeals.contains(meal);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
          actions: [
            IconButton(
              onPressed: () {
                final favorite = ref
                    .read(favoriteMealsProvider.notifier)
                    .toggleMealFavoriteStatus(meal);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      favorite
                          ? "Added to your favorites."
                          : "Removed from favorites.",
                    ),
                  ),
                );
              },
              icon: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                meal.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder:
                    (ctx, child, progress) =>
                        progress == null
                            ? child
                            : const LinearProgressIndicator(),
              ),
              const SizedBox(height: 14),
              _buildSectionTitle(context, 'Ingredients'),
              const SizedBox(height: 14),
              _buildListContent(context, meal.ingredients),
              const SizedBox(height: 24),
              _buildSectionTitle(context, 'Steps'),
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _buildListContent(context, meal.steps),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
