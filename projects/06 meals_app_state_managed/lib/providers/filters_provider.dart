import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';

enum Filter { gluttenFree, lactoseFree, vegetarian, vegan }

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
    : super({
        Filter.gluttenFree: false,
        Filter.lactoseFree: false,
        Filter.vegetarian: false,
        Filter.vegan: false,
      });

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }

  void setFilters(Map<Filter, bool> choosenFilters) {
    state = choosenFilters;
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>((ref) {
      return FiltersNotifier();
    });

final filteredMealsProvide = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  return meals.where((meal) {
    final selectedFilters = ref.watch(filtersProvider);
    for (var filter in selectedFilters.entries) {
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
  }).toList();
});
