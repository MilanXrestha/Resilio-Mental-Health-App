import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:intl/intl.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/routing/route_names.dart';
import '../../../../../core/theme/app_colors.dart';
import 'package:Resilio/l10n/app_localizations.dart';

// Same credentials as subscription screen (working)
const _esewaClientId = 'JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R';
const _esewaSecretId = 'BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==';

class SessionBookingScreen extends StatefulWidget {
  final String therapistId;
  const SessionBookingScreen({super.key, required this.therapistId});

  @override
  State<SessionBookingScreen> createState() => _SessionBookingScreenState();
}

class _SessionBookingScreenState extends State<SessionBookingScreen> {
  final _dio = getIt<Dio>();

  Map<String, dynamic>? _therapist;
  bool _loadingTherapist = true;

  late final List<DateTime> _slots;
  DateTime? _selectedDate;
  int? _selectedSlot;

  /// UTC-normalised hours of already-booked active appointments.
  /// A slot is booked if its UTC hour matches any entry here.
  final Set<String> _bookedSlotKeys = {};

  bool _bookingInProgress = false;
  String? _error;

  // All unique dates across slots
  List<DateTime> get _dates {
    final seen = <String>{};
    return _slots
        .map((s) => DateTime(s.year, s.month, s.day))
        .where((d) => seen.add(DateFormat('yyyy-MM-dd').format(d)))
        .toList();
  }

  List<DateTime> get _slotsForDate {
    if (_selectedDate == null) return [];
    return _slots.where((s) =>
        s.year == _selectedDate!.year &&
        s.month == _selectedDate!.month &&
        s.day == _selectedDate!.day).toList();
  }

  @override
  void initState() {
    super.initState();
    _slots = _generateSlots();
    _selectedDate = _dates.isNotEmpty ? _dates.first : null;
    _loadTherapist();
    _loadBookedSlots();
  }

  /// Fetch the user's existing appointments and mark those time slots as taken.
  Future<void> _loadBookedSlots() async {
    try {
      final res = await _dio.get('/appointments');
      final raw = res.data;
      final rawList = (raw is Map
          ? (raw['appointments'] ?? raw['data'] ?? raw['items'] ?? [])
          : raw is List
              ? raw
              : []) as List<dynamic>;

      final keys = <String>{};
      for (final item in rawList) {
        final appt = item as Map<String, dynamic>;
        final status = (appt['status'] as String? ?? '').toLowerCase();
        // Only block slots for active / pending appointments
        if (status == 'cancelled' || status == 'rejected' || status == 'completed') {
          continue;
        }
        final dateStr = appt['scheduledTime'] as String? ??
            appt['scheduled_time'] as String? ??
            appt['scheduled_at'] as String?;
        if (dateStr == null) continue;
        final dt = DateTime.tryParse(dateStr);
        if (dt != null) keys.add(_slotKey(dt.toLocal()));
      }

      if (mounted && keys.isNotEmpty) {
        setState(() => _bookedSlotKeys.addAll(keys));
      }
    } catch (_) {
      // Non-critical — silently ignore; user can still book
    }
  }

  /// Canonical key for a slot: "yyyy-MM-dd HH" in local time.
  String _slotKey(DateTime dt) =>
      '${dt.year.toString().padLeft(4, '0')}-'
      '${dt.month.toString().padLeft(2, '0')}-'
      '${dt.day.toString().padLeft(2, '0')} '
      '${dt.hour.toString().padLeft(2, '0')}';

  bool _isBooked(DateTime slot) => _bookedSlotKeys.contains(_slotKey(slot));

  List<DateTime> _generateSlots() {
    final now = DateTime.now();
    final slots = <DateTime>[];
    for (int day = 0; day < 7; day++) {
      final base = now.add(Duration(days: day));
      for (final hour in [9, 10, 11, 13, 14, 15, 16]) {
        final slot = DateTime(base.year, base.month, base.day, hour);
        if (slot.isAfter(now.add(const Duration(hours: 2)))) {
          slots.add(slot);
        }
      }
    }
    return slots.take(28).toList();
  }

