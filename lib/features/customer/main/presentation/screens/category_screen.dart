import 'package:flutter/material.dart';

/// Dummy category screen for categories tab
class CategoryScreen extends StatelessWidget {
  final dynamic selectedCategory;
  final Function(bool) onSearchActiveChanged;

  const CategoryScreen({
    super.key,
    this.selectedCategory,
    required this.onSearchActiveChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.category, size: 64, color: Theme.of(context).primaryColor),
              const SizedBox(height: 16),
              Text(
                'Categories',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Categories - Tab 2',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (selectedCategory != null) ...[
                const SizedBox(height: 16),
                Text(
                  'Selected: $selectedCategory',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
