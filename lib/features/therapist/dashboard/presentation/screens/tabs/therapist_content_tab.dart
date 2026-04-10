import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_text_styles.dart';

class TherapistContentTab extends StatelessWidget {
  const TherapistContentTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Content Library')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Upload'),
      ),
      body: ListView(
        padding: EdgeInsets.all(24.w),
        children: [
          Text('Manage your uploaded resources.', style: AppTextStyles.bodyLarge),
          SizedBox(height: 24.h),
          
          _ContentCategorySection(title: 'Audio Sessions', count: 3),
          _ContentCategorySection(title: 'Tips & Guides', count: 5),
          _ContentCategorySection(title: 'Motivational Quotes', count: 12),
        ],
      ),
    );
  }
}

class _ContentCategorySection extends StatelessWidget {
  final String title;
  final int count;

  const _ContentCategorySection({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      child: ListTile(
        title: Text(title, style: AppTextStyles.titleMedium),
        subtitle: Text('$count items'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // Navigate to specific content manager
        },
      ),
    );
  }
}
