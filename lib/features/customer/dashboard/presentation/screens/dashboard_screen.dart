import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/routing/route_names.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../audio/domain/entities/audio_entity.dart';
import '../../../audio/presentation/bloc/audio_bloc.dart';
import '../../../audio/presentation/bloc/audio_event.dart';
import '../../../audio/presentation/bloc/audio_state.dart';
import '../../../categories/domain/entities/category_entity.dart';
import '../../../categories/presentation/bloc/category_bloc.dart';
import '../../../categories/presentation/bloc/category_event.dart';
import '../../../categories/presentation/bloc/category_state.dart';
import '../../../video/domain/entities/video_entity.dart';
import '../../../video/presentation/bloc/short_video/short_video_bloc.dart';
import '../../../video/presentation/bloc/short_video/short_video_event.dart';
import '../../../video/presentation/bloc/short_video/short_video_state.dart';
import '../../../video/presentation/bloc/long_video/long_video_bloc.dart';
import '../../../video/presentation/bloc/long_video/long_video_event.dart';
import '../../../video/presentation/bloc/long_video/long_video_state.dart';
import '../../../tips/domain/entities/tip_entity.dart';
import '../../../tips/presentation/bloc/tip_bloc.dart';
import '../../../tips/presentation/bloc/tip_event.dart';
import '../../../tips/presentation/bloc/tip_state.dart';
import '../../../images/presentation/bloc/image_bloc.dart';
import '../../../images/presentation/bloc/image_event.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../domain/entities/quote_entity.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/quote_bloc.dart';
import '../widgets/featured_quotes_widget.dart';
import '../widgets/audio_card_widget.dart';
import '../widgets/category_card_widget.dart';
import '../widgets/short_video_card_widget.dart';
import '../widgets/long_video_card_widget.dart';
import '../../../images/presentation/widgets/images_section_widget.dart';

class DashboardScreen extends StatelessWidget {
  final VoidCallback onViewAllCategories;

  const DashboardScreen({
    super.key,
    required this.onViewAllCategories,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
          getIt<DashboardBloc>()..add(const LoadDashboard()),
        ),
        BlocProvider(
          create: (_) =>
          getIt<QuoteBloc>()..add(const LoadFeaturedQuotes(limit: 10)),
        ),
        BlocProvider(
          create: (_) =>
          getIt<CategoryBloc>()..add(LoadCategoriesEvent()),
        ),
        BlocProvider(
          create: (_) =>
          getIt<AudioBloc>()..add(const LoadFeaturedAudio(limit: 6)),
        ),
        // Short videos bloc
        BlocProvider(
          create: (_) =>
          getIt<ShortVideoBloc>()..add(const LoadShortVideos(limit: 10)),
        ),
        // Long videos bloc
        BlocProvider(
          create: (_) =>
          getIt<LongVideoBloc>()..add(const LoadLongVideos(limit: 10)),
        ),
        // Tips bloc
        BlocProvider(
          create: (_) =>
          getIt<TipBloc>()..add(const LoadFeaturedTips(limit: 6)),
        ),
        // Images bloc
        BlocProvider(
          create: (_) =>
          getIt<ImageBloc>()..add(const LoadFeaturedImages(limit: 6)),
        ),
      ],
      child: _DashboardView(onViewAllCategories: onViewAllCategories),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// VIEW
// ─────────────────────────────────────────────────────────────────────────────

class _DashboardView extends StatelessWidget {
  final VoidCallback onViewAllCategories;

  const _DashboardView({required this.onViewAllCategories});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        // ── Loading ────────────────────────────────────────────────────
        if (state is DashboardLoading) {
          return Scaffold(
            backgroundColor: context.backgroundColor,
          );
        }

        // ── Error ─────────────────────────────────────────────────────
        if (state is DashboardError) {
          return Scaffold(
            backgroundColor: context.backgroundColor,
            body: _ErrorBody(message: state.message),
          );
        }

        // ── Loaded ────────────────────────────────────────────────────
        UserProfile? profile;
        String greeting = '';

        if (state is DashboardLoaded) {
          profile = state.userProfile;
          greeting = state.greeting;
        }

