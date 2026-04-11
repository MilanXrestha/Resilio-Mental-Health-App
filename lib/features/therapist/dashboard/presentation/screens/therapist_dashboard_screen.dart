import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/di/injection.dart';
import '../bloc/therapist_cubit.dart';
import '../bloc/therapist_content_cubit.dart';

import 'tabs/therapist_home_tab.dart';
import 'tabs/therapist_appointments_tab.dart';
import 'tabs/therapist_patients_tab.dart';
import 'tabs/therapist_earnings_tab.dart';
import 'tabs/therapist_content_hub_tab.dart';
import 'tabs/therapist_settings_tab.dart';

class TherapistDashboardScreen extends StatefulWidget {
  const TherapistDashboardScreen({super.key});

  @override
  State<TherapistDashboardScreen> createState() =>
      _TherapistDashboardScreenState();
}

class _TherapistDashboardScreenState extends State<TherapistDashboardScreen> {
  int _currentIndex = 0;

  static const _tabs = [
    TherapistHomeTab(),
    TherapistAppointmentsTab(),
    TherapistPatientsTab(),
    TherapistEarningsTab(),
    TherapistContentHubTab(),
    TherapistSettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<TherapistCubit>()..loadDashboard(),
        ),
        BlocProvider(
          create: (_) => getIt<TherapistContentCubit>(),
        ),
      ],
      child: Scaffold(
        backgroundColor: context.backgroundColor,
        body: IndexedStack(index: _currentIndex, children: _tabs),
        bottomNavigationBar: _TherapistNavBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
        ),
      ),
    );
  }
}

// ─── Custom Nav Bar ────────────────────────────────────────────────────────────
class _TherapistNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _TherapistNavBar(
      {required this.currentIndex, required this.onTap});

  static const _items = [
    _NavItem(
        icon: Icons.home_outlined,
        activeIcon: Icons.home_rounded,
        label: 'Home'),
    _NavItem(
        icon: Icons.calendar_month_outlined,
        activeIcon: Icons.calendar_month_rounded,
        label: 'Sessions'),
    _NavItem(
        icon: Icons.people_outline_rounded,
        activeIcon: Icons.people_rounded,
        label: 'Patients'),
    _NavItem(
        icon: Icons.account_balance_wallet_outlined,
        activeIcon: Icons.account_balance_wallet_rounded,
        label: 'Earnings'),
    _NavItem(
        icon: Icons.library_books_outlined,
        activeIcon: Icons.library_books_rounded,
        label: 'Content'),
    _NavItem(
        icon: Icons.settings_outlined,
        activeIcon: Icons.settings_rounded,
        label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: context.surfaceColor,
        border: Border(top: BorderSide(color: context.borderColor, width: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.06),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (i) {
              return _NavBarItem(
                item: _items[i],
                selected: currentIndex == i,
                onTap: () => onTap(i),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const _NavItem(
      {required this.icon,
      required this.activeIcon,
      required this.label});
}

class _NavBarItem extends StatelessWidget {
  final _NavItem item;
  final bool selected;
  final VoidCallback onTap;

  const _NavBarItem(
      {required this.item, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
            horizontal: selected ? 12.w : 6.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: selected
              ? context.primaryColor.withOpacity(0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              selected ? item.activeIcon : item.icon,
              size: 20.sp,
              color: selected
                  ? context.primaryColor
                  : context.textSecondaryColor,
            ),
            if (selected) ...[
              SizedBox(width: 4.w),
              Text(
                item.label,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: context.primaryColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
