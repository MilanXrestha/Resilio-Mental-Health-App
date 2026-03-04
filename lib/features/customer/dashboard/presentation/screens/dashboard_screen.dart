import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../domain/entities/quote_entity.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/quote_bloc.dart';
import '../widgets/featured_quotes_widget.dart';

class DashboardScreen extends StatelessWidget {
  final VoidCallback onViewAllCategories;
  final String userId;

  const DashboardScreen({
    super.key,
    required this.onViewAllCategories,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<DashboardBloc>()..add(LoadDashboard(userId))),
        BlocProvider(create: (_) => getIt<QuoteBloc>()..add(const LoadFeaturedQuotes(limit: 10))),
      ],
      child: _DashboardView(onViewAllCategories: onViewAllCategories),
    );
  }
}

class _DashboardView extends StatelessWidget {
  final VoidCallback onViewAllCategories;

  const _DashboardView({required this.onViewAllCategories});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is DashboardLoading && state is! DashboardLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is DashboardError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 48.sp,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(height: 16),
                Text('Error: ${state.message}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<DashboardBloc>().add(
                      RefreshDashboard(context.read<DashboardBloc>().state is DashboardLoaded 
                        ? (context.read<DashboardBloc>().state as DashboardLoaded).userProfile.uid 
                        : ''),
                    );
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        UserProfile? profile;
        String greeting = '';

        if (state is DashboardLoaded) {
          profile = state.userProfile;
          greeting = state.greeting;
        }

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header section with profile and greeting
                  _buildHeader(context, profile, greeting),
                  
                  const SizedBox(height: 24),
                  
                  // Featured quotes carousel
                  BlocBuilder<QuoteBloc, QuoteState>(
                    builder: (context, quoteState) {
                      List<QuoteEntity> featuredQuotes = [];
                      
                      if (quoteState is QuoteLoaded) {
                        featuredQuotes = quoteState.quotes;
                      }
                      
                      return FeaturedQuotesWidget(
                        featuredQuotes: featuredQuotes,
                        theme: Theme.of(context),
                        isDarkMode: Theme.of(context).brightness == Brightness.dark,
                      );
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Dashboard content placeholder
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome to your dashboard',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'This is where your dashboard content will appear',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: onViewAllCategories,
                          child: const Text('View All Categories'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(
    BuildContext context,
    UserProfile? profile,
    String greeting,
  ) {
    return Row(
      children: [
        // Profile picture and greeting
        Expanded(
          child: Row(
            children: [
              // Profile picture
              CircleAvatar(
                radius: 24.r,
                backgroundColor:
                    Theme.of(context).colorScheme.primaryContainer,
                backgroundImage: profile?.profilePictureUrl != null
                    ? CachedNetworkImageProvider(profile!.profilePictureUrl!)
                    : null,
                child: profile?.profilePictureUrl == null
                    ? Icon(
                        FontAwesomeIcons.user,
                        size: 20.sp,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      )
                    : null,
              ),
              
              const SizedBox(width: 12),
              
              // Greeting text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, ${profile?.firstName ?? "User"}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      greeting,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(width: 8),
        
        // Notification button
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              FontAwesomeIcons.bell,
              size: 18.sp,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
            onPressed: () {
              // TODO: Navigate to notifications
            },
            padding: EdgeInsets.all(10.w),
          ),
        ),
      ],
    );
  }
}
