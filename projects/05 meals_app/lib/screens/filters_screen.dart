import 'package:flutter/material.dart';

enum Filter { gluttenFree, lactoseFree, vegetarian, vegan }

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({required this.currentFilter, super.key});

  final Map<Filter, bool> currentFilter;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  late Map<Filter, bool> _selectedFilters;

  @override
  void initState() {
    super.initState();
    _selectedFilters = Map.from(widget.currentFilter);
  }

  void _handleFilterChanged(Filter filter, bool value) {
    setState(() {
      _selectedFilters[filter] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) Navigator.of(context).pop(_selectedFilters);
      },
      child: SafeArea(
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
                    value: _selectedFilters[filter]!,
                    onChanged: (value) => _handleFilterChanged(filter, value),
                    colorScheme: colorScheme,
                    textTheme: textTheme,
                  );
                }).toList(),
          ),
        ),
      ),
    );
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
