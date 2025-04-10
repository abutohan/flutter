import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final activeFilters = ref.watch(filtersProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Your Filters")),
        body: ListView(
          children:
              Filter.values.map((filter) {
                final (title, subtitle) = _getFilterTexts(filter);
                return _buildFilterTile(
                  context,
                  title: title,
                  subtitle: subtitle,
                  value: activeFilters[filter]!,
                  onChanged:
                      (value) => {
                        ref
                            .read(filtersProvider.notifier)
                            .setFilter(filter, value),
                      },
                  colorScheme: colorScheme,
                  textTheme: textTheme,
                );
              }).toList(),
        ),
      ),
    );
    // );
  }

  (String, String) _getFilterTexts(Filter filter) {
    return switch (filter) {
      Filter.gluttenFree => ("Gluten-free", "Only include gluten-free meals"),
      Filter.lactoseFree => ("Lactose-free", "Only include lactose-free meals"),
      Filter.vegetarian => ("Vegetarian", "Only include vegetarian meals"),
      Filter.vegan => ("Vegan", "Only include vegan meals"),
    };
  }

  Widget _buildFilterTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required ColorScheme colorScheme,
    required TextTheme textTheme,
  }) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      title: Text(
        title,
        style: textTheme.titleLarge?.copyWith(color: colorScheme.onBackground),
      ),
      subtitle: Text(
        subtitle,
        style: textTheme.titleMedium?.copyWith(color: colorScheme.onBackground),
      ),
      activeColor: colorScheme.tertiary,
      contentPadding: const EdgeInsets.symmetric(horizontal: 34, vertical: 8),
    );
  }
}
