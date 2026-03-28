import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../domain/entities/explore_item_entity.dart';

class ExploreFilterSheet extends StatefulWidget {
  final ExploreFilter currentFilter;
  final ValueChanged<ExploreFilter> onApply;
  final VoidCallback onClear;

  const ExploreFilterSheet({
    super.key,
    required this.currentFilter,
    required this.onApply,
    required this.onClear,
  });

  @override
  State<ExploreFilterSheet> createState() => _ExploreFilterSheetState();
}

class _ExploreFilterSheetState extends State<ExploreFilterSheet> {
  late ExploreFilter _filter;

  @override
  void initState() {
    super.initState();
    _filter = widget.currentFilter;
  }

  void _toggleType(ExploreItemType type) {
    final types = List<ExploreItemType>.from(_filter.types);
    if (types.contains(type)) {
      types.remove(type);
    } else {
      types.add(type);
    }
    setState(() {
      _filter = _filter.copyWith(types: types);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: context.borderColor,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                Text(
                  'Filters',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: context.textPrimaryColor,
                  ),
                ),
                const Spacer(),
                if (_filter.hasActiveFilters)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _filter = _filter.clearFilters();
                      });
                    },
                    child: Text(
                      'Clear All',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: context.errorColor,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Content types
          _buildSection(
            title: 'Content Type',
            child: Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: ExploreItemType.values.map((type) {
                final isSelected = _filter.types.contains(type);
                return _FilterChip(
                  label: _getTypeLabel(type),
                  icon: _getTypeIcon(type),
                  isSelected: isSelected,
                  onTap: () => _toggleType(type),
                );
              }).toList(),
            ),
          ),

          SizedBox(height: 20.h),

          // Featured only toggle
          _buildSection(
            title: 'Show Only',
            child: Column(
              children: [
                _FilterToggle(
                  label: 'Featured Content',
                  icon: Icons.star_rounded,
                  isSelected: _filter.isFeaturedOnly == true,
                  onTap: () {
                    setState(() {
                      _filter = _filter.copyWith(
                        isFeaturedOnly: _filter.isFeaturedOnly == true ? null : true,
                      );
                    });
                  },
                ),
                SizedBox(height: 10.h),
                _FilterToggle(
                  label: 'Premium Content',
                  icon: Icons.workspace_premium_rounded,
                  isSelected: _filter.isPremiumOnly == true,
                  onTap: () {
                    setState(() {
                      _filter = _filter.copyWith(
                        isPremiumOnly: _filter.isPremiumOnly == true ? null : true,
                      );
                    });
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: 20.h),

          // Sort by
          _buildSection(
            title: 'Sort By',
            child: Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: ExploreSortBy.values.map((sortBy) {
                final isSelected = _filter.sortBy == sortBy;
                return _FilterChip(
                  label: _getSortLabel(sortBy),
                  isSelected: isSelected,
                  onTap: () {
                    setState(() {
                      _filter = _filter.copyWith(sortBy: sortBy);
                    });
                  },
                );
              }).toList(),
            ),
          ),

          SizedBox(height: 32.h),

          // Apply button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: () {
                  widget.onApply(_filter);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Apply Filters',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 24.h + MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: context.textSecondaryColor,
            ),
          ),
          SizedBox(height: 12.h),
          child,
        ],
      ),
    );
  }

  String _getTypeLabel(ExploreItemType type) {
    switch (type) {
      case ExploreItemType.audio:
        return 'Audio';
      case ExploreItemType.shortVideo:
        return 'Shorts';
      case ExploreItemType.longVideo:
        return 'Videos';
      case ExploreItemType.quote:
        return 'Quotes';
      case ExploreItemType.tip:
        return 'Tips';
      case ExploreItemType.image:
        return 'Images';
      case ExploreItemType.category:
        return 'Categories';
    }
  }

  IconData _getTypeIcon(ExploreItemType type) {
    switch (type) {
      case ExploreItemType.audio:
        return Icons.headphones_rounded;
      case ExploreItemType.shortVideo:
        return Icons.play_circle_outline_rounded;
      case ExploreItemType.longVideo:
        return Icons.ondemand_video_rounded;
      case ExploreItemType.quote:
        return Icons.format_quote_rounded;
      case ExploreItemType.tip:
        return Icons.lightbulb_outline_rounded;
      case ExploreItemType.image:
        return Icons.image_rounded;
      case ExploreItemType.category:
        return Icons.category_rounded;
    }
  }

  String _getSortLabel(ExploreSortBy sortBy) {
    switch (sortBy) {
      case ExploreSortBy.relevance:
        return 'Relevance';
      case ExploreSortBy.newest:
        return 'Newest';
      case ExploreSortBy.oldest:
        return 'Oldest';
      case ExploreSortBy.title:
        return 'Title';
      case ExploreSortBy.duration:
        return 'Duration';
    }
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected
              ? context.primaryColor
              : context.surfaceColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected
                ? context.primaryColor
                : context.borderColor.withOpacity(0.5),
            width: 1.5.w,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: context.primaryColor.withOpacity(0.3),
              blurRadius: 8.r,
              offset: Offset(0, 4.h),
            ),
          ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 18.sp,
                color: isSelected ? Colors.white : context.textSecondaryColor,
              ),
              SizedBox(width: 6.w),
            ],
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : context.textPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterToggle extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterToggle({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected
                ? context.primaryColor
                : context.borderColor.withOpacity(0.3),
            width: 1.5.w,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 22.sp,
              color: isSelected
                  ? context.primaryColor
                  : context.textSecondaryColor,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: context.textPrimaryColor,
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                color: isSelected
                    ? context.primaryColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(
                  color: isSelected
                      ? context.primaryColor
                      : context.borderColor,
                  width: 2.w,
                ),
              ),
              child: isSelected
                  ? Icon(
                Icons.check_rounded,
                size: 16.sp,
                color: Colors.white,
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}