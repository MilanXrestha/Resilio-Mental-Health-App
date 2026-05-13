import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../l10n/app_localizations.dart';

class TherapistDetailScreen extends StatefulWidget {
  final String therapistId;
  const TherapistDetailScreen({super.key, required this.therapistId});

  @override
  State<TherapistDetailScreen> createState() => _TherapistDetailScreenState();
}

class _TherapistDetailScreenState extends State<TherapistDetailScreen> {
  final _dio = getIt<Dio>();
  Map<String, dynamic>? _therapist;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final res = await _dio.get('/therapists/user/${widget.therapistId}');
      if (mounted) {
        setState(() {
          _therapist = res.data['profile'] as Map<String, dynamic>?;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _therapist == null
              ? _notFound(context)
              : _body(context),
    );
  }

  Widget _notFound(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(AppLocalizations.of(context)!.noTherapistsFound,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16.sp,
                color: context.textSecondaryColor)),
      ),
    );
  }

  Widget _body(BuildContext context) {
    final t = _therapist!;
    final name = t['displayName'] ?? t['display_name'] ?? 'Therapist';
    final specialty = t['specialty'] ?? '';
    final bio = t['bio'] ?? '';
    final rating = (t['rating'] as num?)?.toDouble() ?? 0.0;
    final reviews = t['totalReviews'] ?? t['total_reviews'] ?? 0;
    final fee = t['consultationFee'] ?? t['consultation_fee'] ?? 0;
    final yearsExp =
        t['yearsOfExperience'] ?? t['years_of_experience'] ?? 0;
    final qualifications = (t['qualifications'] as List<dynamic>?)
            ?.cast<String>() ??
        [];
    final pic = t['profileImageUrl'] ?? t['profile_image_url'];
    final isVerified = t['isVerified'] ?? t['is_verified'] ?? false;
    final userId = t['userId'] ?? t['user_id'] ?? widget.therapistId;

    return CustomScrollView(
      physics:
          const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      slivers: [
        // ── Hero App Bar ────────────────────────────────────────────────────
        SliverAppBar(
          expandedHeight: 260.h,
          pinned: true,
          backgroundColor: context.backgroundColor,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                  color: context.surfaceColor.withOpacity(0.9),
                  shape: BoxShape.circle),
              child: Icon(Icons.arrow_back_ios_new_rounded,
                  size: 16.sp, color: context.textPrimaryColor),
            ),
            onPressed: () => context.pop(),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        context.primaryColor,
                        context.primaryColor.withOpacity(0.6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                // Pattern overlay
                Opacity(
                  opacity: 0.06,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 8),
                    itemBuilder: (_, __) => const Icon(Icons.circle,
                        size: 4, color: Colors.white),
                  ),
                ),
                // Content
                Positioned(
                  bottom: 24.h,
                  left: 20.w,
                  right: 20.w,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.white.withOpacity(0.4),
                              width: 3),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 16)
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 40.r,
                          backgroundImage:
                              pic != null ? NetworkImage(pic) : null,
                          backgroundColor: Colors.white.withOpacity(0.2),
                          child: pic == null
                              ? Text(
                                  name.isNotEmpty
                                      ? name[0].toUpperCase()
                                      : 'T',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                )
                              : null,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Dr. $name',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                if (isVerified == true) ...[
                                  SizedBox(width: 6.w),
                                  Icon(Icons.verified_rounded,
                                      size: 18.sp, color: Colors.white),
                                ],
                              ],
                            ),
                            if (specialty.isNotEmpty) ...[
                              SizedBox(height: 4.h),
                              Text(
                                specialty,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 13.sp,
                                    color: Colors.white70),
                              ),
                            ],
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                Icon(Icons.star_rounded,
                                    size: 14.sp,
                                    color: const Color(0xFFFBBF24)),
                                SizedBox(width: 3.w),
                                Text(
                                  rating.toStringAsFixed(1),
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  AppLocalizations.of(context)!.reviewsCount(reviews),
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 11.sp,
                                      color: Colors.white70),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // ── Body ─────────────────────────────────────────────────────────────
        SliverPadding(
          padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 120.h),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Stats row
              Row(
                children: [
                  _StatChip(Icons.work_outline_rounded,
                      '$yearsExp yrs', AppLocalizations.of(context)!.experience),
                  SizedBox(width: 12.w),
                  _StatChip(Icons.payments_outlined,
                      'NPR ${(fee as num).toStringAsFixed(0)}', AppLocalizations.of(context)!.perSession),
                  SizedBox(width: 12.w),
                  _StatChip(Icons.people_outline_rounded,
                      reviews.toString(), AppLocalizations.of(context)!.reviews),
                ],
              ),
              SizedBox(height: 24.h),

              // About
              if (bio.isNotEmpty) ...[
                _SectionTitle(AppLocalizations.of(context)!.about),
                SizedBox(height: 10.h),
                Text(
                  bio,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.sp,
                      color: context.textSecondaryColor,
                      height: 1.6),
                ),
                SizedBox(height: 24.h),
              ],

              // Qualifications
              if (qualifications.isNotEmpty) ...[
                _SectionTitle(AppLocalizations.of(context)!.qualifications),
                SizedBox(height: 10.h),
                ...qualifications.map((q) => Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Row(
                        children: [
                          Icon(Icons.school_outlined,
                              size: 16.sp,
                              color: context.primaryColor),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Text(q,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 13.sp,
                                    color: context.textPrimaryColor)),
                          ),
                        ],
                      ),
                    )),
                SizedBox(height: 24.h),
              ],

              // Session Info
              _SectionTitle(AppLocalizations.of(context)!.sessionInfo),
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: context.surfaceColor,
                  borderRadius: BorderRadius.circular(16.r),
                  border:
                      Border.all(color: context.borderColor, width: 0.5),
                ),
                child: Column(
                  children: [
                    _InfoRow(context, Icons.video_call_rounded,
                        AppLocalizations.of(context)!.sessionType, AppLocalizations.of(context)!.videoCallWebRTC),
                    SizedBox(height: 12.h),
                    _InfoRow(context, Icons.timer_outlined, AppLocalizations.of(context)!.duration,
                        AppLocalizations.of(context)!.sessionDuration),
                    SizedBox(height: 12.h),
                    _InfoRow(context, Icons.payments_rounded, AppLocalizations.of(context)!.fee,
                        AppLocalizations.of(context)!.feeViaEsewa((fee as num).toStringAsFixed(0))),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

// ── Fixed Book Button ──────────────────────────────────────────────────────────
class TherapistDetailScreenWrapper extends StatelessWidget {
  final String therapistId;
  const TherapistDetailScreenWrapper({super.key, required this.therapistId});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TherapistDetailScreen(therapistId: therapistId),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w,
                MediaQuery.of(context).padding.bottom + 16.h),
            decoration: BoxDecoration(
              color: context.backgroundColor,
              border: Border(
                  top: BorderSide(color: context.borderColor, width: 0.5)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 20,
                    offset: const Offset(0, -4))
              ],
            ),
            child: ElevatedButton(
              onPressed: () =>
                  context.push('/booking/$therapistId'),
              style: ElevatedButton.styleFrom(
                backgroundColor: context.primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r)),
                elevation: 0,
                textStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700),
              ),
              child: Text(AppLocalizations.of(context)!.bookSession),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Helper Widgets ─────────────────────────────────────────────────────────────
class _StatChip extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  const _StatChip(this.icon, this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: context.primaryColor.withOpacity(0.06),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
              color: context.primaryColor.withOpacity(0.15), width: 0.5),
        ),
        child: Column(
          children: [
            Icon(icon, color: context.primaryColor, size: 20.sp),
            SizedBox(height: 6.h),
            Text(value,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: context.textPrimaryColor)),
            Text(label,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10.sp,
                    color: context.textSecondaryColor),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 17.sp,
        fontWeight: FontWeight.w700,
        color: context.textPrimaryColor,
      ),
    );
  }
}

Widget _InfoRow(
    BuildContext context, IconData icon, String label, String value) {
  return Row(
    children: [
      Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: context.primaryColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(icon, color: context.primaryColor, size: 16.sp),
      ),
      SizedBox(width: 12.w),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11.sp,
                    color: context.textSecondaryColor)),
            Text(value,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: context.textPrimaryColor)),
          ],
        ),
      ),
    ],
  );
}
