import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../bloc/therapist_cubit.dart';
import '../../bloc/therapist_state.dart';
import '../../../../../../core/routing/route_names.dart';

class TherapistSettingsTab extends StatefulWidget {
  const TherapistSettingsTab({super.key});

  @override
  State<TherapistSettingsTab> createState() => _TherapistSettingsTabState();
}

class _TherapistSettingsTabState extends State<TherapistSettingsTab> {
  final _bioController = TextEditingController();
  final _rateController = TextEditingController();
  final _nameController = TextEditingController();
  String _appVersion = '';
  bool _isSaving = false;

  // Availability
  Map<String, bool> _days = {
    'Monday': true, 'Tuesday': true, 'Wednesday': true,
    'Thursday': true, 'Friday': true, 'Saturday': false, 'Sunday': false,
  };
  final Map<String, TimeOfDay> _startTimes = {};
  final Map<String, TimeOfDay> _endTimes = {};

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((pi) {
      if (mounted) setState(() => _appVersion = pi.version);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TherapistCubit>().loadProfile();
    });
    for (final day in _days.keys) {
      _startTimes[day] = const TimeOfDay(hour: 9, minute: 0);
      _endTimes[day] = const TimeOfDay(hour: 17, minute: 0);
    }
  }

  void _populateFromProfile(Map<String, dynamic> profile) {
    _nameController.text = profile['displayName'] as String? ?? '';
    _bioController.text = profile['bio'] as String? ?? '';
    _rateController.text = (profile['hourlyRate'] as num?)?.toString() ?? '';
    final avail = profile['availabilityJson'] as Map<String, dynamic>? ?? {};
    // Restore saved day toggles
    if (avail['days'] is Map) {
      final savedDays = avail['days'] as Map<String, dynamic>;
      for (final key in _days.keys) {
        if (savedDays.containsKey(key)) {
          _days[key] = savedDays[key] as bool;
        }
      }
    }
  }

  @override
  void dispose() {
    _bioController.dispose();
    _rateController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    setState(() => _isSaving = true);
    try {
      await context.read<TherapistCubit>().updateProfile({
        'displayName': _nameController.text.trim(),
        'bio': _bioController.text.trim(),
        'hourlyRate': double.tryParse(_rateController.text.trim()) ?? 0,
        'availabilityJson': {'days': _days},
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Profile saved!'),
            backgroundColor: context.successColor,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: SafeArea(
        child: BlocConsumer<TherapistCubit, TherapistState>(
          listener: (context, state) {
            if (state is TherapistProfileLoaded) {
              _populateFromProfile(state.profile);
            }
          },
          builder: (context, state) {
            if (state is TherapistLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 100.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Settings', style: TextStyle(fontFamily: 'Poppins', fontSize: 26.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor)),
                  SizedBox(height: 28.h),

                  // ── Profile section ─────────────────────────────────────
                  _SectionHeader(label: 'Profile'),
                  SizedBox(height: 12.h),
                  _TextField(controller: _nameController, label: 'Display Name', icon: Icons.person_outline_rounded),
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: context.surfaceColor,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(color: context.borderColor, width: 0.5),
                    ),
                    child: TextField(
                      controller: _bioController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: 'Bio',
                        labelStyle: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp, color: context.textSecondaryColor),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp, color: context.textPrimaryColor),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  _TextField(controller: _rateController, label: 'Hourly Rate (\$)', icon: Icons.attach_money_rounded, keyboardType: TextInputType.number),
                  SizedBox(height: 24.h),

                  // ── Availability ─────────────────────────────────────────
                  _SectionHeader(label: 'Availability'),
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: context.surfaceColor,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(color: context.borderColor, width: 0.5),
                    ),
                    child: Column(
                      children: _days.keys.map((day) => _DayRow(
                        day: day,
                        enabled: _days[day]!,
                        start: _startTimes[day]!,
                        end: _endTimes[day]!,
                        onToggle: (v) => setState(() => _days[day] = v),
                        onEditStart: () async {
                          final t = await showTimePicker(context: context, initialTime: _startTimes[day]!);
                          if (t != null) setState(() => _startTimes[day] = t);
                        },
                        onEditEnd: () async {
                          final t = await showTimePicker(context: context, initialTime: _endTimes[day]!);
                          if (t != null) setState(() => _endTimes[day] = t);
                        },
                      )).toList(),
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // ── Save button ──────────────────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isSaving ? null : _saveProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.primaryColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
                        elevation: 0,
                        textStyle: TextStyle(fontFamily: 'Poppins', fontSize: 15.sp, fontWeight: FontWeight.w600),
                      ),
                      child: _isSaving
                          ? SizedBox(height: 20.h, width: 20.h, child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Text('Save Changes'),
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // ── App settings ─────────────────────────────────────────
                  _SectionHeader(label: 'App Settings'),
                  SizedBox(height: 12.h),
                  _SettingsTile(
                    icon: Icons.palette_outlined,
                    label: 'Appearance',
                    subtitle: 'Theme & display',
                    onTap: () => context.pushNamed(RouteNames.settings),
                  ),
                  SizedBox(height: 10.h),
                  _SettingsTile(
                    icon: Icons.person_outline_rounded,
                    label: 'Customer Profile',
                    subtitle: 'Manage account',
                    onTap: () => context.pushNamed(RouteNames.profile),
                  ),
                  SizedBox(height: 24.h),

                  // ── About ─────────────────────────────────────────────────
                  _SectionHeader(label: 'About'),
                  SizedBox(height: 12.h),
                  _SettingsTile(
                    icon: Icons.info_outline_rounded,
                    label: 'Resilio Therapist Portal',
                    subtitle: 'Version $_appVersion',
                    onTap: () {},
                  ),
                  SizedBox(height: 10.h),
                  _SettingsTile(
                    icon: Icons.logout_rounded,
                    label: 'Sign Out',
                    subtitle: 'Return to login',
                    iconColor: context.errorColor,
                    onTap: () => context.go('/login'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontFamily: 'Poppins', fontSize: 18.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor)),
        SizedBox(height: 4.h),
        Container(height: 2.h, width: 40.w, decoration: BoxDecoration(color: context.primaryColor, borderRadius: BorderRadius.circular(2.r))),
      ],
    );
  }
}

class _TextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;

  const _TextField({required this.controller, required this.label, required this.icon, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: context.borderColor, width: 0.5),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp, color: context.textSecondaryColor),
          prefixIcon: Icon(icon, color: context.textSecondaryColor, size: 18.sp),
          border: InputBorder.none,
        ),
        style: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp, color: context.textPrimaryColor),
      ),
    );
  }
}

