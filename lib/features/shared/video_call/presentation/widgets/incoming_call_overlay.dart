import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/routing/app_router.dart';

/// Small slide-in banner that appears on top of any screen when a call arrives.
/// Use [IncomingCallOverlayManager.show] / [IncomingCallOverlayManager.dismiss].
class IncomingCallOverlayManager {
  IncomingCallOverlayManager._();

  static OverlayEntry? _entry;
  static Timer? _autoDeclineTimer;

  static void show({
    required OverlayState overlayState,
    required String appointmentId,
    required String callerName,
    required String userId,
  }) {
    dismiss(); // remove any existing banner first
    _entry = OverlayEntry(
      builder: (_) => _CallBanner(
        appointmentId: appointmentId,
        callerName: callerName,
        userId: userId,
        onDismiss: dismiss,
      ),
    );
    overlayState.insert(_entry!);
    _autoDeclineTimer = Timer(const Duration(seconds: 30), dismiss);
  }

  static void dismiss() {
    _autoDeclineTimer?.cancel();
    _autoDeclineTimer = null;
    _entry?.remove();
    _entry = null;
  }
}

// ── Small banner widget ────────────────────────────────────────────────────────
class _CallBanner extends StatefulWidget {
  final String appointmentId;
  final String callerName;
  final String userId;
  final VoidCallback onDismiss;

  const _CallBanner({
    required this.appointmentId,
    required this.callerName,
    required this.userId,
    required this.onDismiss,
  });

  @override
  State<_CallBanner> createState() => _CallBannerState();
}

class _CallBannerState extends State<_CallBanner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, -1.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutBack));
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _accept() {
    widget.onDismiss();
    AppRouter.router.push(
      '/video-call/${widget.appointmentId}/${widget.userId}',
      extra: {'callerName': widget.callerName},
    );
  }

  void _decline() => widget.onDismiss();

  @override
  Widget build(BuildContext context) {
    final initial = widget.callerName.isNotEmpty
        ? widget.callerName[0].toUpperCase()
        : '?';

    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: SlideTransition(
          position: _slide,
          child: Padding(
            padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 0),
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1C2E),
                  borderRadius: BorderRadius.circular(18.r),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.55),
                      blurRadius: 24,
                      spreadRadius: 2,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // ── Avatar ────────────────────────────────────────
                    Container(
                      width: 44.r,
                      height: 44.r,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFF0D9488), Color(0xFF14B8A6)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          initial,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    // ── Info ─────────────────────────────────────────
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.callerName,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Incoming video call · Resilio',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11.sp,
                              color: Colors.white54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    // ── Decline ───────────────────────────────────────
                    _RoundBtn(
                      icon: Icons.call_end_rounded,
                      color: const Color(0xFFDC2626),
                      size: 40.r,
                      onTap: _decline,
                    ),
                    SizedBox(width: 8.w),
                    // ── Accept ────────────────────────────────────────
                    _RoundBtn(
                      icon: Icons.videocam_rounded,
                      color: const Color(0xFF16A34A),
                      size: 40.r,
                      onTap: _accept,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Small circular button ──────────────────────────────────────────────────────
class _RoundBtn extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  final VoidCallback onTap;

  const _RoundBtn({
    required this.icon,
    required this.color,
    required this.size,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.45),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: size * 0.45),
      ),
    );
  }
}
