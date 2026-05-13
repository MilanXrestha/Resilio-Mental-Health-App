import '../../widgets/shimmer_therapist_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../bloc/therapist_content_cubit.dart';
import 'content/add_edit_content_sheet.dart';

class TherapistContentHubTab extends StatefulWidget {
  const TherapistContentHubTab({super.key});

  @override
  State<TherapistContentHubTab> createState() => _TherapistContentHubTabState();
}

class _TherapistContentHubTabState extends State<TherapistContentHubTab> {
  final List<String> _tabs = ['tips', 'quotes', 'videos', 'audio'];
  String _activeTab = 'tips';

  @override
  void initState() {
    super.initState();
    context.read<TherapistContentCubit>().loadContent(_activeTab);
  }

  void _onTabChanged(String tab) {
    setState(() => _activeTab = tab);
    context.read<TherapistContentCubit>().switchTab(tab);
  }

  void _showAddSheet(
    BuildContext context, [
    Map<String, dynamic>? initialData,
  ]) {
    final cubit = context.read<TherapistContentCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: AddEditContentSheet(
          contentType: _activeTab,
          initialData: initialData,
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, String id) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('Delete Content?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(ctx),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(ctx);
              context.read<TherapistContentCubit>().deleteContent(id);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddSheet(context),
        backgroundColor: context.primaryColor,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'Add ${StringExtension(_activeTab).capitalize()}',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildSegmentedControl(context),
            Expanded(child: _buildContentList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Content Hub',
                style: TextStyle(
                  fontFamily: 'PlayfairDisplay',
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                  color: context.textPrimaryColor,
                ),
              ),
              Text(
                'Manage your global resources',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13.sp,
                  color: context.textSecondaryColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: context.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.library_add_check,
              color: context.primaryColor,
              size: 24.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentedControl(BuildContext context) {
    return Container(
      height: 40.h,
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _tabs.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final tab = _tabs[index];
          final isActive = tab == _activeTab;
          return GestureDetector(
            onTap: () => _onTabChanged(tab),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isActive ? context.primaryColor : context.surfaceColor,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isActive ? Colors.transparent : context.dividerColor,
                ),
              ),
              child: Text(
                StringExtension(tab).capitalize(),
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13.sp,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  color: isActive ? Colors.white : context.textSecondaryColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContentList() {
    return BlocBuilder<TherapistContentCubit, TherapistContentState>(
      builder: (context, state) {
        if (state is TherapistContentLoading) {
          return const TherapistListShimmer();
        }
        if (state is TherapistContentError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        if (state is TherapistContentLoaded) {
          if (state.items.isEmpty) {
            return Center(
              child: Text(
                'No ${_activeTab} found.\nTap + to add some!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: context.textSecondaryColor,
                ),
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.all(24.w),
            itemCount: state.items.length,
            itemBuilder: (context, index) {
              final item = state.items[index];
              return _buildContentCard(item);
            },
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildContentCard(Map<String, dynamic> item) {
    String title = '';
    String sub = '';
    String thumb = '';

    if (_activeTab == 'tips') {
      title = item['title'] ?? 'Tip';
      sub = item['tipText'] ?? item['tip_text'] ?? '';
    } else if (_activeTab == 'quotes') {
      title = item['quoteText'] ?? item['quote_text'] ?? 'Quote';
      sub = item['author'] ?? '';
    } else {
      title = item['title'] ?? 'Media';
      sub = item['description'] ?? '';
      thumb = item['thumbnailUrl'] ?? item['coverImageUrl'] ?? item['thumbnail_url'] ?? item['cover_image_url'] ?? '';
    }

    return Dismissible(
      key: ValueKey(item['id']),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) async {
        _confirmDelete(context, item['id']);
        return false;
      },
      background: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(16.r),
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: GestureDetector(
        onTap: () => _showAddSheet(context, item),
        child: Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: context.surfaceColor,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: context.borderColor, width: 0.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              if (thumb.isNotEmpty) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.network(
                    thumb,
                    width: 60.w,
                    height: 60.w,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 60.w,
                      height: 60.w,
                      color: context.dividerColor,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: context.textPrimaryColor,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      sub,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.sp,
                        color: context.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: context.textSecondaryColor,
                size: 20.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() => "${this[0].toUpperCase()}${substring(1)}";
}
