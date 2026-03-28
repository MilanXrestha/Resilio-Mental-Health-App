import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';

class ExploreSearchBar extends StatefulWidget {
  final FocusNode? focusNode;
  final String? initialQuery;
  final ValueChanged<String> onChanged;
  final VoidCallback? onSubmitted;
  final VoidCallback? onClear;
  final VoidCallback? onFilterTap;
  final int activeFilterCount;
  final bool autofocus;

  const ExploreSearchBar({
    super.key,
    this.focusNode,
    this.initialQuery,
    required this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.onFilterTap,
    this.activeFilterCount = 0,
    this.autofocus = false,
  });

  @override
  State<ExploreSearchBar> createState() => _ExploreSearchBarState();
}

class _ExploreSearchBarState extends State<ExploreSearchBar> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuery);
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChanged);

    if (widget.autofocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusNode.requestFocus();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChanged() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(
          color: _isFocused
              ? context.primaryColor
              : context.borderColor.withOpacity(0.3),
          width: _isFocused ? 2.w : 1.5.w,
        ),
        boxShadow: [
          BoxShadow(
            color: _isFocused
                ? context.primaryColor.withOpacity(0.1)
                : Colors.black.withOpacity(0.05),
            blurRadius: _isFocused ? 12.r : 8.r,
            offset: Offset(0, _isFocused ? 4.h : 2.h),
          ),
        ],
      ),
      child: Row(
        children: [
          // Search icon
          Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Icon(
              Icons.search_rounded,
              size: 24.sp,
              color: _isFocused
                  ? context.primaryColor
                  : context.textSecondaryColor,
            ),
          ),

          // Text field
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              onChanged: widget.onChanged,
              onSubmitted: (_) => widget.onSubmitted?.call(),
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: context.textPrimaryColor,
              ),
              decoration: InputDecoration(
                hintText: 'Search meditations, videos, quotes...',
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: context.textSecondaryColor.withOpacity(0.7),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 16.h,
                ),
              ),
            ),
          ),

          // Clear button
          if (_controller.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                _controller.clear();
                widget.onClear?.call();
              },
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: context.textSecondaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    size: 18.sp,
                    color: context.textSecondaryColor,
                  ),
                ),
              ),
            ),

          // Filter button
          GestureDetector(
            onTap: widget.onFilterTap,
            child: Container(
              margin: EdgeInsets.only(right: 8.w),
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: widget.activeFilterCount > 0
                    ? context.primaryColor
                    : context.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    Icons.tune_rounded,
                    size: 22.sp,
                    color: widget.activeFilterCount > 0
                        ? Colors.white
                        : context.primaryColor,
                  ),
                  if (widget.activeFilterCount > 0)
                    Positioned(
                      top: -6.h,
                      right: -6.w,
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: context.errorColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: context.surfaceColor,
                            width: 1.5.w,
                          ),
                        ),
                        child: Text(
                          '${widget.activeFilterCount}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}