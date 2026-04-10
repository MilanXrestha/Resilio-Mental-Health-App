import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

import 'package:Resilio/core/di/injection.dart';
import 'package:Resilio/core/routing/route_names.dart';
import 'package:Resilio/features/customer/auth/presentation/bloc/auth_bloc.dart';
import 'package:Resilio/features/customer/auth/presentation/bloc/auth_event.dart';
import 'package:Resilio/features/customer/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:Resilio/features/customer/subscription/presentation/bloc/subscription_state.dart';
import 'package:Resilio/features/customer/profile/presentation/bloc/profile_bloc.dart';
import 'package:Resilio/features/customer/profile/presentation/widgets/premium_profile_card.dart';
import 'package:Resilio/features/customer/profile/presentation/widgets/profile_menu_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _appVersion = '1.0.0';
  String _cacheSize = '0.0 MB';

  @override
  void initState() {
    super.initState();
    _loadAppInfo();
    _calculateCacheSize();
  }

  Future<void> _loadAppInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() {
        _appVersion = packageInfo.version;
      });
    }
  }

  Future<void> _calculateCacheSize() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final cacheDir = await getApplicationCacheDirectory();
      int totalSize = 0;

      for (var dir in [tempDir, cacheDir]) {
        if (await dir.exists()) {
          await for (var entity in dir.list(recursive: true)) {
            if (entity is File) {
              totalSize += await entity.length();
            }
          }
        }
      }
      if (mounted) {
        setState(() {
          _cacheSize = '${(totalSize / (1024 * 1024)).toStringAsFixed(1)} MB';
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _cacheSize = 'Error';
        });
      }
    }
  }

  Future<void> _clearCache() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cache'),
        content: Text('Current cache size: $_cacheSize\nAre you sure you want to clear it?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        final tempDir = await getTemporaryDirectory();
        final cacheDir = await getApplicationCacheDirectory();
        for (var dir in [tempDir, cacheDir]) {
          if (await dir.exists()) {
            await dir.delete(recursive: true);
            await dir.create(recursive: true);
          }
        }
        await _calculateCacheSize();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cache cleared successfully')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error clearing cache: $e')),
          );
        }
      }
    }
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<AuthBloc>().add(LogoutRequested());
              Navigator.pop(context); // Close dialog
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text('My Profile'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileError) {
              return Center(child: Text(state.message));
            } else if (state is ProfileLoaded) {
              final profile = state.profile;
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  children: [
                    // Premium Card or Simple Info
                    BlocBuilder<SubscriptionBloc, SubscriptionState>(
                      builder: (context, subState) {
                        final isPremium = subState is SubscriptionLoaded && 
                                        subState.subscription.isActive;
                        final planName = subState is SubscriptionLoaded && isPremium
                                        ? subState.subscription.planId
                                        : 'Free';

                        if (isPremium) {
                          return PremiumProfileCard(
                            profile: profile,
                            planName: planName,
                          );
                        }

                        return _buildSimpleHeader(context, profile);
                      },
                    ),

                    SizedBox(height: 32.h),

                    // Menu Options
                    ProfileMenuItem(
                      icon: Icons.person_outline_rounded,
                      title: 'Edit Profile',
                      description: 'Change your name, email, and photo',
                      onTap: () => context.pushNamed(RouteNames.editProfile, extra: profile),
                    ),
                    ProfileMenuItem(
                      icon: Icons.subscriptions_outlined,
                      title: 'Subscription',
                      description: 'Manage your premium plan',
                      onTap: () => context.pushNamed(RouteNames.subscription),
                    ),
                    ProfileMenuItem(
                      icon: Icons.history_rounded,
                      title: 'Transactions',
                      description: 'View your billing history',
                      onTap: () => context.pushNamed(RouteNames.transactionHistory),
                    ),
                    ProfileMenuItem(
                      icon: Icons.cleaning_services_outlined,
                      title: 'Clear Cache',
                      description: 'Free up space: $_cacheSize',
                      onTap: _clearCache,
                    ),
                    ProfileMenuItem(
                      icon: Icons.info_outline_rounded,
                      title: 'About',
                      description: 'Resilio v$_appVersion',
                      onTap: () {
                        showAboutDialog(
                          context: context,
                          applicationName: 'Resilio',
                          applicationVersion: _appVersion,
                          applicationIcon: const FlutterLogo(), // Replace with app icon if available
                          applicationLegalese: '© 2026 Resilio Team',
                        );
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.logout_rounded,
                      title: 'Logout',
                      description: 'Sign out of your account',
                      isDestructive: true,
                      onTap: _handleLogout,
                    ),
                    
                    SizedBox(height: 40.h),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      );
  }

  Widget _buildSimpleHeader(BuildContext context, dynamic profile) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50.r,
          backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
          backgroundImage: profile.photoUrl.isNotEmpty 
                           ? NetworkImage(profile.photoUrl) 
                           : null,
          child: profile.photoUrl.isEmpty
                 ? Icon(Icons.person_rounded, size: 50.sp, color: Theme.of(context).primaryColor)
                 : null,
        ),
        SizedBox(height: 16.h),
        Text(
          profile.displayName,
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
        ),
        Text(
          profile.email,
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
      ],
    );
  }
}
