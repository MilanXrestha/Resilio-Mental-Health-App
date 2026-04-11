import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:Resilio/core/theme/app_colors.dart';

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
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20.sp,
              color: context.textPrimaryColor,
            ),
            onPressed: () => context.pop(),
          ),
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return _ProfileShimmer();
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
                            subscription: subState.subscription,
                          );
                        }

                        return _buildSimpleHeader(context, profile, isPremium: false);
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

  ImageProvider _resolveImage(String photoUrl) {
    if (photoUrl.startsWith('/')) return FileImage(File(photoUrl));
    return NetworkImage(photoUrl);
  }

  Widget _buildSimpleHeader(BuildContext context, dynamic profile,
      {required bool isPremium}) {
    return Column(
      children: [
        // Avatar with optional crown above the head
        SizedBox(
          width: 110.w,
          height: 100.h,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              // Gold glow ring for premium
              if (isPremium)
                Container(
                  width: 104.w,
                  height: 104.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFFD4AF37), Color(0xFF8B6914)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFD4AF37).withValues(alpha: 0.45),
                        blurRadius: 18,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(3),
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    backgroundImage: profile.photoUrl.isNotEmpty
                        ? _resolveImage(profile.photoUrl)
                        : null,
                    child: profile.photoUrl.isEmpty
                        ? Icon(Icons.person_rounded,
                            size: 50.sp,
                            color: const Color(0xFFD4AF37))
                        : null,
                  ),
                )
              else
                CircleAvatar(
                  radius: 50.r,
                  backgroundColor:
                      Theme.of(context).primaryColor.withValues(alpha: 0.1),
                  backgroundImage: profile.photoUrl.isNotEmpty
                      ? _resolveImage(profile.photoUrl)
                      : null,
                  child: profile.photoUrl.isEmpty
                      ? Icon(Icons.person_rounded,
                          size: 50.sp,
                          color: Theme.of(context).primaryColor)
                      : null,
                ),

            ],
          ),
        ),

        SizedBox(height: 14.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              profile.displayName,
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
            if (isPremium) ...[
              SizedBox(width: 6.w),
              const Icon(Icons.verified_rounded,
                  size: 18, color: Color(0xFFD4AF37)),
            ],
          ],
        ),
        Text(
          profile.email,
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
      ],
    );
  }
}

class _ProfileShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final base = isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final highlight = isDark ? Colors.grey[700]! : Colors.grey[100]!;

    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          children: [
            // Avatar placeholder
            Center(
              child: CircleAvatar(
                radius: 50.r,
                backgroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 16.h),
            // Name placeholder
            Center(
              child: Container(
                width: 160.w,
                height: 22.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Center(
              child: Container(
                width: 120.w,
                height: 14.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
            ),
            SizedBox(height: 32.h),
            // Menu item placeholders
            ...List.generate(5, (i) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Container(
                height: 64.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
