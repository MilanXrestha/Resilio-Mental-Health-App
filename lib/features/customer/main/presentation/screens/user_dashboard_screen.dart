import 'package:flutter/material.dart';

/// Dummy dashboard screen for home tab
class UserDashboardScreen extends StatelessWidget {
  final VoidCallback onViewAllCategories;

  const UserDashboardScreen({
    super.key,
    required this.onViewAllCategories,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Text(
                'Dashboard',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Home - Tab 0',
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onViewAllCategories,
                child: const Text('View All Categories'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
