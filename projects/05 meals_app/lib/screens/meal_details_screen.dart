import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({
    required this.onToggleFavorite,
    required this.meal,
    super.key,
  });

  final Meal meal;
  final void Function(Meal meal) onToggleFavorite;

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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
          actions: [
            IconButton(
              onPressed: () => onToggleFavorite(meal),
              icon: Icon(
                Icons.star,
                color:
                    meal.isFavorite
                        ? colorScheme.primary
                        : colorScheme.onPrimary,
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
