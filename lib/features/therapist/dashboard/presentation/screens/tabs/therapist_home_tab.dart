import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../bloc/therapist_cubit.dart';
import '../../bloc/therapist_state.dart';

class TherapistHomeTab extends StatelessWidget {
  const TherapistHomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TherapistCubit, TherapistState>(
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (msg) => Center(child: Text('Error: $msg')),
              loaded: (profile, today, upcoming) => _buildContent(context, profile, today, upcoming),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, Map<String, dynamic> profile, List<dynamic> today, List<dynamic> upcoming) {
    final name = profile['displayName'] ?? 'Therapist';
    final nextApp = today.isNotEmpty ? today.first : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 32.h),
        Text(
          'Welcome, Dr. $name',
          style: AppTextStyles.displayMedium,
        ),
        SizedBox(height: 8.h),
        Text(
          'Here is your overview for today.',
          style: AppTextStyles.bodyLarge,
        ),
        SizedBox(height: 32.h),
        
        // Stats Row
        Row(
          children: [
            Expanded(
              child: _StatCard(title: 'Today', value: '${today.length} Sessions', color: Colors.blue.shade100),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: _StatCard(title: 'Upcoming', value: '${upcoming.length} Sessions', color: Colors.orange.shade100),
            ),
          ],
        ),
        
        SizedBox(height: 32.h),
        if (nextApp != null) ...[
          Text(
            'Next Appointment',
            style: AppTextStyles.titleLarge,
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(radius: 24.r, child: const Icon(Icons.person)),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(nextApp['userName'] ?? 'Patient', style: AppTextStyles.titleMedium),
                      Text(nextApp['startTime'] ?? 'Soon', style: AppTextStyles.bodyMedium),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final userId = profile['id'] ?? '';
                    final appointmentId = nextApp['id'] ?? '';
                    context.push('/video-call/$appointmentId/$userId');
                  },
                  child: const Text('Join'),
                ),
              ],
            ),
          ),
        ] else ...[
          Text('No upcoming appointments today.', style: AppTextStyles.bodyLarge),
        ],
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _StatCard({required this.title, required this.value, required this.color});

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
          Text(title, style: AppTextStyles.bodyMedium.copyWith(color: Colors.black54)),
          SizedBox(height: 8.h),
          Text(value, style: AppTextStyles.titleLarge.copyWith(color: Colors.black87)),
        ],
      ),
    );
  }
}
