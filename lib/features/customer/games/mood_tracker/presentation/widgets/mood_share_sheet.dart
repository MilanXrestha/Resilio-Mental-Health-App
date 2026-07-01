import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Resilio/core/theme/app_colors.dart';
import 'package:Resilio/features/customer/games/mood_tracker/data/services/mood_share_service.dart';

/// Bottom sheet letting the patient share their mood logs with a booked
/// therapist. Each therapist has a toggle → share / revoke.
class MoodShareSheet extends StatefulWidget {
  const MoodShareSheet({super.key});

  @override
  State<MoodShareSheet> createState() => _MoodShareSheetState();
}

class _MoodShareSheetState extends State<MoodShareSheet> {
  final MoodShareService _service = MoodShareService();
  List<TherapistShareCandidate> _candidates = [];
  bool _loading = true;
  String? _error;
  final Set<String> _busy = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final c = await _service.getCandidates();
      if (!mounted) return;
      setState(() {
        _candidates = c;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _error = 'Could not load your therapists';
        _loading = false;
      });
    }
  }

  Future<void> _toggle(TherapistShareCandidate t, bool value) async {
    setState(() => _busy.add(t.therapistId));
    try {
      if (value) {
        await _service.share(t.therapistId);
      } else {
        await _service.revoke(t.therapistId);
      }
      if (!mounted) return;
      setState(() {
        _candidates = _candidates
            .map((c) => c.therapistId == t.therapistId
                ? TherapistShareCandidate(
                    therapistId: c.therapistId,
                    displayName: c.displayName,
                    photoUrl: c.photoUrl,
                    shared: value,
                  )
                : c)
            .toList();
      });
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something went wrong. Try again.')),
        );
      }
    } finally {
      if (mounted) setState(() => _busy.remove(t.therapistId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: context.textSecondaryColor.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Share mood logs',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: context.textPrimaryColor,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Let a therapist you have booked see your mood history to support your care.',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13.sp,
                color: context.textSecondaryColor,
              ),
            ),
            SizedBox(height: 16.h),
            _buildBody(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_loading) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 32.h),
        child: Center(
          child: CircularProgressIndicator(color: context.primaryColor),
        ),
      );
    }
    if (_error != null) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: Center(
          child: Text(
            _error!,
            style: TextStyle(color: context.textSecondaryColor, fontSize: 14.sp),
          ),
        ),
      );
    }
    if (_candidates.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: Column(
          children: [
            Icon(Icons.medical_services_outlined,
                size: 40.sp, color: context.textSecondaryColor),
            SizedBox(height: 12.h),
            Text(
              'Book a session with a therapist first, then you can share your mood logs with them.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14.sp,
                color: context.textSecondaryColor,
              ),
            ),
          ],
        ),
      );
    }
    return Column(
      children: _candidates.map((t) {
        final busy = _busy.contains(t.therapistId);
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: context.primaryColor.withValues(alpha: 0.15),
                backgroundImage:
                    t.photoUrl.isNotEmpty ? NetworkImage(t.photoUrl) : null,
                child: t.photoUrl.isEmpty
                    ? Icon(Icons.person_rounded,
                        color: context.primaryColor, size: 22.sp)
                    : null,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  t.displayName,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: context.textPrimaryColor,
                  ),
                ),
              ),
              if (busy)
                SizedBox(
                  width: 20.w,
                  height: 20.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.w,
                    color: context.primaryColor,
                  ),
                )
              else
                Switch.adaptive(
                  value: t.shared,
                  activeThumbColor: context.primaryColor,
                  onChanged: (v) => _toggle(t, v),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
