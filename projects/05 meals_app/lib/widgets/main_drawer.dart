import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({required this.onSelectScreen, super.key});

  final void Function(String identifier) onSelectScreen;

  Widget _navigationListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required ColorScheme colorScheme,
    required TextTheme textTheme,
  }) {
    return ListTile(
      leading: Icon(icon, size: 26, color: colorScheme.onBackground),
      title: Text(
        title,
        style: textTheme.titleSmall?.copyWith(
          color: colorScheme.onBackground,
          fontSize: 24,
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final primaryContainer = colorScheme.primaryContainer;

    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryContainer, primaryContainer.withOpacity(0.8)],
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.fastfood, size: 48, color: colorScheme.primary),
                  const SizedBox(width: 18),
                  Text(
                    "Cooking up",
                    style: textTheme.titleLarge?.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            _navigationListTile(
              icon: Icons.restaurant,
              title: "Meals",
              onTap: () => onSelectScreen("meals"),
              colorScheme: colorScheme,
              textTheme: textTheme,
            ),
            _navigationListTile(
              icon: Icons.settings,
              title: "Filters",
              onTap: () => onSelectScreen("filters"),
              colorScheme: colorScheme,
              textTheme: textTheme,
            ),
          ],
        ),
      ),
    );
  }
}