        return Scaffold(
          backgroundColor: context.backgroundColor,
          body: SafeArea(
            child: Stack(
              children: [
                // Soft gradient wash behind the header area
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 260.h,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          context.primaryColor.withOpacity(0.07),
                          context.primaryColor.withOpacity(0.02),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                // Main scrollable content
                RefreshIndicator(
                  onRefresh: () async {
                    context
                        .read<DashboardBloc>()
                        .add(const RefreshDashboard());
                    context
                        .read<QuoteBloc>()
                        .add(const LoadFeaturedQuotes(limit: 10));
                    context.read<CategoryBloc>().add(LoadCategoriesEvent());
                    context
                        .read<AudioBloc>()
                        .add(const LoadFeaturedAudio(limit: 6));
                    context
                        .read<ShortVideoBloc>()
                        .add(const LoadShortVideos(limit: 10));
                    context
                        .read<LongVideoBloc>()
                        .add(const LoadLongVideos(limit: 10));
                    context
                        .read<TipBloc>()
                        .add(const LoadFeaturedTips(limit: 6));
                    context
                        .read<ImageBloc>()
                        .add(const LoadFeaturedImages(limit: 6));
                  },
                  color: context.primaryColor,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 12.h),

                        // 1 ─ Header
                        _Header(profile: profile, greeting: greeting),

                        SizedBox(height: 28.h),

                        // 2 ─ Featured Quotes
                        _FeaturedSection(),

                        SizedBox(height: 36.h),

                        // 3 ─ Featured Audio
                        const _FeaturedAudioSection(),

                        SizedBox(height: 36.h),

                        // 4 ─ Short Videos (9:16 horizontal scroll)
                        const _ShortVideosSection(),

                        SizedBox(height: 36.h),

                        // 5.5 ─ Tips Section
                        const _TipsSection(),

                        SizedBox(height: 36.h),

                        // 5.6 ─ Images Section
                        const ImagesSection(),

                        SizedBox(height: 36.h),

                        // 5 ─ Long Videos (16:9 vertical list)
                        const _LongVideosSection(),

                        SizedBox(height: 36.h),

                        // 6 ─ Categories
                        _CategoriesSection(
                          onViewAll: onViewAllCategories,
                        ),

                        SizedBox(height: 40.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 1 – HEADER
// ─────────────────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  final UserProfile? profile;
  final String greeting;

  const _Header({this.profile, required this.greeting});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          // ── Avatar ─────────────────────────────────────────────────
          Container(
            padding: EdgeInsets.all(2.5.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  context.primaryColor,
                  context.primaryColor.withOpacity(0.4),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: context.primaryColor.withOpacity(0.2),
                  blurRadius: 14.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 26.r,
              backgroundColor: context.surfaceColor,
              backgroundImage: _avatarImage,
              child: _avatarImage == null
                  ? Icon(
                Icons.person_rounded,
                size: 26.sp,
                color: context.primaryColor,
              )
                  : null,
            ),
          ),

          SizedBox(width: 14.w),

          // ── Greeting ──────────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greeting.isNotEmpty ? greeting : 'Welcome back',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: context.textSecondaryColor,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  profile?.firstName ?? 'User',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: context.textPrimaryColor,
                    height: 1.2,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // ── Notification bell ─────────────────────────────────────
          _NotificationButton(),
        ],
      ),
    );
  }

  ImageProvider? get _avatarImage {
    final url = profile?.profilePictureUrl;
    if (url != null && url.isNotEmpty) return CachedNetworkImageProvider(url);
    return null;
  }
}

// ── Notification button ─────────────────────────────────────────────────────

class _NotificationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.surfaceColor,
        shape: BoxShape.circle,
        border: Border.all(color: context.borderColor, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            // TODO: navigate to notifications
          },
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  Icons.notifications_none_rounded,
                  size: 24.sp,
                  color: context.textPrimaryColor,
                ),
                Positioned(
                  top: -1,
                  right: -1,
                  child: Container(
                    width: 9.w,
                    height: 9.w,
                    decoration: BoxDecoration(
                      color: context.primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: context.surfaceColor,
                        width: 1.8.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 2 – FEATURED QUOTES SECTION
// ─────────────────────────────────────────────────────────────────────────────

class _FeaturedSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuoteBloc, QuoteState>(
      builder: (context, quoteState) {
        List<QuoteEntity> quotes = [];
        if (quoteState is QuoteLoaded) quotes = quoteState.quotes;
        if (quotes.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Daily Inspiration',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: context.textPrimaryColor,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Swipe through today\'s featured quotes',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: context.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            FeaturedQuotesWidget(
              featuredQuotes: quotes,
              theme: Theme.of(context),
              isDarkMode: context.isDarkMode,
            ),
          ],
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 3 – FEATURED AUDIO SECTION
// ─────────────────────────────────────────────────────────────────────────────

class _FeaturedAudioSection extends StatelessWidget {
  const _FeaturedAudioSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        List<AudioEntity> tracks = [];
        if (state is AudioLoaded) {
          tracks = state.featuredTracks;
        }
        if (tracks.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Calming Audio',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: context.textPrimaryColor,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Meditation & wellness sessions',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: context.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _SeeAllButton(onTap: () {
                    // TODO: Navigate to full audio library
                  }),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 280.h,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: tracks.length,
                separatorBuilder: (_, __) => SizedBox(width: 16.w),
                itemBuilder: (context, index) {
                  final track = tracks[index];
                  return AudioCardWidget(
                    track: track,
                    onTap: () {
                      context.pushNamed(
                        RouteNames.mediaPlayer,
                        extra: track,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 4 – SHORT VIDEOS SECTION (DEBUG VERSION)
// ─────────────────────────────────────────────────────────────────────────────

class _ShortVideosSection extends StatelessWidget {
  const _ShortVideosSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShortVideoBloc, ShortVideoState>(
      builder: (context, state) {
        if (state is ShortVideoLoading) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Short Videos',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: context.textPrimaryColor,
                  ),
                ),
                SizedBox(height: 16.h),
                Center(
                  child: CircularProgressIndicator(
                    color: context.primaryColor,
                  ),
                ),
              ],
            ),
          );
        }

        if (state is ShortVideoError) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '❌ Short Videos Error',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    state.message,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13.sp,
                      color: Colors.red.shade700,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        List<VideoEntity> shortVideos = [];
        if (state is ShortVideoLoaded) {
          shortVideos = state.videos;
        }

        if (shortVideos.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                '⚠️ No short videos found\nState: ${state.runtimeType}',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14.sp,
                  color: Colors.orange.shade800,
                ),
              ),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Short Videos',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: context.textPrimaryColor,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Quick mindfulness moments',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: context.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _SeeAllButton(onTap: () {}),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 250.h,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: shortVideos.length,
                separatorBuilder: (_, __) => SizedBox(width: 14.w),
                itemBuilder: (context, index) {
                  final video = shortVideos[index];
                  return ShortVideoCardWidget(
                    video: video,
                    onTap: () {
                      context.pushNamed(
                        RouteNames.shortsPlayer,
                        extra: shortVideos,
                        queryParameters: {'index': index.toString()},
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 5 – LONG VIDEOS SECTION (HORIZONTAL SCROLL)
// ─────────────────────────────────────────────────────────────────────────────

class _LongVideosSection extends StatelessWidget {
  const _LongVideosSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LongVideoBloc, LongVideoState>(
      builder: (context, state) {
        if (state is LongVideoError) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '❌ Long Videos Error',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    state.message,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13.sp,
                      color: Colors.red.shade700,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        List<VideoEntity> longVideos = [];
        if (state is LongVideoLoaded) {
          longVideos = state.videos;
        }

        if (longVideos.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                '⚠️ No long videos found\nState: ${state.runtimeType}',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14.sp,
                  color: Colors.orange.shade800,
                ),
              ),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Featured Videos',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: context.textPrimaryColor,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'In-depth wellness content',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: context.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _SeeAllButton(onTap: () {}),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 280.h,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: longVideos.length,
                separatorBuilder: (_, __) => SizedBox(width: 16.w),
                itemBuilder: (context, index) {
                  final video = longVideos[index];
                  return SizedBox(
                    width: 320.w,
                    child: LongVideoCardWidget(
                      video: video,
                      onTap: () {
                        context.pushNamed(
                          RouteNames.longVideoPlayer,
                          extra: video,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 5.5 – TIPS SECTION (GRID)
// ─────────────────────────────────────────────────────────────────────────────

class _TipsSection extends StatelessWidget {
  const _TipsSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TipBloc, TipState>(
      builder: (context, state) {
        if (state is TipError) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                '❌ Tips Error: ${state.message}',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14.sp,
                  color: Colors.red.shade700,
                ),
              ),
            ),
          );
        }

        List<TipEntity> tips = [];
        if (state is TipLoaded) {
          tips = state.tips;
        }

        if (tips.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                '⚠️ No tips available',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14.sp,
                  color: Colors.orange.shade800,
                ),
              ),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Wellness Tips',
                          style: TextStyle(
                            fontFamily: 'PlayfairDisplay',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: context.textPrimaryColor,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Quick advice for daily wellness',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: context.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _SeeAllButton(
                    onTap: () => context.push('/tips'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 280.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: tips.length > 6 ? 6 : tips.length,
                itemBuilder: (context, index) {
                  final tip = tips[index];
                  return SizedBox(
                    width: 260.w,
                    child: Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: _buildTipCard(context, tip),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTipCard(BuildContext context, TipEntity tip) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: InkWell(
        onTap: () => _showTipDetail(context, tip),
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                _getGradientColorForType(context, tip.tipType),
                _getGradientColorForType(context, tip.tipType).withOpacity(0.7),
              ],
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Type badge
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    tip.tipTypeString,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              // Title
              Text(
                tip.title,
                style: TextStyle(
                  fontFamily: 'PlayfairDisplay',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4.h),
              // Author
              Text(
                tip.author.isNotEmpty ? tip.author : 'Unknown',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.8),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTipDetail(BuildContext context, TipEntity tip) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _TipDetailSheet(tip: tip),
    );
  }

  Color _getGradientColorForType(BuildContext context, TipType tipType) {
    switch (tipType) {
      case TipType.relationshipBooster:
        return const Color(0xFFFF6B6B);
      case TipType.lettingGo:
        return const Color(0xFF4ECDC4);
      case TipType.communication:
        return const Color(0xFFFFE66D);
      case TipType.selfCare:
        return const Color(0xFF95E1D3);
      case TipType.mindfulness:
        return const Color(0xFFA8E6CF);
      case TipType.general:
        return context.primaryColor;
      case TipType.unknown:
        return Colors.grey.shade600;
    }
  }
}

class _TipDetailSheet extends StatelessWidget {
  final TipEntity tip;

  const _TipDetailSheet({required this.tip});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _getGradientColorForType(context, tip.tipType),
            _getGradientColorForType(context, tip.tipType).withOpacity(0.85),
          ],
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(bottom: 20.h),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              tip.tipTypeString,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            tip.title,
            style: TextStyle(
              fontFamily: 'PlayfairDisplay',
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            tip.tipText,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white.withOpacity(0.95),
              height: 1.6,
            ),
          ),
          if (tip.author.isNotEmpty) ...[
            SizedBox(height: 24.h),
            Divider(color: Colors.white.withOpacity(0.3)),
            SizedBox(height: 16.h),
            Row(
              children: [
                if (tip.authorIconUrl.isNotEmpty) ...[
                  CircleAvatar(
                    radius: 20.r,
                    backgroundImage: NetworkImage(tip.authorIconUrl),
                    onBackgroundImageError: (_, __) => null,
                  ),
                  SizedBox(width: 12.w),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tip.author,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Wellness Expert',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Color _getGradientColorForType(BuildContext context, TipType tipType) {
    switch (tipType) {
      case TipType.relationshipBooster:
        return const Color(0xFFFF6B6B);
      case TipType.lettingGo:
        return const Color(0xFF4ECDC4);
      case TipType.communication:
        return const Color(0xFFFFE66D);
      case TipType.selfCare:
        return const Color(0xFF95E1D3);
      case TipType.mindfulness:
        return const Color(0xFFA8E6CF);
      case TipType.general:
        return context.primaryColor;
      case TipType.unknown:
        return Colors.grey.shade600;
    }
  }
}


// ─────────────────────────────────────────────────────────────────────────────
// 6 – CATEGORIES SECTION
// ─────────────────────────────────────────────────────────────────────────────

class _CategoriesSection extends StatelessWidget {
  final VoidCallback onViewAll;

  const _CategoriesSection({required this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, categoryState) {
        List<CategoryEntity> categories = [];
        if (categoryState is CategoryLoaded) {
          categories = categoryState.categories;
        }
        if (categories.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Explore Categories',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: context.textPrimaryColor,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Find quotes that resonate with you',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: context.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _SeeAllButton(onTap: onViewAll),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 210.h,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: categories.length,
                separatorBuilder: (_, __) => SizedBox(width: 14.w),
                itemBuilder: (context, i) {
                  final category = categories[i];
                  return CategoryCardWidget(
                    category: category,
                    onTap: () {
                      // TODO: Navigate to category detail
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

// ── "See All" pill button ───────────────────────────────────────────────────

class _SeeAllButton extends StatelessWidget {
  final VoidCallback onTap;

  const _SeeAllButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.primaryColor.withOpacity(0.08),
      borderRadius: BorderRadius.circular(20.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'See All',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: context.primaryColor,
                ),
              ),
              SizedBox(width: 4.w),
              Icon(
                Icons.arrow_forward_rounded,
                size: 16.sp,
                color: context.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Error body ──────────────────────────────────────────────────────────────

class _ErrorBody extends StatelessWidget {
  final String message;

  const _ErrorBody({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: context.errorColor.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.cloud_off_rounded,
                size: 48.sp,
                color: context.errorColor,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Something went wrong',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: context.textPrimaryColor,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14.sp,
                color: context.textSecondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 28.h),
            FilledButton.icon(
              onPressed: () =>
                  context.read<DashboardBloc>().add(const RefreshDashboard()),
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try Again'),
              style: FilledButton.styleFrom(
                backgroundColor: context.primaryColor,
                foregroundColor: Colors.white,
                padding:
                EdgeInsets.symmetric(horizontal: 28.w, vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
                textStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}