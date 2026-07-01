import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:Resilio/core/di/injection.dart';
import 'package:Resilio/core/theme/app_colors.dart';
import 'package:Resilio/features/therapist/patients/data/datasources/remote/patients_remote_datasource.dart';

/// Therapist view of a patient's shared mood logs. Backend gates access on a
/// mood_shares consent row; if absent, shows a "not shared" state.
class PatientMoodsScreen extends StatefulWidget {
  final String patientId;
  final String patientName;

  const PatientMoodsScreen({
    super.key,
    required this.patientId,
    required this.patientName,
  });

  @override
  State<PatientMoodsScreen> createState() => _PatientMoodsScreenState();
}

class _PatientMoodsScreenState extends State<PatientMoodsScreen> {
  final PatientsRemoteDataSource _ds = getIt<PatientsRemoteDataSource>();
  List<Map<String, dynamic>> _moods = [];
  bool _loading = true;
  bool _notShared = false;
  String? _error;

  static const _emojis = {
    5: '😄',
    4: '😊',
    3: '😐',
    2: '😔',
    1: '😡',
  };

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final m = await _ds.getPatientMoods(widget.patientId);
      if (!mounted) return;
      setState(() {
        _moods = m;
        _loading = false;
      });
    } on MoodNotSharedException {
      if (!mounted) return;
      setState(() {
        _notShared = true;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _error = 'Could not load mood logs';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          '${widget.patientName} · Moods',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: context.textPrimaryColor,
          ),
        ),
        iconTheme: IconThemeData(color: context.textPrimaryColor),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_loading) {
      return Center(child: CircularProgressIndicator(color: context.primaryColor));
    }
    if (_notShared) {
      return _stateMessage(
        context,
        icon: Icons.lock_outline_rounded,
        text: 'This patient has not shared their mood logs with you.',
      );
    }
    if (_error != null) {
      return _stateMessage(context, icon: Icons.error_outline_rounded, text: _error!);
    }
    if (_moods.isEmpty) {
      return _stateMessage(
        context,
        icon: Icons.sentiment_satisfied_rounded,
        text: 'No mood entries yet.',
      );
    }
    return ListView.separated(
      padding: EdgeInsets.all(16.w),
      itemCount: _moods.length,
      separatorBuilder: (_, _) => SizedBox(height: 10.h),
      itemBuilder: (context, i) {
        final m = _moods[i];
        final score = (m['mood_score'] as num?)?.toInt() ?? 3;
        final label = m['mood_label'] as String? ?? '';
        final note = m['note'] as String? ?? '';
        final dateStr = m['entry_date'] as String? ?? m['created_at'] as String? ?? '';
        final date = DateTime.tryParse(dateStr);
        return Container(
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: context.surfaceColor,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: context.borderColor.withValues(alpha: 0.3)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_emojis[score] ?? '😐', style: TextStyle(fontSize: 30.sp)),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          label.isNotEmpty ? label : 'Mood $score/5',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: context.textPrimaryColor,
                          ),
                        ),
                        if (date != null)
                          Text(
                            DateFormat('MMM d').format(date),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12.sp,
                              color: context.textSecondaryColor,
                            ),
                          ),
                      ],
                    ),
                    if (note.isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Text(
                        note,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13.sp,
                          color: context.textSecondaryColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _stateMessage(BuildContext context,
      {required IconData icon, required String text}) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48.sp, color: context.textSecondaryColor),
            SizedBox(height: 16.h),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14.sp,
                color: context.textSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
