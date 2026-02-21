import 'package:Resilio/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../common/widgets/settings_toggle_widget.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/routing/route_names.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../l10n/app_localizations.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';
import '../widgets/onboarding_content.dart';
import '../widgets/slide_to_start_button.dart';

/// A screen that displays the onboarding flow to introduce app features to new users.
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<OnboardingBloc>()..add(const LoadOnboardingPages()),
      child: const _OnboardingView(),
    );
  }
}

class _OnboardingView extends StatefulWidget {
  const _OnboardingView();

  @override
  State<_OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<_OnboardingView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Locale? _currentLocale;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    if (_currentLocale != null &&
        _currentLocale!.languageCode != locale.languageCode) {
      context.read<OnboardingBloc>().add(const LoadOnboardingPages());
    }
    _currentLocale = locale;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() => _currentPage = index);
  }

  void _nextPage(int totalPages) {
    if (_currentPage == totalPages - 1) {
      context.read<OnboardingBloc>().add(const CompleteOnboarding());
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _skip() {
    context.read<OnboardingBloc>().add(const SkipOnboarding());
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.isDarkMode;

    return BlocListener<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingCompleted) {
          context.goNamed(RouteNames.login);
        }
      },
      child: Scaffold(
        backgroundColor: context.backgroundColor,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: isDarkMode
                ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.background.dark.withValues(alpha: 0.8),
                      AppColors.background.dark,
                    ],
                  )
                : LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFFE8F5E9),
                      context.backgroundColor,
                    ],
                  ),
          ),
          child: SafeArea(
            child: BlocBuilder<OnboardingBloc, OnboardingState>(
              builder: (context, state) {
                final l10n = AppLocalizations.of(context)!;

                if (state is OnboardingLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is OnboardingError) {
                  return Center(child: Text(state.message));
                }

                if (state is OnboardingLoaded) {
                  final isLastPage = _currentPage == state.pages.length - 1;
                  return Column(
                    children: [
                      _buildTopBar(context, isDarkMode, l10n),
                      Expanded(
                        child: PageView.builder(
                          controller: _pageController,
                          physics: const ClampingScrollPhysics(),
                          itemCount: state.pages.length,
                          onPageChanged: _onPageChanged,
                          itemBuilder: (context, index) {
                            return OnboardingContent(
                              entity: state.pages[index],
                            );
                          },
                        ),
                      ),
                      _buildBottomNavigation(context, isDarkMode, l10n, state.pages.length, isLastPage),
                    ],
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, bool isDarkMode, AppLocalizations l10n) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: const SettingsToggleWidget(),
    );
  }

  Widget _buildBottomNavigation(
    BuildContext context,
    bool isDarkMode,
    AppLocalizations l10n,
    int totalPages,
    bool isLastPage,
  ) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SmoothPageIndicator(
            controller: _pageController,
            count: totalPages,
            effect: ExpandingDotsEffect(
              dotHeight: 8.h,
              dotWidth: 8.w,
              expansionFactor: 4,
              spacing: 8.w,
              activeDotColor: context.primaryColor,
              dotColor: context.textSecondaryColor.withValues(alpha: 0.3),
            ),
          ),
          SizedBox(height: 24.h),
          if (isLastPage)
            SlideToStartButton(
              onSlideComplete: () => context.read<OnboardingBloc>().add(const CompleteOnboarding()),
              isDarkMode: isDarkMode,
              text: l10n.startButton,
            )
          else
            _buildNextButton(context, isDarkMode, l10n, totalPages),
          SizedBox(height: 16.h),
          if (!isLastPage)
            GestureDetector(
              onTap: _skip,
              child: Text(
                l10n.skipButton,
                style: AppTextStyles.labelLarge.copyWith(
                  color: context.textSecondaryColor,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNextButton(BuildContext context, bool isDarkMode, AppLocalizations l10n, int totalPages) {
    return GestureDetector(
      onTap: () => _nextPage(totalPages),
      child: Container(
        width: double.infinity,
        height: 60.h,
        decoration: BoxDecoration(
          color: context.primaryColor,
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: context.primaryColor.withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.nextButton,
                style: AppTextStyles.onboardingButton.copyWith(color: Colors.white),
              ),
              SizedBox(width: 8.w),
              Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20.sp),
            ],
          ),
        ),
      ),
    );
  }

}