import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../bloc/admin_cubit.dart';
import '../../bloc/admin_state.dart';

class AdminHomeTab extends StatelessWidget {
  const AdminHomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminCubit, AdminState>(
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: state.maybeMap(
              initial: (_) => const SizedBox.shrink(),
              loading: (_) => const Center(child: CircularProgressIndicator()),
              error: (e) => Center(child: Text('Error: ${e.message}')),
              loaded: (loaded) => _buildContent(loaded.stats),
              orElse: () => const SizedBox.shrink(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(Map<String, dynamic> stats) {
    final tUsers = stats['totalUsers']?.toString() ?? '0';
    final tTherapists = stats['totalTherapists']?.toString() ?? '0';
    final pending = stats['pendingVerifications']?.toString() ?? '0';
    final sessions = stats['activeSessions']?.toString() ?? '0';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 32.h),
        Text('Admin Overview', style: AppTextStyles.displayMedium),
        SizedBox(height: 24.h),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                title: 'Total Users',
                value: tUsers,
                color: Colors.blue.shade100,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: _StatCard(
                title: 'Therapists',
                value: tTherapists,
                color: Colors.green.shade100,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                title: 'Pending Verifications',
                value: pending,
                color: Colors.orange.shade100,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: _StatCard(
                title: 'Active Sessions',
                value: sessions,
                color: Colors.purple.shade100,
              ),
            ),
          ],
        ),
        SizedBox(height: 32.h),
        Text('Recent Activity', style: AppTextStyles.titleLarge),
        SizedBox(height: 16.h),
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.history),
                title: const Text('System Event'),
                subtitle: const Text('2 hours ago'),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.black54),
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: AppTextStyles.titleLarge.copyWith(color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
