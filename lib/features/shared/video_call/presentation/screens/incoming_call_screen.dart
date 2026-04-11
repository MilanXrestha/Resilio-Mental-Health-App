import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../customer/auth/presentation/bloc/auth_bloc.dart';
import '../../../../customer/auth/presentation/bloc/auth_state.dart';

class IncomingCallScreen extends StatefulWidget {
  final String appointmentId;
  final String roomId;
  final String callerName;

  const IncomingCallScreen({
    super.key,
    required this.appointmentId,
    required this.roomId,
    required this.callerName,
  });

  @override
  State<IncomingCallScreen> createState() => _IncomingCallScreenState();
}

class _IncomingCallScreenState extends State<IncomingCallScreen>
    with TickerProviderStateMixin {
  late AnimationController _ring1Ctrl, _ring2Ctrl, _ring3Ctrl;
  late AnimationController _avatarPulse;
  late Animation<double> _avatarScale;

  Timer? _countdownTimer;
  int _secondsLeft = 30;

  static const _teal = Color(0xFF0D9488);
  static const _tealLight = Color(0xFF14B8A6);

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    // Three expanding ring controllers, staggered
    _ring1Ctrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat();
    _ring2Ctrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _ring3Ctrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    Future.delayed(const Duration(milliseconds: 667), () {
      if (mounted) _ring2Ctrl.repeat();
    });
    Future.delayed(const Duration(milliseconds: 1334), () {
      if (mounted) _ring3Ctrl.repeat();
    });

    // Avatar gentle pulse
    _avatarPulse = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200))
      ..repeat(reverse: true);
    _avatarScale = Tween<double>(begin: 0.95, end: 1.05).animate(
        CurvedAnimation(parent: _avatarPulse, curve: Curves.easeInOut));

    // Auto-decline countdown
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _secondsLeft--);
      if (_secondsLeft <= 0) _decline();
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _ring1Ctrl.dispose();
    _ring2Ctrl.dispose();
    _ring3Ctrl.dispose();
    _avatarPulse.dispose();
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _accept() {
    _countdownTimer?.cancel();
    final auth = context.read<AuthBloc>().state;
    final userId =
        auth is AuthAuthenticated ? auth.user.id : widget.roomId;
    context.go('/video-call/${widget.appointmentId}/$userId',
        extra: {'callerName': widget.callerName});
  }

  void _decline() {
    _countdownTimer?.cancel();
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Background ─────────────────────────────────────────────────
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topCenter,
                radius: 1.5,
                colors: [Color(0xFF0D2030), Color(0xFF030508)],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 48.h),

                // ── Status label ─────────────────────────────────────────
                _StatusPill(label: 'INCOMING VIDEO CALL'),
                SizedBox(height: 8.h),
                Text(
                  'Resilio',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13.sp,
                    color: Colors.white24,
                    letterSpacing: 2,
                  ),
                ),

                const Spacer(),

                // ── Avatar with rings ────────────────────────────────────
                SizedBox(
                  width: 220.r,
                  height: 220.r,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      _ExpandingRing(
                          controller: _ring3Ctrl, maxSize: 220.r, color: _teal),
                      _ExpandingRing(
                          controller: _ring2Ctrl, maxSize: 180.r, color: _teal),
                      _ExpandingRing(
                          controller: _ring1Ctrl, maxSize: 148.r, color: _teal),
                      ScaleTransition(
                        scale: _avatarScale,
                        child: Container(
                          width: 100.r,
                          height: 100.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [_teal, _tealLight],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: _teal.withValues(alpha: 0.6),
                                blurRadius: 32,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              widget.callerName.isNotEmpty
                                  ? widget.callerName[0].toUpperCase()
                                  : '?',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 42.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 36.h),

                // ── Caller name ──────────────────────────────────────────
                Text(
                  widget.callerName,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                Text(
                  'Video call • Resilio Health',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.sp,
                    color: Colors.white38,
                  ),
                ),

                const Spacer(),

                // ── Countdown ───────────────────────────────────────────
                Text(
                  'Auto-decline in ${_secondsLeft}s',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12.sp,
                    color: Colors.white24,
                  ),
                ),
                SizedBox(height: 20.h),

                // ── Action buttons ───────────────────────────────────────
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 56.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _ActionButton(
                        icon: Icons.call_end_rounded,
                        label: 'Decline',
                        color: const Color(0xFFDC2626),
                        onTap: _decline,
                      ),
                      _ActionButton(
                        icon: Icons.videocam_rounded,
                        label: 'Answer',
                        color: const Color(0xFF16A34A),
                        onTap: _accept,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 52.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Expanding ring widget ────────────────────────────────────────────────────
class _ExpandingRing extends StatelessWidget {
  final AnimationController controller;
  final double maxSize;
  final Color color;

  const _ExpandingRing({
    required this.controller,
    required this.maxSize,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        final v = controller.value;
        final size = maxSize * v;
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: color.withValues(alpha: (1 - v) * 0.35),
              width: 1.5,
            ),
          ),
        );
      },
    );
  }
}

// ── Status pill ──────────────────────────────────────────────────────────────
class _StatusPill extends StatelessWidget {
  final String label;
  const _StatusPill({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: const Color(0xFF0D9488).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: const Color(0xFF0D9488).withValues(alpha: 0.45)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7.r,
            height: 7.r,
            decoration: const BoxDecoration(
              color: Color(0xFF0D9488),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 7.w),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0D9488),
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Action button ────────────────────────────────────────────────────────────
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 68.r,
            height: 68.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.45),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 30.sp),
          ),
          SizedBox(height: 10.h),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13.sp,
              color: Colors.white54,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