  Future<void> _loadTherapist() async {
    try {
      final res = await _dio.get('/therapists/${widget.therapistId}');
      if (mounted) {
        setState(() {
          _therapist = res.data['profile'] as Map<String, dynamic>?;
          _loadingTherapist = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _loadingTherapist = false);
    }
  }

  double get _sessionFee {
    if (_therapist == null) return 1500;
    final fee = _therapist!['consultationFee'] ??
        _therapist!['hourlyRate'] ??
        _therapist!['consultation_fee'] ??
        1500;
    return (fee as num).toDouble();
  }

  void _pay() {
    if (_selectedSlot == null) return;
    setState(() {
      _bookingInProgress = true;
      _error = null;
    });

    final productId = 'appt_${widget.therapistId}_${DateTime.now().millisecondsSinceEpoch}';

    try {
      EsewaFlutterSdk.initPayment(
        esewaConfig: EsewaConfig(
          environment: Environment.test,
          clientId: _esewaClientId,
          secretId: _esewaSecretId,
        ),
        esewaPayment: EsewaPayment(
          productId: productId,
          productName: AppLocalizations.of(context)!.bookSession,
          productPrice: _sessionFee.toStringAsFixed(0),
          callbackUrl: '',
        ),
        onPaymentSuccess: (EsewaPaymentSuccessResult result) {
          // Payment confirmed → NOW create the appointment
          _createAppointmentAfterPayment(result);
        },
        onPaymentFailure: (_) {
          if (mounted) {
            setState(() {
              _error = AppLocalizations.of(context)!.paymentFailed;
              _bookingInProgress = false;
            });
          }
        },
        onPaymentCancellation: (_) {
          if (mounted) setState(() => _bookingInProgress = false);
        },
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _bookingInProgress = false;
        });
      }
    }
  }

