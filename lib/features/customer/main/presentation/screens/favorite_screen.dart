import 'package:flutter/material.dart';

/// Dummy favorites screen for favorites tab
class FavoriteScreen extends StatelessWidget {
  final Function(bool) onSearchActiveChanged;

  const FavoriteScreen({
    super.key,
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
              Icon(Icons.favorite, size: 64, color: Theme.of(context).primaryColor),
              const SizedBox(height: 16),
              Text(
                'Favorites',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Favorites - Tab 3',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
