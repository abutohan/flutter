import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class MealDetailsScreen extends StatefulWidget {
  const MealDetailsScreen({
    required this.onToggleFavorite,
    required this.meal,
    super.key,
  });

  final Meal meal;
  final void Function(Meal meal) onToggleFavorite;

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  bool isFavorite = false;

  void _makeMealFavorite(Meal meal) {
    setState(() {
      meal.isFavorite = !meal.isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meal.title),
        actions: [
          IconButton(
            onPressed: () {
              widget.onToggleFavorite(widget.meal);
              _makeMealFavorite(widget.meal);
            },
            icon: Icon(
              Icons.star,
              color: widget.meal.isFavorite ? Colors.blue : Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.meal.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 14),
            Text(
              "Ingredients",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 14),
            for (final ingredient in widget.meal.ingredients)
              Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            const SizedBox(height: 24),
            Text(
              "Steps",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 14),
            for (final step in widget.meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
