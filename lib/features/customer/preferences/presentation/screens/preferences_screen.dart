import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flip_card/flip_card.dart';
import 'package:go_router/go_router.dart';

import 'package:Resilio/core/di/injection.dart';
import 'package:Resilio/core/routing/route_names.dart';
import 'package:Resilio/core/theme/app_colors.dart';
import 'package:Resilio/core/theme/app_text_styles.dart';
import '../../domain/entities/preference_entity.dart';
import '../bloc/preferences_bloc.dart';
import '../bloc/preferences_event.dart';
import '../bloc/preferences_state.dart';

class PreferencesScreen extends StatelessWidget {
  final bool fromProfile;

  const PreferencesScreen({
    super.key,
    this.fromProfile = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = getIt<PreferencesBloc>();
        // Add the event in post-frame callback to ensure widget is mounted
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            bloc.add(const LoadUserPreferencesEvent());
          }
        });
        return bloc;
      },
      child: PreferencesView(fromProfile: fromProfile),
    );
  }
}

class PreferencesView extends StatefulWidget {
  final bool fromProfile;

  const PreferencesView({
    super.key,
    required this.fromProfile,
  });

  @override
  State<PreferencesView> createState() => _PreferencesViewState();
}

class _PreferencesViewState extends State<PreferencesView> {
  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey<FlipCardState>> _flipCardKeys = {};
  PreferencesLoaded? _cachedLoadedState;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  GlobalKey<FlipCardState> _getFlipCardKey(int index) {
    return _flipCardKeys.putIfAbsent(index, () => GlobalKey<FlipCardState>());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final theme = Theme.of(context);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: theme.scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      ),
    );

    return BlocConsumer<PreferencesBloc, PreferencesState>(
      listener: (context, state) {
        if (state is PreferencesError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
              ),
              backgroundColor: context.errorColor,
              duration: const Duration(seconds: 3),
            ),
          );
        } else if (state is PreferencesLoaded) {
          // If already completed and not from profile, go straight to home
          if (!widget.fromProfile && state.hasCompletedPreferences) {
            context.goNamed(RouteNames.home);
          }
        } else if (state is PreferencesSaved) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Preferences saved successfully!',
                style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
              ),
              backgroundColor: context.successColor,
              duration: const Duration(seconds: 2),
            ),
          );

          Future.delayed(const Duration(milliseconds: 1000), () {
            if (mounted) {
              if (widget.fromProfile) {
                context.pop();
              } else {
                context.goNamed(RouteNames.home);
              }
            }
          });
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              appBar: widget.fromProfile
                  ? AppBar(
                      leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          size: 20.sp,
                          color: context.textPrimaryColor,
                        ),
                        onPressed: () => context.pop(),
                      ),
                      title: Text(
                        'Content Preferences',
                        style: AppTextStyles.headlineSmall.copyWith(
                          color: context.textPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    )
                  : null,
              body: _buildBody(context, state, isDark, theme),
            ),
            if (state is PreferencesLoading && _cachedLoadedState != null)
              Container(
                color: Colors.black54,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 4.w,
                    valueColor: AlwaysStoppedAnimation<Color>(context.primaryColor),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    PreferencesState state,
    bool isDark,
    ThemeData theme,
  ) {
    // Cache loaded state for when we show save overlay
    if (state is PreferencesLoaded) {
      _cachedLoadedState = state;
    }

    // Initial load - show spinner
    if ((state is PreferencesInitial || state is PreferencesLoading) && _cachedLoadedState == null) {
      return Center(
        child: CircularProgressIndicator(
          strokeWidth: 4.w,
          valueColor: AlwaysStoppedAnimation<Color>(context.primaryColor),
        ),
      );
    }

    // Save in progress - keep showing content (overlay handles loading)
    if (state is PreferencesLoading && _cachedLoadedState != null) {
      return _buildPreferencesContent(context, _cachedLoadedState!, isDark, theme);
    }

    if (state is PreferencesError && state is! PreferencesLoaded) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64.sp, color: context.errorColor),
            SizedBox(height: 16.h),
            Text(
              state.message,
              style: AppTextStyles.bodyMedium.copyWith(color: context.errorColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () {
                context.read<PreferencesBloc>().add(const LoadUserPreferencesEvent());
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state is PreferencesLoaded) {
      return _buildPreferencesContent(context, state, isDark, theme);
    }

    return const SizedBox.shrink();
  }

  Widget _buildPreferencesContent(
    BuildContext context,
    PreferencesLoaded state,
    bool isDark,
    ThemeData theme,
  ) {
    final selectedCount = state.selectedPreferenceIds.length;

    return Container(
      decoration: BoxDecoration(
        gradient: isDark
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  context.surfaceColor.withValues(alpha: 0.3),
                  context.backgroundColor,
                ],
              )
            : null,
        color: isDark ? null : context.backgroundColor,
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                thickness: 6.w,
                radius: Radius.circular(3.r),
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    // Header - matching reference style
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 24.h, 0, 0),
                        child: FadeInDown(
                          duration: const Duration(milliseconds: 500),
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(24.w),
                                decoration: BoxDecoration(
                                  gradient: isDark
                                      ? LinearGradient(
                                          colors: [
                                            context.primaryColor.withOpacity(0.2),
                                            context.primaryColor.withOpacity(0.1),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        )
                                      : LinearGradient(
                                          colors: [
                                            Colors.white,
                                            Colors.grey.shade100,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                  borderRadius: BorderRadius.circular(16.r),
                                  border: Border.all(
                                    color: isDark ? Colors.transparent : Colors.grey.shade300,
                                    width: 1.w,
                                  ),
                                  boxShadow: isDark
                                      ? []
                                      : [
                                          BoxShadow(
                                            color: context.textPrimaryColor.withOpacity(0.1),
                                            blurRadius: 8.r,
                                            offset: Offset(0, 2.h),
                                          ),
                                        ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.fromProfile
                                          ? 'Update Your Interests'
                                          : 'Craft Your Journey',
                                      style: AppTextStyles.headlineMedium.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: context.textPrimaryColor,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      widget.fromProfile
                                          ? 'Modify your preferences to tailor your experience.'
                                          : 'Choose topics that spark inspiration.',
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        color: context.textSecondaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (selectedCount > 0)
                                Positioned(
                                  top: 12.h,
                                  right: 12.w,
                                  child: CircleAvatar(
                                    radius: 12.r,
                                    backgroundColor: context.primaryColor,
                                    child: Text(
                                      '$selectedCount',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Preferences Grid with Flip Cards
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 100.h),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 12.h,
                          childAspectRatio: 1.6,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final preference = state.preferences[index];
                            final isSelected =
                                state.selectedPreferenceIds.contains(preference.id);
                            final flipKey = _getFlipCardKey(index);

                            return FadeInUp(
                              duration: Duration(milliseconds: 300 + (index * 80)),
                              child: FlipCard(
                                key: flipKey,
                                flipOnTouch: true,
                                direction: FlipDirection.HORIZONTAL,
                                front: _buildCardFront(
                                  context,
                                  preference,
                                  isSelected,
                                  isDark,
                                  theme,
                                  index,
                                ),
                                back: _buildCardBack(
                                  context,
                                  preference,
                                  isSelected,
                                  isDark,
                                  theme,
                                  index,
                                ),
                              ),
                            );
                          },
                          childCount: state.preferences.length,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Save Button - matching reference style
            _buildSaveButton(context, state, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildCardFront(
    BuildContext context,
    PreferenceEntity preference,
    bool isSelected,
    bool isDark,
    ThemeData theme,
    int index,
  ) {
    return GestureDetector(
      onTap: () {
        context.read<PreferencesBloc>().add(TogglePreferenceEvent(preference.id));
        if (!isSelected) {
          _getFlipCardKey(index).currentState?.toggleCard();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? null
              : LinearGradient(
                  colors: [Colors.white, Colors.grey.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          color: isDark
              ? (isSelected
                  ? context.primaryColor.withValues(alpha: 0.15)
                  : context.surfaceColor.withValues(alpha: 0.5))
              : null,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? context.primaryColor
                : (isDark ? theme.dividerColor.withValues(alpha: 0.3) : Colors.grey.shade300),
            width: 1.w,
          ),
          boxShadow: isDark
              ? (isSelected
                  ? [
                      BoxShadow(
                        color: context.primaryColor.withValues(alpha: 0.3),
                        blurRadius: 12.r,
                        offset: Offset(0, 4.h),
                      ),
                    ]
                  : [])
              : [
                  BoxShadow(
                    color: isSelected
                        ? context.primaryColor.withValues(alpha: 0.2)
                        : Colors.grey.shade200,
                    blurRadius: 8.r,
                    offset: Offset(0, 2.h),
                  ),
                ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIcon(context, preference, isSelected),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                preference.preferenceName,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? context.primaryColor
                      : context.textPrimaryColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardBack(
    BuildContext context,
    PreferenceEntity preference,
    bool isSelected,
    bool isDark,
    ThemeData theme,
    int index,
  ) {
    return GestureDetector(
      onTap: () {
        context.read<PreferencesBloc>().add(TogglePreferenceEvent(preference.id));
        if (isSelected) {
          _getFlipCardKey(index).currentState?.toggleCard();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? null
              : LinearGradient(
                  colors: [Colors.white, Colors.grey.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          color: isDark
              ? (isSelected
                  ? context.primaryColor.withValues(alpha: 0.2)
                  : context.surfaceColor.withValues(alpha: 0.95))
              : null,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? context.primaryColor
                : (isDark ? theme.dividerColor.withValues(alpha: 0.3) : Colors.grey.shade300),
            width: 1.w,
          ),
          boxShadow: isDark
              ? (isSelected
                  ? [
                      BoxShadow(
                        color: context.primaryColor.withValues(alpha: 0.3),
                        blurRadius: 12.r,
                        offset: Offset(0, 4.h),
                      ),
                    ]
                  : [])
              : [
                  BoxShadow(
                    color: isSelected
                        ? context.primaryColor.withValues(alpha: 0.2)
                        : Colors.grey.shade200,
                    blurRadius: 8.r,
                    offset: Offset(0, 2.h),
                  ),
                ],
        ),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIcon(context, preference, isSelected),
              SizedBox(height: 8.h),
              Expanded(
                child: Text(
                  preference.preferenceDescription,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: isSelected
                        ? context.primaryColor
                        : context.textSecondaryColor,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context, PreferenceEntity preference, bool isSelected) {
    final color = isSelected ? context.primaryColor : context.textSecondaryColor;

    if (preference.isNetworkIcon) {
      if (preference.isSvg) {
        return SvgPicture.network(
          preference.preferenceIcon,
          width: 28.sp,
          height: 28.sp,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          placeholderBuilder: (context) => SizedBox(
            width: 28.sp,
            height: 28.sp,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
          fit: BoxFit.contain,
        );
      } else {
        return CachedNetworkImage(
          imageUrl: preference.preferenceIcon,
          width: 28.sp,
          height: 28.sp,
          placeholder: (context, url) => SizedBox(
            width: 28.sp,
            height: 28.sp,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
          errorWidget: (context, url, error) => Icon(
            Icons.broken_image,
            size: 28.sp,
            color: color,
          ),
          color: color,
        );
      }
    } else {
      return Icon(
        Icons.interests_outlined,
        size: 28.sp,
        color: color,
      );
    }
  }

  Widget _buildSaveButton(BuildContext context, PreferencesLoaded state, bool isDark) {
    final isLoading = context.watch<PreferencesBloc>().state is PreferencesLoading;
    final hasSelection = state.selectedPreferenceIds.isNotEmpty;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: context.surfaceColor,
      ),
      child: SafeArea(
        top: false,
        child: ZoomIn(
          duration: const Duration(milliseconds: 500),
          child: ElevatedButton(
            onPressed: isLoading || !hasSelection
                ? null
                : () {
                    context.read<PreferencesBloc>().add(const SavePreferencesEvent());
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: context.primaryColor,
              foregroundColor: Colors.white,
              disabledBackgroundColor: isDark ? Colors.white24 : Colors.grey.shade300,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              minimumSize: Size(double.infinity, 50.h),
              elevation: isDark ? 0 : 2,
            ),
            child: isLoading
                ? SizedBox(
                    width: 24.sp,
                    height: 24.sp,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    'Save Preferences',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
