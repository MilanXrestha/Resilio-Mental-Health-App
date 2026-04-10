import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/app_text_styles.dart';

class SessionBookingScreen extends StatefulWidget {
  final String therapistId;
  const SessionBookingScreen({super.key, required this.therapistId});

  @override
  State<SessionBookingScreen> createState() => _SessionBookingScreenState();
}

class _SessionBookingScreenState extends State<SessionBookingScreen> {
  int? _selectedSlotIndex;
  
  final List<String> _availableSlots = [
    "Today, 2:00 PM",
    "Today, 4:00 PM",
    "Tomorrow, 10:00 AM",
    "Tomorrow, 1:00 PM",
  ];

  void _processPayment() {
    // Show Esewa mock processing
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('Processing Payment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            SizedBox(height: 16.h),
            const Text('Connecting to eSewa...'),
          ],
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (context.mounted) {
        context.pop(); // dismiss dialog
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Payment Successful! Session Booked.'), backgroundColor: Colors.green),
        );
        context.pop(); // go back from booking
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Session')),
      body: ListView(
        padding: EdgeInsets.all(24.w),
        children: [
          Row(
            children: [
              CircleAvatar(radius: 30.r, child: const Icon(Icons.person, size: 30)),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Dr. Jane Smith', style: AppTextStyles.titleLarge),
                  Text('Clinical Psychologist', style: AppTextStyles.bodyMedium),
                ],
              ),
            ],
          ),
          SizedBox(height: 32.h),
          Text('Available Slots', style: AppTextStyles.titleMedium),
          SizedBox(height: 16.h),
          Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children: List.generate(_availableSlots.length, (index) {
              final isSelected = _selectedSlotIndex == index;
              return ChoiceChip(
                label: Text(_availableSlots[index]),
                selected: isSelected,
                onSelected: (val) {
                  setState(() => _selectedSlotIndex = val ? index : null);
                },
                selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
              );
            }),
          ),
          SizedBox(height: 48.h),
          
          if (_selectedSlotIndex != null) ...[
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Session Fee', style: AppTextStyles.bodyLarge),
                      Text('NPR 1500', style: AppTextStyles.titleMedium),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _processPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // eSewa color hint
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                ),
                child: const Text('Pay with eSewa', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
