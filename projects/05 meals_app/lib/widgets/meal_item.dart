import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({required this.meal, required this.selectMeal, super.key});

  final Meal meal;
  final void Function(Meal meal) selectMeal;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () => selectMeal(meal),
        child: Stack(
          children: [
            _buildMealImage(),
            _buildMealInfoOverlay(context, textTheme, colorScheme),
          ],
        ),
      ),
    );
  }

  Widget _buildMealImage() {
    return FadeInImage(
      placeholder: MemoryImage(kTransparentImage),
      image: NetworkImage(meal.imageUrl),
      fit: BoxFit.cover,
      height: 200,
      width: double.infinity,
      fadeInDuration: const Duration(milliseconds: 300),
    );
  }

  Widget _buildMealInfoOverlay(
    BuildContext context,
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) {
    return Positioned.fill(
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black54, Colors.transparent],
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTitleText(textTheme),
            const SizedBox(height: 12),
            _buildMealTraitsRow(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleText(TextTheme textTheme) {
    return Text(
      meal.title,
      maxLines: 2,
      textAlign: TextAlign.center,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      style: textTheme.titleLarge?.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildMealTraitsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTrait(Icons.schedule, '${meal.duration} min'),
        _buildSpacer(),
        _buildTrait(Icons.work, meal.complexity.name),
        _buildSpacer(),
        _buildTrait(Icons.attach_money, meal.affordability.name),
      ],
    );
  }

  Widget _buildTrait(IconData icon, String label) {
    return MealItemTrait(icon: icon, label: label);
  }

  Widget _buildSpacer() {
    return const SizedBox(width: 12);
  }
}