class _DayRow extends StatelessWidget {
  final String day;
  final bool enabled;
  final TimeOfDay start;
  final TimeOfDay end;
  final ValueChanged<bool> onToggle;
  final VoidCallback onEditStart;
  final VoidCallback onEditEnd;

  const _DayRow({
    required this.day,
    required this.enabled,
    required this.start,
    required this.end,
    required this.onToggle,
    required this.onEditStart,
    required this.onEditEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Switch.adaptive(
            value: enabled,
            onChanged: onToggle,
            activeColor: context.primaryColor,
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Text(day, style: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp, fontWeight: FontWeight.w500, color: context.textPrimaryColor)),
          ),
          if (enabled) ...[
            GestureDetector(
              onTap: onEditStart,
              child: _TimeChip(time: start),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text('–', style: TextStyle(color: context.textSecondaryColor)),
            ),
            GestureDetector(
              onTap: onEditEnd,
              child: _TimeChip(time: end),
            ),
          ] else
            Text('Off', style: TextStyle(fontFamily: 'Poppins', fontSize: 12.sp, color: context.textSecondaryColor)),
        ],
      ),
    );
  }
}

class _TimeChip extends StatelessWidget {
  final TimeOfDay time;
  const _TimeChip({required this.time});

  @override
  Widget build(BuildContext context) {
    final formatted = time.format(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: context.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(formatted, style: TextStyle(fontFamily: 'Poppins', fontSize: 11.sp, fontWeight: FontWeight.w600, color: context.primaryColor)),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final Color? iconColor;
  final VoidCallback onTap;

  const _SettingsTile({required this.icon, required this.label, required this.subtitle, this.iconColor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: context.borderColor, width: 0.5),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(9.w),
              decoration: BoxDecoration(
                color: (iconColor ?? context.primaryColor).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, color: iconColor ?? context.primaryColor, size: 18.sp),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp, fontWeight: FontWeight.w600, color: context.textPrimaryColor)),
                  Text(subtitle, style: TextStyle(fontFamily: 'Poppins', fontSize: 12.sp, color: context.textSecondaryColor)),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: context.textSecondaryColor, size: 18.sp),
          ],
        ),
      ),
    );
  }
}
