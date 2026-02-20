import 'package:flutter/material.dart';
import 'package:resilio/core/localization/l10.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Text(
          l10.login, // Using global l10 helper
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.primary,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
