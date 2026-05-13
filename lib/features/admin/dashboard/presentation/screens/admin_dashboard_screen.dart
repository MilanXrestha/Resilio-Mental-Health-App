import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Resilio/core/theme/app_colors.dart';
import 'package:Resilio/core/di/injection.dart';
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
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          backgroundColor: context.surfaceColor,
          selectedItemColor: context.primaryColor,
          unselectedItemColor: context.textSecondaryColor,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
          selectedLabelStyle: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 11),
          unselectedLabelStyle: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 11),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_rounded),
              label: 'Overview',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.perm_media_rounded),
              label: 'Content',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.psychology_rounded),
              label: 'Therapists',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_rounded),
              label: 'Users',
            ),
          ],
        ),
      ),
    );
  }
}
