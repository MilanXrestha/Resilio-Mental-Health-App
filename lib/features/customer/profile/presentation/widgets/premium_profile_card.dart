import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Resilio/features/customer/profile/domain/entities/profile_entity.dart';
import 'package:Resilio/features/customer/subscription/domain/entities/subscription_entity.dart';
import 'package:Resilio/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class PremiumProfileCard extends StatelessWidget {
  final ProfileEntity profile;
  final SubscriptionEntity subscription;

  const PremiumProfileCard({
    super.key,
    required this.profile,
    required this.subscription,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0A0A0A),
            Color(0xFF1A1208),
            Color(0xFF0D0D0D),
          ],
          stops: [0.0, 0.5, 1.0],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD4AF37).withValues(alpha: 0.35),
            blurRadius: 24,
            spreadRadius: 2,
            offset: Offset(0, 8.h),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 12,
            offset: Offset(0, 4.h),
          ),
        ],
        border: Border.all(
          color: const Color(0xFFD4AF37).withValues(alpha: 0.4),
          width: 1.2.w,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Stack(
          children: [
            // Background patterns
            const Positioned.fill(child: _CardBackgroundPainter()),

            // Holographic sheen overlay
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFFD4AF37).withValues(alpha: 0.04),
                      Colors.transparent,
                      const Color(0xFFD4AF37).withValues(alpha: 0.06),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.35, 0.65, 1.0],
                  ),
                ),
              ),
            ),

            // Card content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Top row ──────────────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Plan badge
                      _PlanBadge(planName: subscription.planId),

                      // Avatar with ring
                      _AvatarWithCrown(profile: profile),
                    ],
                  ),

                  const Spacer(),

                  // ── Center row: Modern Chip + Membership ID ──────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _ModernChip(),
                      Text(
                        '#${subscription.id.substring(0, 8).toUpperCase()}',
                        style: TextStyle(
                          color: const Color(0xFFD4AF37).withValues(alpha: 0.5),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  // ── Bottom Section: Name & Expiry ────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Name block
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.accCardHolder,
                              style: TextStyle(
                                color: const Color(0xFFD4AF37)
                                    .withValues(alpha: 0.5),
                                fontSize: 8.sp,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              profile.displayName.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.2,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),

                      // Valid thru (Expiry)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.accValidThru,
                            style: TextStyle(
                              color: const Color(0xFFD4AF37)
                                  .withValues(alpha: 0.5),
                              fontSize: 8.sp,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            subscription.endDate != null
                                ? DateFormat('MM / yy').format(subscription.endDate!)
                                : '-- / --',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  // ── Logo branding row ───────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.accResilioPremium,
                        style: TextStyle(
                          color: const Color(0xFFD4AF37).withValues(alpha: 0.8),
                          fontWeight: FontWeight.w900,
                          fontSize: 12.sp,
                          letterSpacing: 3,
                        ),
                      ),
                      Container(
                        width: 40.w,
                        height: 2.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              const Color(0xFFD4AF37).withValues(alpha: 0.4),
                              Colors.transparent
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Plan badge ─────────────────────────────────────────────────────────────────
class _PlanBadge extends StatelessWidget {
  final String planName;
  const _PlanBadge({required this.planName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFD4AF37), Color(0xFFB8860B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD4AF37).withValues(alpha: 0.4),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            planName.toUpperCase(),
            style: TextStyle(
              fontSize: 9.sp,
              fontWeight: FontWeight.w800,
              color: Colors.black,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Avatar with Gold Ring ──────────────────────────────────────────────────────
class _AvatarWithCrown extends StatelessWidget {
  final ProfileEntity profile;
  const _AvatarWithCrown({required this.profile});

  ImageProvider? _resolveImage() {
    final url = profile.photoUrl;
    if (url.isEmpty) return null;
    if (url.startsWith('/')) return FileImage(File(url));
    return NetworkImage(url);
  }

  @override
  Widget build(BuildContext context) {
    final image = _resolveImage();
    return Container(
      width: 58.w,
      height: 58.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFFD4AF37).withValues(alpha: 0.3),
          width: 0.5.w,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD4AF37).withValues(alpha: 0.2),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: EdgeInsets.all(3.w),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Color(0xFFD4AF37), Color(0xFF8B6914)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.all(1.5.w),
        child: CircleAvatar(
          backgroundColor: const Color(0xFF0D0D0D),
          backgroundImage: image,
          child: image == null
              ? Icon(Icons.person_rounded,
                  size: 24.sp, color: const Color(0xFFD4AF37))
              : null,
        ),
      ),
    );
  }
}

// ── Modern Minimalist Chip ─────────────────────────────────────────────────────
class _ModernChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36.w,
      height: 26.h,
      decoration: BoxDecoration(
        color: const Color(0xFFD4AF37).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(6.r),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE6BE8A),
            Color(0xFFD4AF37),
            Color(0xFFB8860B),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _ChipGridPainter(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChipGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    final w = size.width;
    final h = size.height;

    // Subtle technical lines
    canvas.drawLine(Offset(w * 0.3, 0), Offset(w * 0.3, h), paint);
    canvas.drawLine(Offset(w * 0.7, 0), Offset(w * 0.7, h), paint);
    canvas.drawLine(Offset(0, h * 0.5), Offset(w, h * 0.5), paint);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(w / 2, h / 2), width: w * 0.4, height: h * 0.4),
        Radius.circular(2.r),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}

// ── Background painter (lines + sparkles) ─────────────────────────────────────
class _CardBackgroundPainter extends StatelessWidget {
  const _CardBackgroundPainter();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _BgPainter());
  }
}

class _BgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // ── 1. Subtle Brushed Metal Texture ──
    final linePaint = Paint()
      ..color = const Color(0xFFD4AF37).withValues(alpha: 0.04)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    for (double x = -size.height; x < size.width + size.height; x += 12) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x + size.height, size.height),
        linePaint,
      );
    }

    // ── 2. Metallic Sheen Gradients ──
    final sheenPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withValues(alpha: 0.0),
          Colors.white.withValues(alpha: 0.03),
          Colors.white.withValues(alpha: 0.0),
        ],
        stops: const [0.3, 0.5, 0.7],
      ).createShader(Offset.zero & size);

    canvas.drawRect(Offset.zero & size, sheenPaint);

    // ── 3. Premium Noise / Sparkle ──
    final rng = Random(42);
    final dotPaint = Paint()
      ..color = const Color(0xFFD4AF37).withValues(alpha: 0.1);

    for (int i = 0; i < 40; i++) {
      final x = rng.nextDouble() * size.width;
      final y = rng.nextDouble() * size.height;
      final r = 0.3 + rng.nextDouble() * 0.8;
      canvas.drawCircle(Offset(x, y), r, dotPaint);
    }

    // ── 4. Elegant Outline / Border Highlight ──
    final borderPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFD4AF37),
          Colors.transparent,
          Color(0xFF8B6914),
        ],
      ).createShader(Offset.zero & size)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Offset.zero & size,
        Radius.circular(20.r),
      ),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}

