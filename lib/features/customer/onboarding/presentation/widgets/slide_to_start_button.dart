import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resilio/core/theme/app_text_styles.dart';

class SlideToStartButton extends StatefulWidget {
  final VoidCallback onSlideComplete;
  final bool isDarkMode;
  final String text;

  const SlideToStartButton({
    super.key,
    required this.onSlideComplete,
    required this.isDarkMode,
    required this.text,
  });

  @override
  State<SlideToStartButton> createState() => _SlideToStartButtonState();
}

class _SlideToStartButtonState extends State<SlideToStartButton>
    with TickerProviderStateMixin {
  double _dragPosition = 0.0;

  /// Calculated after first frame from the rendered thumb width.
  double _maxDrag = 0.0;

  bool _isCompleted = false;

  /// Key used to measure the thumb's rendered width after layout.
  final GlobalKey _thumbKey = GlobalKey();

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Measure thumb size after the first frame.
    WidgetsBinding.instance.addPostFrameCallback(_updateMaxDrag);
  }

  @override
  void didUpdateWidget(SlideToStartButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      // Language changed → text may be wider/narrower.
      // Reset position and re-measure next frame.
      _dragPosition = 0.0;
      _isCompleted = false;
      WidgetsBinding.instance.addPostFrameCallback(_updateMaxDrag);
    }
  }

  /// Reads the thumb and outer container sizes from the render tree and
  /// stores the correct [_maxDrag] so the thumb never leaves the track.
  void _updateMaxDrag(_) {
    if (!mounted) return;

    final thumbCtx = _thumbKey.currentContext;
    if (thumbCtx == null) return;
    final thumbBox = thumbCtx.findRenderObject() as RenderBox?;
    if (thumbBox == null || !thumbBox.hasSize) return;

    // The outer widget's render box gives us the track width.
    final outerBox = context.findRenderObject() as RenderBox?;
    if (outerBox == null || !outerBox.hasSize) return;

    // 4.w margin on each side of the thumb → total 8.w reserved.
    final newMaxDrag =
        (outerBox.size.width - thumbBox.size.width - 8.w).clamp(0.0, double.infinity);

    if (newMaxDrag != _maxDrag) {
      setState(() => _maxDrag = newMaxDrag);
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (_isCompleted) return;
    setState(() {
      _dragPosition =
          (_dragPosition + details.delta.dx).clamp(0.0, _maxDrag);
    });
  }

  void _onHorizontalDragEnd(DragEndDetails _) {
    if (_isCompleted) return;
    if (_dragPosition > _maxDrag * 0.8) {
      setState(() {
        _dragPosition = _maxDrag;
        _isCompleted = true;
      });
      widget.onSlideComplete();
    } else {
      setState(() => _dragPosition = 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      child: ClipRRect(
        // Clips the thumb so it can never visually overflow the track.
        borderRadius: BorderRadius.circular(30.r),
        child: Container(
          width: double.infinity,
          height: 60.h,
          decoration: BoxDecoration(
            color: widget.isDarkMode
                ? Colors.white.withValues(alpha: 0.1)
                : const Color(0xFFF0F0F0),
            borderRadius: BorderRadius.circular(30.r),
            border: Border.all(
              color: widget.isDarkMode
                  ? Colors.white.withValues(alpha: 0.2)
                  : const Color(0xFFE0E0E0),
              width: 1.5,
            ),
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            // Hard clip so the translating thumb is always within bounds.
            clipBehavior: Clip.hardEdge,
            children: [
              // Background hint arrows on the right.
              Positioned(
                right: 20.w,
                child: Row(
                  children: [
                    Icon(
                      Icons.chevron_right,
                      color: widget.isDarkMode
                          ? Colors.white.withValues(alpha: 0.3)
                          : Colors.grey.shade400,
                      size: 20.sp,
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: widget.isDarkMode
                          ? Colors.white.withValues(alpha: 0.4)
                          : Colors.grey.shade500,
                      size: 20.sp,
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: widget.isDarkMode
                          ? Colors.white.withValues(alpha: 0.5)
                          : Colors.grey.shade600,
                      size: 20.sp,
                    ),
                  ],
                ),
              ),

              // Sliding thumb.
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, _) {
                  return Transform.translate(
                    offset: Offset(_dragPosition, 0),
                    child: Container(
                      key: _thumbKey,
                      margin: EdgeInsets.all(4.w),
                      height: 52.h,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(26.r),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context)
                                .primaryColor
                                .withValues(alpha: 0.4 * _pulseAnimation.value),
                            blurRadius: 16 * _pulseAnimation.value,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: 24.w),
                          Text(
                            widget.text,
                            style: AppTextStyles.onboardingButton.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                          SizedBox(width: 24.w),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
