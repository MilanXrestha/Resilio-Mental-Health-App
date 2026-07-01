import 'package:flutter/material.dart';
import 'package:Resilio/l10n/app_localizations.dart';
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 56.h,
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF121212) : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: isDarkMode
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6.r,
                  offset: Offset(0, 2.h),
                ),
              ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left icon: back arrow when focused, search icon otherwise
          Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: IconButton(
              icon: _isFocused
                  ? Icon(
                      Icons.chevron_left,
                      size: 30.sp,
                      color: isDarkMode
                          ? Colors.grey.shade400
                          : Colors.grey.shade700,
                    )
                  : Icon(
                      Icons.search_rounded,
                      size: 22.sp,
                      color: isDarkMode
                          ? Colors.grey.shade400
                          : Colors.grey.shade700,
                    ),
              onPressed: _isFocused
                  ? () {
                      _focusNode.unfocus();
                      widget.onClear?.call();
                    }
                  : () => _focusNode.requestFocus(),
            ),
          ),

          // Text field
          Expanded(
            child: Theme(
              data: Theme.of(context).copyWith(
                inputDecorationTheme: const InputDecorationTheme(
                  filled: false,
                  border: InputBorder.none,
                ),
              ),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                onChanged: (v) {
                  setState(() {});
                  widget.onChanged(v);
                },
                onSubmitted: (_) => widget.onSubmitted?.call(),
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.exploreSearchContent,
                  hintStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: isDarkMode
                        ? Colors.grey.shade500
                        : Colors.grey.shade600,
                  ),
                  filled: false,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
                  isDense: true,
                ),
              ),
            ),
          ),

          // Clear button
          if (_controller.text.isNotEmpty)
            IconButton(
              iconSize: 20.sp,
              icon: Icon(
                Icons.close_rounded,
                color:
                    isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
              ),
              onPressed: () {
                _controller.clear();
                setState(() {});
                widget.onClear?.call();
              },
            ),

          // Filter button
          GestureDetector(
            onTap: widget.onFilterTap,
            child: Container(
              margin: EdgeInsets.only(right: 12.w),
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: widget.activeFilterCount > 0
                    ? context.primaryColor
                    : context.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.tune_rounded,
                size: 20.sp,
                color: widget.activeFilterCount > 0
                    ? Colors.white
                    : context.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}