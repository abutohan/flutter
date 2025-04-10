import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    required this.category,
    required this.onSelectCategory,
    super.key,
  });

  final Category category;
  final VoidCallback onSelectCategory;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final gradientColors = [
      category.color.withOpacity(0.5),
      category.color.withOpacity(0.9),
    ];

    return InkWell(
      onTap: onSelectCategory,
      splashColor: theme.primaryColor,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(26),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.onBackground,
          ),
        ),
      ),
    );
  }
}
