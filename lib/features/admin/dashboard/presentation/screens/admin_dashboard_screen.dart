import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/di/injection.dart';
import '../bloc/admin_cubit.dart';

import 'tabs/admin_home_tab.dart';
import 'tabs/admin_therapists_tab.dart';
import 'tabs/admin_users_tab.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const AdminHomeTab(),
    const AdminTherapistsTab(),
    const AdminUsersTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AdminCubit>()..loadDashboard(),
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _tabs,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            selectedItemColor: context.primaryColor,
            unselectedItemColor: context.textSecondaryColor,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined),
                activeIcon: Icon(Icons.dashboard),
                label: 'Overview',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.medical_services_outlined),
                activeIcon: Icon(Icons.medical_services),
                label: 'Therapists',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people_outline),
                activeIcon: Icon(Icons.people),
                label: 'Users',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