  Future<void> _createAppointmentAfterPayment(EsewaPaymentSuccessResult result) async {
    try {
      final apptRes = await _dio.post('/appointments', data: {
        'therapist_id': widget.therapistId,
        'scheduled_time': _slots[_selectedSlot!].toUtc().toIso8601String(),
        'payment_ref': result.refId,
        'payment_amount': double.tryParse(result.totalAmount) ?? _sessionFee,
      });

      final apptId = (apptRes.data['appointment'] as Map<String, dynamic>?)?['id'] as String? ?? '';

      if (mounted) {
        setState(() => _bookingInProgress = false);
        _showSuccessDialog(apptId);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = AppLocalizations.of(context)!.paymentSuccessBookingFailed(result.refId);
          _bookingInProgress = false;
        });
      }
    }
  }

  void _showSuccessDialog(String appointmentId) {
    final slot = _slots[_selectedSlot!];
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        backgroundColor: context.surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
        child: Padding(
          padding: EdgeInsets.all(28.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: context.successColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check_circle_rounded,
                    color: context.successColor, size: 52.sp),
              ),
              SizedBox(height: 20.h),
              Text(
                AppLocalizations.of(context)!.sessionBooked,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: context.textPrimaryColor),
              ),
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: context.primaryColor.withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    _ConfirmRow(
                      icon: Icons.calendar_today_rounded,
                      label: DateFormat('EEE, MMM d yyyy').format(slot),
                    ),
                    SizedBox(height: 8.h),
                    _ConfirmRow(
                      icon: Icons.access_time_rounded,
                      label: DateFormat('h:mm a').format(slot),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14.h),
              Text(
                AppLocalizations.of(context)!.sessionBookedDesc,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12.sp,
                    color: context.textSecondaryColor,
                    height: 1.5),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    // Go to home, clearing the questionnaire → therapist list →
                    // therapist detail → booking stack so user doesn't have to
                    // press back multiple times.
                    context.goNamed(RouteNames.home);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.primaryColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                    elevation: 0,
                    textStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  child: Text(AppLocalizations.of(context)!.done),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedSlotDt = _selectedSlot != null ? _slots[_selectedSlot!] : null;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: _loadingTherapist
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    // ── Header ────────────────────────────────────────────
                    SliverAppBar(
                      backgroundColor: context.backgroundColor,
                      surfaceTintColor: Colors.transparent,
                      elevation: 0,
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back_ios_new_rounded,
                            size: 20.sp, color: context.textPrimaryColor),
                        onPressed: () => context.pop(),
                      ),
                      title: Text(
                        AppLocalizations.of(context)!.bookSession,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: context.textPrimaryColor),
                      ),
                      pinned: true,
                    ),

                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 160.h),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          // ── Therapist card ──────────────────────────────
                          _TherapistBanner(therapist: _therapist),
                          SizedBox(height: 28.h),

                          // ── Session info row ─────────────────────────────
                          Row(
                            children: [
                              _InfoChip(icon: Icons.timer_outlined, label: AppLocalizations.of(context)!.sessionDuration),
                              SizedBox(width: 10.w),
                              _InfoChip(icon: Icons.videocam_outlined, label: AppLocalizations.of(context)!.videoCall),
                              SizedBox(width: 10.w),
                              _InfoChip(
                                icon: Icons.currency_rupee_rounded,
                                label: 'NPR ${_sessionFee.toStringAsFixed(0)}',
                                highlight: true,
                              ),
                            ],
                          ),
                          SizedBox(height: 28.h),

                          // ── Date selector ────────────────────────────────
                          Text(
                            AppLocalizations.of(context)!.selectDate,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: context.textPrimaryColor),
                          ),
                          SizedBox(height: 12.h),
                          SizedBox(
                            height: 72.h,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: _dates.length,
                              separatorBuilder: (_, __) => SizedBox(width: 10.w),
                              itemBuilder: (context, i) {
                                final d = _dates[i];
                                final isSelected = _selectedDate != null &&
                                    d.day == _selectedDate!.day &&
                                    d.month == _selectedDate!.month;
                                return GestureDetector(
                                  onTap: () => setState(() {
                                    _selectedDate = d;
                                    _selectedSlot = null;
                                  }),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 180),
                                    width: 52.w,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? context.primaryColor
                                          : context.surfaceColor,
                                      borderRadius: BorderRadius.circular(14.r),
                                      border: Border.all(
                                        color: isSelected
                                            ? context.primaryColor
                                            : context.borderColor,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          DateFormat('EEE').format(d).toUpperCase(),
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w600,
                                              color: isSelected
                                                  ? Colors.white.withValues(alpha: 0.8)
                                                  : context.textSecondaryColor),
                                        ),
                                        SizedBox(height: 2.h),
                                        Text(
                                          DateFormat('d').format(d),
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w700,
                                              color: isSelected
                                                  ? Colors.white
                                                  : context.textPrimaryColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 24.h),

                          // ── Time slot selector ───────────────────────────
                          Text(
                            AppLocalizations.of(context)!.selectTime,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: context.textPrimaryColor),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            AppLocalizations.of(context)!.allTimesLocal,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.sp,
                                color: context.textSecondaryColor),
                          ),
                          SizedBox(height: 12.h),
                          Wrap(
                            spacing: 10.w,
                            runSpacing: 10.h,
                            children: _slotsForDate.map((slot) {
                              final globalIdx = _slots.indexOf(slot);
                              final isSelected = _selectedSlot == globalIdx;
                              final isBooked = _isBooked(slot);
                              return GestureDetector(
                                onTap: isBooked
                                    ? null
                                    : () => setState(
                                        () => _selectedSlot = globalIdx),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 160),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 18.w, vertical: 11.h),
                                  decoration: BoxDecoration(
                                    color: isBooked
                                        ? context.borderColor
                                        : isSelected
                                            ? context.primaryColor
                                            : context.surfaceColor,
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                      color: isBooked
                                          ? context.borderColor
                                          : isSelected
                                              ? context.primaryColor
                                              : context.borderColor,
                                      width: isSelected ? 1.5 : 0.8,
                                    ),
                                    boxShadow: isSelected
                                        ? [
                                            BoxShadow(
                                              color: context.primaryColor
                                                  .withValues(alpha: 0.25),
                                              blurRadius: 8,
                                              offset: const Offset(0, 3),
                                            )
                                          ]
                                        : [],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        DateFormat('h:mm a').format(slot),
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600,
                                          color: isBooked
                                              ? context.textSecondaryColor
                                                  .withValues(alpha: 0.45)
                                              : isSelected
                                                  ? Colors.white
                                                  : context.textPrimaryColor,
                                          decoration: isBooked
                                              ? TextDecoration.lineThrough
                                              : null,
                                          decorationColor: context
                                              .textSecondaryColor
                                              .withValues(alpha: 0.45),
                                        ),
                                      ),
                                      if (isBooked) ...[
                                        SizedBox(height: 2.h),
                                        Text(
                                          AppLocalizations.of(context)!.statusBooked,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 9.sp,
                                            color: context.textSecondaryColor
                                                .withValues(alpha: 0.5),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                          // ── Error ─────────────────────────────────────────
                          if (_error != null) ...[
                            SizedBox(height: 20.h),
                            Container(
                              padding: EdgeInsets.all(14.w),
                              decoration: BoxDecoration(
                                color: context.errorColor.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                    color: context.errorColor.withValues(alpha: 0.3)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.error_outline_rounded,
                                      color: context.errorColor, size: 18.sp),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Text(_error!,
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 13.sp,
                                            color: context.errorColor,
                                            height: 1.4)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ]),
                      ),
                    ),
                  ],
                ),

                // ── Sticky bottom bar ──────────────────────────────────────
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w,
                        MediaQuery.of(context).padding.bottom + 16.h),
                    decoration: BoxDecoration(
                      color: context.surfaceColor,
                      border: Border(
                          top: BorderSide(color: context.borderColor, width: 0.5)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 20,
                          offset: const Offset(0, -4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (selectedSlotDt != null) ...[
                          Row(
                            children: [
                              Icon(Icons.event_available_rounded,
                                  color: context.primaryColor, size: 16.sp),
                              SizedBox(width: 8.w),
                              Text(
                                '${DateFormat('EEE, MMM d').format(selectedSlotDt)}  •  ${DateFormat('h:mm a').format(selectedSlotDt)}',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    color: context.textPrimaryColor),
                              ),
                              const Spacer(),
                              Text(
                                'NPR ${_sessionFee.toStringAsFixed(0)}',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700,
                                    color: context.primaryColor),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                        ],
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: (_selectedSlot != null && !_bookingInProgress)
                                ? _pay
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF60BB46),
                              foregroundColor: Colors.white,
                              disabledBackgroundColor:
                                  context.borderColor,
                              padding: EdgeInsets.symmetric(vertical: 15.h),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.r)),
                              elevation: 0,
                            ),
                            child: _bookingInProgress
                                ? SizedBox(
                                    height: 20.h,
                                    width: 20.h,
                                    child: const CircularProgressIndicator(
                                        color: Colors.white, strokeWidth: 2),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/esewa_logo.png',
                                        height: 20.h,
                                        errorBuilder: (_, __, ___) => Icon(
                                            Icons.payment_rounded,
                                            color: Colors.white,
                                            size: 20.sp),
                                      ),
                                      SizedBox(width: 10.w),
                                      Text(
                                        _selectedSlot != null
                                            ? AppLocalizations.of(context)!.payWithEsewa(_sessionFee.toStringAsFixed(0))
                                            : AppLocalizations.of(context)!.selectTimeSlot,
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
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

// ── Widgets ────────────────────────────────────────────────────────────────────

class _TherapistBanner extends StatelessWidget {
  final Map<String, dynamic>? therapist;
  const _TherapistBanner({required this.therapist});

  @override
  Widget build(BuildContext context) {
    final name = therapist?['displayName'] ?? therapist?['display_name'] ?? 'Therapist';
    final specialty = therapist?['specialty'] ?? '';
    final rating = (therapist?['rating'] as num?)?.toDouble() ?? 0.0;
    final reviews = therapist?['totalReviews'] ?? therapist?['total_reviews'] ?? 0;
    final exp = therapist?['yearsOfExperience'] ?? therapist?['years_of_experience'] ?? 0;
    final pic = therapist?['profileImageUrl'] ?? therapist?['profile_image_url'];
    final isVerified = therapist?['isVerified'] ?? therapist?['is_verified'] ?? false;

    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.primaryColor.withValues(alpha: 0.08),
            context.primaryColor.withValues(alpha: 0.03),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: context.primaryColor.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 36.r,
                backgroundImage: pic != null ? NetworkImage(pic) : null,
                backgroundColor: context.primaryColor.withValues(alpha: 0.15),
                child: pic == null
                    ? Text(
                        name.isNotEmpty ? name[0].toUpperCase() : 'T',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            color: context.primaryColor),
                      )
                    : null,
              ),
              if (isVerified == true)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                        color: context.surfaceColor, shape: BoxShape.circle),
                    child: Icon(Icons.verified_rounded,
                        size: 18.sp, color: const Color(0xFF6366F1)),
                  ),
                ),
            ],
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dr. $name',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                      color: context.textPrimaryColor),
                ),
                if (specialty.isNotEmpty) ...[
                  SizedBox(height: 2.h),
                  Text(
                    specialty,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.sp,
                        color: context.primaryColor,
                        fontWeight: FontWeight.w500),
                  ),
                ],
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(Icons.star_rounded,
                        color: const Color(0xFFF59E0B), size: 14.sp),
                    SizedBox(width: 3.w),
                    Text(
                      rating.toStringAsFixed(1),
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: context.textPrimaryColor),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '($reviews)',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11.sp,
                          color: context.textSecondaryColor),
                    ),
                    SizedBox(width: 12.w),
                    Icon(Icons.work_outline_rounded,
                        size: 12.sp, color: context.textSecondaryColor),
                    SizedBox(width: 3.w),
                    Text(
                      '$exp yrs exp',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11.sp,
                          color: context.textSecondaryColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool highlight;

  const _InfoChip(
      {required this.icon, required this.label, this.highlight = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: highlight
            ? context.primaryColor.withValues(alpha: 0.1)
            : context.surfaceColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: highlight
              ? context.primaryColor.withValues(alpha: 0.3)
              : context.borderColor,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              size: 13.sp,
              color: highlight ? context.primaryColor : context.textSecondaryColor),
          SizedBox(width: 5.w),
          Text(
            label,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: highlight ? context.primaryColor : context.textSecondaryColor),
          ),
        ],
      ),
    );
  }
}

class _ConfirmRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ConfirmRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 15.sp, color: context.primaryColor),
        SizedBox(width: 10.w),
        Text(
          label,
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: context.textPrimaryColor),
        ),
      ],
    );
  }
}
