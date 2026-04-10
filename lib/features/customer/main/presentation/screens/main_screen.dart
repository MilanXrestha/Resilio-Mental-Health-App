import 'dart:developer';
import 'dart:math' as math;

import 'package:Resilio/features/customer/categories/presentation/screens/categories_screen.dart';
import 'package:Resilio/features/customer/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';

import '../../../../../common/widgets/exit_alert_dialog_widget.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../l10n/app_localizations.dart';
import '../cubit/main_screen_cubit.dart';
import '../screens/shorts_screen.dart';
import '../screens/favorite_screen.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../../../explore/presentation/screens/explore_screen.dart';
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<MainScreenCubit>()),
      ],
      child: const _MainScreenView(),
    );
  }
}

class _MainScreenView extends StatefulWidget {
  const _MainScreenView();

  @override
  State<_MainScreenView> createState() => _MainScreenViewState();
}

class _MainScreenViewState extends State<_MainScreenView>
    with SingleTickerProviderStateMixin {
  dynamic _selectedCategory;
  late AnimationController _animationController;
  late Animation<Offset> _navBarOffset;
  late PageController _pageController;
  late List<Widget> _screens;

  static const int _totalTabs = 5;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _navBarOffset = Tween<Offset>(begin: Offset.zero, end: const Offset(0, 2.0))
        .animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );

    _updateScreens();
  }

  void _updateScreens() {
    _screens = [
      _KeepAlivePage(
        child: DashboardScreen(onViewAllCategories: _onViewAllCategories),
      ),
      const _KeepAlivePage(child: ExploreScreen()),
      const _KeepAlivePage(child: ShortsScreen()),
      _KeepAlivePage(
        child: CategoryScreen(
          selectedCategory: _selectedCategory,
          onSearchActiveChanged: _handleSearchActiveChanged,
        ),
      ),
      _KeepAlivePage(
        child: FavoriteScreen(
          onSearchActiveChanged: _handleSearchActiveChanged,
        ),
      ),
    ];
  }

  void _handleSearchActiveChanged(bool isActive) {
    final cubit = context.read<MainScreenCubit>();
    cubit.setSearchActive(isActive);

    if (isActive) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }

    log('Search active: $isActive', name: 'MainScreen');
  }

  void _onItemTapped(int index) {
    final cubit = context.read<MainScreenCubit>();
    cubit.changeTab(index);

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );

    if (index == 3) {
      _selectedCategory = null;
      cubit.updateSelectedCategory(null);
      _updateScreens();
    }

    cubit.setSearchActive(false);
    cubit.setNavBarVisibility(true);
    _animationController.reverse();

    log('Tab switched to index: $index', name: 'MainScreen');
  }

  void _onPageChanged(int index) {
    final cubit = context.read<MainScreenCubit>();
    cubit.changeTab(index);

    if (index == 3) {
      _selectedCategory = null;
      cubit.updateSelectedCategory(null);
      _updateScreens();
    }

    cubit.setSearchActive(false);
    cubit.setNavBarVisibility(true);
    _animationController.reverse();

    log('Page swiped to index: $index', name: 'MainScreen');
  }

  void _onViewAllCategories() {
    final cubit = context.read<MainScreenCubit>();
    cubit.changeTab(3);

    _pageController.animateToPage(
      3,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );

    _selectedCategory = null;
    cubit.updateSelectedCategory(null);
    _updateScreens();

    cubit.setSearchActive(false);
    cubit.setNavBarVisibility(true);
    _animationController.reverse();

    log('Navigated to Category tab via View All', name: 'MainScreen');
  }

  void _handlePopScope() async {
    final cubit = context.read<MainScreenCubit>();
    final l10n = AppLocalizations.of(context)!;

    if (cubit.state.selectedIndex != 0) {
      cubit.resetToHome();
      _pageController.animateToPage(
        0,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
      _animationController.reverse();
    } else {
      final bool shouldExit = await CustomAlertDialog.show(
        context: context,
        title: l10n.exitAppTitle,
        message: l10n.exitAppMessage,
        cancelText: l10n.cancel,
        confirmText: l10n.exitButton,
      );

      if (shouldExit) {
        SystemNavigator.pop();
      }
    }
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    final cubit = context.read<MainScreenCubit>();

    if (cubit.state.isSearchActive) return false;

    if (notification is UserScrollNotification) {
      if (notification.metrics.axis == Axis.vertical) {
        if (notification.direction == ScrollDirection.reverse &&
            cubit.state.isNavBarVisible) {
          cubit.setNavBarVisibility(false);
          _animationController.forward();
        } else if (notification.direction == ScrollDirection.forward &&
            !cubit.state.isNavBarVisible) {
          cubit.setNavBarVisibility(true);
          _animationController.reverse();
        }
      }
    }
    return false;
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenCubit, MainScreenState>(
      builder: (context, state) {
        return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
            if (!didPop) {
              _handlePopScope();
            }
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            extendBody: true,
            body: Stack(
              children: [
                NotificationListener<ScrollNotification>(
                  onNotification: _handleScrollNotification,
                  child: AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      return PageView.builder(
                        controller: _pageController,
                        onPageChanged: _onPageChanged,
                        physics: const BouncingScrollPhysics(),
                        itemCount: _totalTabs,
                        itemBuilder: (context, index) {
                          double value = 0.0;
                          if (_pageController.position.haveDimensions) {
                            value = (index - (_pageController.page ?? 0));
                            value = (value * 0.04).clamp(-1.0, 1.0);
                          }

                          return Transform(
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateY(value * math.pi / 2)
                              ..scale(1.0 - value.abs() * 0.15),
                            alignment: value >= 0
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Opacity(
                              opacity: (1.0 - value.abs() * 0.5).clamp(
                                0.0,
                                1.0,
                              ),
                              child: _screens[index],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Positioned(
                  left: 16.w,
                  right: 16.w,
                  bottom: 14.h,
                  child: SlideTransition(
                    position: _navBarOffset,
                    child: CustomBottomNavBar(
                      selectedIndex: state.selectedIndex,
                      onItemTapped: _onItemTapped,
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

class _KeepAlivePage extends StatefulWidget {
  final Widget child;

  const _KeepAlivePage({required this.child});

  @override
  State<_KeepAlivePage> createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<_KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
