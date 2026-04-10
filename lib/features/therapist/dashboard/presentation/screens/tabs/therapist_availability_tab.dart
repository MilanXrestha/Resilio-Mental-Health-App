import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../bloc/therapist_cubit.dart';
import '../../bloc/therapist_state.dart';

class TherapistAvailabilityTab extends StatefulWidget {
  const TherapistAvailabilityTab({super.key});

  @override
  State<TherapistAvailabilityTab> createState() => _TherapistAvailabilityTabState();
}

class _TherapistAvailabilityTabState extends State<TherapistAvailabilityTab> {
  // Mock local state array for day availability
  Map<String, bool> _days = {
    'Monday': true,
    'Tuesday': true,
    'Wednesday': true,
    'Thursday': true,
    'Friday': true,
    'Saturday': false,
    'Sunday': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Availability & Schedule')),
      body: BlocBuilder<TherapistCubit, TherapistState>(
        builder: (context, state) {
          return ListView(
             padding: EdgeInsets.all(24.w),
             children: [
               Text('Manage your weekly working hours', style: AppTextStyles.bodyLarge),
               SizedBox(height: 24.h),
               ..._days.keys.map((day) => _DayAvailabilityRow(
                 day: day, 
                 isEnabled: _days[day]!,
                 onChanged: (val) {
                   setState(() => _days[day] = val);
                 },
               )),
               SizedBox(height: 32.h),
               ElevatedButton(
                 onPressed: () {
                   context.read<TherapistCubit>().updateAvailability({
                     'days': _days,
                     // add more detailed time blocks if needed
                   });
                   ScaffoldMessenger.of(context).showSnackBar(
                     const SnackBar(content: Text('Schedule updated')),
                   );
                 },
                 child: const Text('Save Schedule'),
               ),
             ],
           );
        },
      ),
    );
  }
}

class _DayAvailabilityRow extends StatelessWidget {
  final String day;
  final bool isEnabled;
  final ValueChanged<bool> onChanged;

  const _DayAvailabilityRow({
    required this.day, 
    this.isEnabled = true,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Switch(
            value: isEnabled,
            onChanged: onChanged,
          ),
          SizedBox(width: 8.w),
          SizedBox(
            width: 90.w,
            child: Text(day, style: AppTextStyles.titleMedium),
          ),
          const Spacer(),
          if (isEnabled) ...[
            Text('09:00 AM', style: AppTextStyles.bodyMedium),
            Text(' - ', style: AppTextStyles.bodyMedium),
            Text('05:00 PM', style: AppTextStyles.bodyMedium),
            IconButton(icon: const Icon(Icons.edit, size: 16), onPressed: () {}),
          ] else
            Text('Unavailable', style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey)),
        ],
      ),
    );
  }
}
