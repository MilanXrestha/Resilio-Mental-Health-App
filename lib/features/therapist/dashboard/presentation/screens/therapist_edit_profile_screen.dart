import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/di/injection.dart';
import '../../../../../../core/services/cloudinary_service.dart';
import '../bloc/therapist_cubit.dart';
import '../bloc/therapist_state.dart';

class TherapistEditProfileScreen extends StatefulWidget {
  const TherapistEditProfileScreen({super.key});

  @override
  State<TherapistEditProfileScreen> createState() =>
      _TherapistEditProfileScreenState();
}

class _TherapistEditProfileScreenState
    extends State<TherapistEditProfileScreen> {
  final _nameController = TextEditingController();
  final _specialtyController = TextEditingController();
  final _qualificationsController = TextEditingController();
  final _experienceController = TextEditingController();
  final _bioController = TextEditingController();
  final _rateController = TextEditingController();
  bool _isSaving = false;
  bool _isUploadingAvatar = false;
  String? _avatarUrl;
  
  List<String> _selectedLanguages = [];
  final List<String> _availableLanguages = ['English', 'Nepali', 'Hindi', 'Spanish', 'French'];

  Map<String, bool> _days = {
    'Monday': true,
    'Tuesday': true,
    'Wednesday': true,
    'Thursday': true,
    'Friday': true,
    'Saturday': false,
    'Sunday': false,
  };
  final Map<String, TimeOfDay> _startTimes = {};
  final Map<String, TimeOfDay> _endTimes = {};

  @override
  void initState() {
    super.initState();
    for (final day in _days.keys) {
      _startTimes[day] = const TimeOfDay(hour: 9, minute: 0);
      _endTimes[day] = const TimeOfDay(hour: 17, minute: 0);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TherapistCubit>().loadProfile();
    });
  }

  void _populateFromProfile(Map<String, dynamic> profile) {
    _nameController.text = profile['displayName'] as String? ?? '';
    _bioController.text = profile['bio'] as String? ?? '';
    _rateController.text =
        (profile['consultationFee'] as num?)?.toString() ?? '';
    _specialtyController.text = profile['specialty'] as String? ?? '';
    _experienceController.text =
        (profile['yearsOfExperience'] as num?)?.toString() ?? '';

    final quals = profile['qualifications'];
    if (quals is List) {
      _qualificationsController.text = quals.join(', ');
    } else if (quals is String) {
      _qualificationsController.text = quals;
    } else {
      _qualificationsController.text = '';
    }

    final avail = profile['availabilityJson'] as Map<String, dynamic>? ?? {};
    if (avail['days'] is Map) {
      final savedDays = avail['days'] as Map<String, dynamic>;
      for (final key in _days.keys) {
        if (savedDays.containsKey(key)) {
          _days[key] = savedDays[key] as bool;
        }
      }
    }
    
    final langs = profile['languages'];
    if (langs is List) {
      _selectedLanguages = langs.map((e) => e.toString()).toList();
    }
    
    _avatarUrl = profile['profilePictureUrl'] as String?;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _specialtyController.dispose();
    _qualificationsController.dispose();
    _experienceController.dispose();
    _bioController.dispose();
    _rateController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    setState(() => _isSaving = true);
    try {
      final qualsList = _qualificationsController.text
          .split(',')
          .map((q) => q.trim())
          .where((q) => q.isNotEmpty)
          .toList();

      await context.read<TherapistCubit>().updateProfile({
        'displayName': _nameController.text.trim(),
        'bio': _bioController.text.trim(),
        'specialty': _specialtyController.text.trim(),
        'consultationFee': double.tryParse(_rateController.text.trim()) ?? 0,
        'yearsOfExperience':
            int.tryParse(_experienceController.text.trim()) ?? 0,
        'qualifications': qualsList,
        'languages': _selectedLanguages,
        'availabilityJson': {'days': _days},
        if (_avatarUrl != null) 'profilePictureUrl': _avatarUrl,
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Profile updated successfully!'),
            backgroundColor: context.successColor,
            behavior: SnackBarBehavior.floating,
          ),
        );
        context.pop();
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _pickAndUploadAvatar() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    setState(() => _isUploadingAvatar = true);
    try {
      final uploader = getIt<CloudinaryService>();
      final url = await uploader.uploadProfileImage(File(pickedFile.path), 'therapist_${DateTime.now().millisecondsSinceEpoch}');
      setState(() => _avatarUrl = url);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Avatar updated successfully')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload failed: $e')));
      }
    } finally {
      if (mounted) setState(() => _isUploadingAvatar = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.backgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, size: 20.sp),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: context.textPrimaryColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _isSaving ? null : _saveProfile,
            child: _isSaving
                ? SizedBox(
                    height: 16.h,
                    width: 16.h,
                    child: const CircularProgressIndicator(
                      color: Color(0xFF6366F1),
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    'Save',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF6366F1),
                    ),
                  ),
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: BlocConsumer<TherapistCubit, TherapistState>(
        listener: (context, state) {
          if (state.hasProfile) {
            _populateFromProfile(state.profile!);
          }
        },
        builder: (context, state) {
          if (state.isLoading && !state.hasProfile) {
            return const Center(child: CircularProgressIndicator());
          }

          final profilePicUrl = state.hasProfile
              ? (state.profile!['profilePictureUrl'] as String?)
              : null;
          final isVerified =
              state.hasProfile &&
              (state.profile!['isVerified'] as bool? ?? false);

          final displayAvatar = _avatarUrl ?? profilePicUrl;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 40.h),
            child: Column(
              children: [
                // Avatar Section
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: context.primaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 56.r,
                          backgroundColor: context.primaryColor.withOpacity(0.05),
                          backgroundImage:
                              displayAvatar != null && displayAvatar.isNotEmpty
                              ? NetworkImage(displayAvatar)
                              : null,
                          child: displayAvatar == null || displayAvatar.isEmpty && !_isUploadingAvatar
                              ? Icon(Icons.person_rounded, size: 56.sp, color: context.primaryColor)
                              : _isUploadingAvatar
                                  ? const CircularProgressIndicator()
                                  : null,
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: _pickAndUploadAvatar,
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: context.primaryColor,
                              shape: BoxShape.circle,
                              border: Border.all(color: context.backgroundColor, width: 3),
                            ),
                            child: Icon(Icons.camera_alt_rounded, size: 20.sp, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),

                // Verification Badge
                if (isVerified)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.verified_rounded,
                          color: const Color(0xFF10B981),
                          size: 14.sp,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'Verified Therapist',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF10B981),
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 28.h),

                // Personal Information
                _buildSectionTitle('Personal Information'),
                SizedBox(height: 12.h),
                _ModernTextField(
                  controller: _nameController,
                  label: 'Full Name',
                  icon: Icons.person_outline_rounded,
                ),
                SizedBox(height: 12.h),
                _ModernTextField(
                  controller: _rateController,
                  label: 'Consultation Fee',
                  icon: Icons.attach_money_rounded,
                  keyboardType: TextInputType.number,
                  prefix: 'Rs.',
                ),
                SizedBox(height: 24.h),

                // Professional Details
                _buildSectionTitle('Professional Details'),
                SizedBox(height: 12.h),
                _ModernTextField(
                  controller: _specialtyController,
                  label: 'Specialty',
                  icon: Icons.psychology_outlined,
                  hint: 'e.g., Anxiety, Depression, Trauma',
                ),
                SizedBox(height: 12.h),
                _ModernTextField(
                  controller: _qualificationsController,
                  label: 'Qualifications',
                  icon: Icons.school_outlined,
                  hint: 'e.g., PhD Psychology, LMFT',
                ),
                SizedBox(height: 12.h),
                _buildSectionTitle('Spoken Languages'),
                SizedBox(height: 8.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: _availableLanguages.map((lang) {
                    final isSelected = _selectedLanguages.contains(lang);
                    return FilterChip(
                      label: Text(lang, style: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp, color: isSelected ? Colors.white : context.textPrimaryColor)),
                      selected: isSelected,
                      selectedColor: context.primaryColor,
                      backgroundColor: context.surfaceColor,
                      checkmarkColor: Colors.white,
                      onSelected: (val) {
                        setState(() {
                          if (val) _selectedLanguages.add(lang);
                          else _selectedLanguages.remove(lang);
                        });
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 12.h),
                _ModernTextField(
                  controller: _experienceController,
                  label: 'Years of Experience',
                  icon: Icons.work_outline_rounded,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 12.h),
                _ModernTextArea(
                  controller: _bioController,
                  label: 'About Me',
                  hint: 'Tell patients about your approach...',
                ),
                SizedBox(height: 24.h),

                // Working Hours
                _buildSectionTitle('Working Hours'),
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: context.surfaceColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    children: _days.entries.map((entry) {
                      final day = entry.key;
                      final isActive = entry.value;
                      return _buildDayRow(day, isActive);
                    }).toList(),
                  ),
                ),
                SizedBox(height: 24.h),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isSaving ? null : _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: _isSaving
                        ? SizedBox(
                            height: 20.h,
                            width: 20.h,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Save Changes',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: context.textPrimaryColor,
        ),
      ),
    );
  }

  Widget _buildDayRow(String day, bool isActive) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          SizedBox(
            width: 80.w,
            child: Text(
              day.substring(0, 3),
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: context.textPrimaryColor,
              ),
            ),
          ),
          Switch.adaptive(
            value: isActive,
            onChanged: (v) => setState(() => _days[day] = v),
            activeColor: const Color(0xFF6366F1),
          ),
          const Spacer(),
          if (isActive) ...[
            GestureDetector(
              onTap: () async {
                final t = await showTimePicker(
                  context: context,
                  initialTime: _startTimes[day]!,
                );
                if (t != null) setState(() => _startTimes[day] = t);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  _startTimes[day]!.format(context),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF6366F1),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Text(
                '–',
                style: TextStyle(color: context.textSecondaryColor),
              ),
            ),
            GestureDetector(
              onTap: () async {
                final t = await showTimePicker(
                  context: context,
                  initialTime: _endTimes[day]!,
                );
                if (t != null) setState(() => _endTimes[day] = t);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  _endTimes[day]!.format(context),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF6366F1),
                  ),
                ),
              ),
            ),
          ] else
            Text(
              'Off',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12.sp,
                color: context.textSecondaryColor,
              ),
            ),
        ],
      ),
    );
  }
}

class _ModernTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;
  final String? hint;
  final String? prefix;

  const _ModernTextField({
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
    this.hint,
    this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, size: 20.sp),
        prefixText: prefix,
        filled: true,
        fillColor: context.surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
        ),
        labelStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 13.sp,
          color: context.textSecondaryColor,
        ),
        hintStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12.sp,
          color: context.textSecondaryColor.withOpacity(0.6),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      ),
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14.sp,
        color: context.textPrimaryColor,
      ),
    );
  }
}

class _ModernTextArea extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;

  const _ModernTextArea({
    required this.controller,
    required this.label,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 4,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        alignLabelWithHint: true,
        filled: true,
        fillColor: context.surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
        ),
        labelStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 13.sp,
          color: context.textSecondaryColor,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      ),
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14.sp,
        color: context.textPrimaryColor,
      ),
    );
  }
}
