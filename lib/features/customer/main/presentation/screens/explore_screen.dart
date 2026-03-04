import 'package:flutter/material.dart';

/// Dummy explore screen for search tab
class ExploreScreen extends StatelessWidget {
  final Function(bool) onSearchActiveChanged;

  const ExploreScreen({
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
              Icon(Icons.explore, size: 64, color: Theme.of(context).primaryColor),
              const SizedBox(height: 16),
              Text(
                'Explore',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Search - Tab 1',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
