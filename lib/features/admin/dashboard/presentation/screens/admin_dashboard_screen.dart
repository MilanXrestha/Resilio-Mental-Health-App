import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Resilio/core/theme/app_colors.dart';
import 'package:Resilio/core/di/injection.dart';
import 'package:Resilio/l10n/app_localizations.dart';
import 'admin_overview_screen.dart';
import 'admin_content_screen.dart';
import 'admin_therapists_screen.dart';
import 'admin_users_screen.dart';
import '../bloc/admin_cubit.dart';
import '../bloc/admin_content_cubit.dart';
import '../bloc/admin_revenue_cubit.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _currentIndex = 0;

  late final AdminCubit _adminCubit;
  late final AdminContentCubit _adminContentCubit;
  late final AdminRevenueCubit _adminRevenueCubit;

  @override
  void initState() {
    super.initState();
    _adminCubit = getIt<AdminCubit>();
    _adminContentCubit = getIt<AdminContentCubit>();
    _adminRevenueCubit = getIt<AdminRevenueCubit>();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 4 core tabs
    final List<Widget> pages = [
      AdminOverviewScreen(onNavigateTab: _onTabTapped),
      const AdminContentScreen(),
      const AdminTherapistsScreen(),
      const AdminUsersScreen(),
    ];

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _adminCubit),
        BlocProvider.value(value: _adminContentCubit),
        BlocProvider.value(value: _adminRevenueCubit),
      ],
      child: Scaffold(
        backgroundColor: context.backgroundColor,
        body: IndexedStack(
          index: _currentIndex,
          children: pages,
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: _onTabTapped,
          backgroundColor: context.surfaceColor,
          elevation: 0,
          indicatorColor: context.primaryColor.withOpacity(0.15),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.dashboard_outlined, color: context.textSecondaryColor),
              selectedIcon: Icon(Icons.dashboard_rounded, color: context.primaryColor),
              label: AppLocalizations.of(context)!.admOverview,
            ),
            NavigationDestination(
              icon: Icon(Icons.perm_media_outlined, color: context.textSecondaryColor),
              selectedIcon: Icon(Icons.perm_media_rounded, color: context.primaryColor),
              label: AppLocalizations.of(context)!.admContent,
            ),
            NavigationDestination(
              icon: Icon(Icons.psychology_outlined, color: context.textSecondaryColor),
              selectedIcon: Icon(Icons.psychology_rounded, color: context.primaryColor),
              label: AppLocalizations.of(context)!.admTherapists,
            ),
            NavigationDestination(
              icon: Icon(Icons.people_outline_rounded, color: context.textSecondaryColor),
              selectedIcon: Icon(Icons.people_rounded, color: context.primaryColor),
              label: AppLocalizations.of(context)!.admUsers,
            ),
          ],
        ),
      ),
    );
  }
}
