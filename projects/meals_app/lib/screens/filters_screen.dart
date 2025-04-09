import 'package:flutter/material.dart';

enum Filter { gluttenFree, lactoseFree, vegetarian, vegan }

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({required this.currentFilter, super.key});

  final Map<Filter, bool> currentFilter;

  @override
  State<FiltersScreen> createState() {
    return _FilterScreen();
  }
}

class _FilterScreen extends State<FiltersScreen> {
  bool _gluttenFreeFilterSet = false;
  bool _lactoseFreeFilterSet = false;
  bool _vegetarianFilterSet = false;
  bool _veganFilterSet = false;

  @override
  void initState() {
    super.initState();
    _gluttenFreeFilterSet = widget.currentFilter[Filter.gluttenFree]!;
    _lactoseFreeFilterSet = widget.currentFilter[Filter.lactoseFree]!;
    _vegetarianFilterSet = widget.currentFilter[Filter.vegetarian]!;
    _veganFilterSet = widget.currentFilter[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Filters")),
      // drawer: MainDrawer(
      //   onSelectScreen: (identifier) {
      //     Navigator.of(context).pop();
      //     if (identifier == "meals") {
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(builder: (ctx) => const TabsScreen()),
      //       );
      //     }
      //   },
      // ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if (didPop) return;
          Navigator.of(context).pop({
            Filter.gluttenFree: _gluttenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegetarian: _vegetarianFilterSet,
            Filter.vegan: _veganFilterSet,
          });
        },
        child: Column(
          children: [
            _addFilter(
              "Glutten-free",
              "Only include glutten-free meals",
              _gluttenFreeFilterSet,
              (onChange) {
                setState(() {
                  _gluttenFreeFilterSet = onChange;
                });
              },
            ),
            _addFilter(
              "Lactose-free",
              "Only include lactose-free meals",
              _lactoseFreeFilterSet,
              (onChange) {
                setState(() {
                  _lactoseFreeFilterSet = onChange;
                });
              },
            ),
            _addFilter(
              "Vegetarian",
              "Only include vegetarian meals",
              _vegetarianFilterSet,
              (onChange) {
                setState(() {
                  _vegetarianFilterSet = onChange;
                });
              },
            ),
            _addFilter("Vegan", "Only include vegan meals", _veganFilterSet, (
              onChange,
            ) {
              setState(() {
                _veganFilterSet = onChange;
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget _addFilter(
    String filterTitle,
    String filterSubtitle,
    bool filterState,
    Function(bool) onChanged,
  ) {
    return SwitchListTile(
      value: filterState,
      onChanged: onChanged,
      title: Text(
        filterTitle,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      subtitle: Text(
        filterSubtitle,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }
}
