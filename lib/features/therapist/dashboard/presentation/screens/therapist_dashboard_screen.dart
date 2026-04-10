import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/di/injection.dart';
import '../bloc/therapist_cubit.dart';

import 'tabs/therapist_home_tab.dart';
import 'tabs/therapist_appointments_tab.dart';
import 'tabs/therapist_availability_tab.dart';
import 'tabs/therapist_content_tab.dart';

class TherapistDashboardScreen extends StatefulWidget {
  const TherapistDashboardScreen({super.key});

  @override
  State<TherapistDashboardScreen> createState() => _TherapistDashboardScreenState();
}

class _TherapistDashboardScreenState extends State<TherapistDashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const TherapistHomeTab(),
    const TherapistAppointmentsTab(),
    const TherapistAvailabilityTab(),
    const TherapistContentTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TherapistCubit>()..loadDashboard(),
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
            type: BottomNavigationBarType.fixed,
            selectedItemColor: context.primaryColor,
            unselectedItemColor: context.textSecondaryColor,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_outlined),
                activeIcon: Icon(Icons.calendar_month),
                label: 'Sessions',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.access_time_outlined),
                activeIcon: Icon(Icons.access_time_filled),
                label: 'Schedule',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_books_outlined),
                activeIcon: Icon(Icons.library_books),
                label: 'Content',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

