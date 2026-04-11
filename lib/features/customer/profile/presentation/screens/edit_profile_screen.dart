import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:Resilio/core/theme/app_colors.dart';
import 'package:Resilio/core/widgets/avatar_crop_screen.dart';
import 'package:Resilio/features/customer/profile/domain/entities/profile_entity.dart';
import 'package:Resilio/features/customer/profile/presentation/bloc/profile_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  final ProfileEntity profile;

  const EditProfileScreen({super.key, required this.profile});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _usernameController;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  DateTime? _selectedDob;
  String? _selectedGender;

  static const List<String> _genderOptions = ['Male', 'Female', 'Other', 'Prefer not to say'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.displayName);
    _emailController = TextEditingController(text: widget.profile.email);
    _phoneController = TextEditingController(text: widget.profile.phoneNumber);
    _usernameController = TextEditingController(text: widget.profile.username);
    _selectedDob = widget.profile.dateOfBirth.isNotEmpty
        ? DateTime.tryParse(widget.profile.dateOfBirth)
        : null;
    _selectedGender = widget.profile.gender.isNotEmpty ? widget.profile.gender : null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );
    if (pickedFile == null) return;

    // Push the crop screen and wait for the cropped file
    if (!mounted) return;
    final File? cropped = await Navigator.of(context).push<File>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => AvatarCropScreen(imageFile: File(pickedFile.path)),
      ),
    );

    if (cropped != null && mounted) {
      setState(() => _imageFile = cropped);
    }
  }

  Future<void> _pickDateOfBirth() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDob ?? DateTime(now.year - 25),
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year - 10),
      helpText: 'Select Date of Birth',
    );
    if (picked != null) {
      setState(() => _selectedDob = picked);
    }
  }

  void _onSave() {
    final bloc = context.read<ProfileBloc>();

    // Build updated profile — photoUrl is unchanged here; if a new image was
    // cropped the bloc will upload it to Cloudinary and set the URL itself.
    final updatedProfile = ProfileEntity(
      id: widget.profile.id,
      firebaseUid: widget.profile.firebaseUid,
      email: _emailController.text.trim(),
      username: _usernameController.text.trim(),
      displayName: _nameController.text.trim(),
      photoUrl: widget.profile.photoUrl,
      phoneNumber: _phoneController.text.trim(),
      dateOfBirth: _selectedDob != null
          ? DateFormat('yyyy-MM-dd').format(_selectedDob!)
          : widget.profile.dateOfBirth,
      gender: _selectedGender ?? widget.profile.gender,
      userRole: widget.profile.userRole,
      accountStatus: widget.profile.accountStatus,
      preferencesCompleted: widget.profile.preferencesCompleted,
      fcmToken: widget.profile.fcmToken,
      timezone: widget.profile.timezone,
      language: widget.profile.language,
      createdAt: widget.profile.createdAt,
      updatedAt: DateTime.now(),
      lastLoginAt: widget.profile.lastLoginAt,
    );

    if (_imageFile != null) {
      bloc.add(UploadAvatarEvent(
        filePath: _imageFile!.path,
        currentProfile: updatedProfile,
      ));
    } else {
      bloc.add(UpdateProfileEvent(updatedProfile));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Row(
                children: [
                  Icon(Icons.check_circle_rounded, color: Colors.white, size: 18),
                  SizedBox(width: 8),
                  Text('Profile updated successfully'),
                ],
              ),
              backgroundColor: Colors.green.shade600,
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.pop(context);
        } else if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red.shade600,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        final isUploading = state is ProfileAvatarUploading || state is ProfileUpdating;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Profile'),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20.sp,
                color: context.textPrimaryColor,
              ),
              onPressed: () => context.pop(),
            ),
            actions: [
              if (isUploading)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              else
                TextButton(
                  onPressed: _onSave,
                  child: Text('Save', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp)),
                ),
            ],
          ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar picker
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 56.r,
                        backgroundColor: theme.primaryColor.withValues(alpha: 0.1),
                        backgroundImage: _imageFile != null
                            ? FileImage(_imageFile!) as ImageProvider
                            : _resolveImageProvider(widget.profile.photoUrl),
                        child: (_imageFile == null && widget.profile.photoUrl.isEmpty)
                            ? Icon(Icons.person_rounded, size: 48.sp, color: theme.primaryColor)
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            color: theme.primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: theme.scaffoldBackgroundColor, width: 2.w),
                          ),
                          child: Icon(Icons.camera_alt_rounded, size: 14.sp, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 32.h),
              _sectionLabel('Personal Information'),
              SizedBox(height: 12.h),

              _buildField(
                controller: _nameController,
                label: 'Full Name',
                icon: Icons.person_outline_rounded,
                isDark: isDark,
              ),
              SizedBox(height: 14.h),
              _buildField(
                controller: _usernameController,
                label: 'Username',
                icon: Icons.alternate_email_rounded,
                isDark: isDark,
              ),
              SizedBox(height: 14.h),
              _buildField(
                controller: _emailController,
                label: 'Email',
                icon: Icons.email_outlined,
                isDark: isDark,
                enabled: false,
                hint: 'Email cannot be changed',
              ),
              SizedBox(height: 14.h),
              _buildField(
                controller: _phoneController,
                label: 'Phone Number',
                icon: Icons.phone_android_outlined,
                isDark: isDark,
                keyboardType: TextInputType.phone,
              ),

              SizedBox(height: 24.h),
              _sectionLabel('More About You'),
              SizedBox(height: 12.h),

              // Date of Birth picker
              GestureDetector(
                onTap: _pickDateOfBirth,
                child: _buildReadOnlyField(
                  label: 'Date of Birth',
                  value: _selectedDob != null
                      ? DateFormat('MMMM dd, yyyy').format(_selectedDob!)
                      : 'Tap to set',
                  icon: Icons.cake_outlined,
                  isDark: isDark,
                  placeholder: _selectedDob == null,
                ),
              ),
              SizedBox(height: 14.h),

              // Gender dropdown
              _buildDropdownField(
                label: 'Gender',
                icon: Icons.wc_outlined,
                value: _selectedGender,
                items: _genderOptions,
                isDark: isDark,
                onChanged: (val) => setState(() => _selectedGender = val),
              ),

              SizedBox(height: 40.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isUploading ? null : _onSave,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
                  ),
                  child: isUploading
                      ? SizedBox(
                          height: 18.h,
                          width: 18.h,
                          child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : Text('Save Changes', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      );
    },
    );
  }

  /// Returns the right ImageProvider for a photoUrl that may be a local file
  /// path (set after cropping) or a remote URL.
  ImageProvider? _resolveImageProvider(String photoUrl) {
    if (photoUrl.isEmpty) return null;
    if (photoUrl.startsWith('/')) return FileImage(File(photoUrl));
    return NetworkImage(photoUrl);
  }

  Widget _sectionLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).primaryColor,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool isDark,
    bool enabled = true,
    String? hint,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      style: TextStyle(fontSize: 15.sp),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, size: 20.sp),
        filled: true,
        fillColor: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: isDark ? Colors.white12 : Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: isDark ? Colors.white10 : Colors.grey.shade200),
        ),
      ),
    );
  }

  Widget _buildReadOnlyField({
    required String label,
    required String value,
    required IconData icon,
    required bool isDark,
    bool placeholder = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: isDark ? Colors.white12 : Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20.sp, color: Colors.grey),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: placeholder ? Colors.grey : null,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.calendar_today_outlined, size: 16.sp, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required IconData icon,
    required String? value,
    required List<String> items,
    required bool isDark,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: isDark ? Colors.white12 : Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20.sp, color: Colors.grey),
          SizedBox(width: 12.w),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: items.contains(value) ? value : null,
                hint: Text(label, style: TextStyle(fontSize: 15.sp, color: Colors.grey)),
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                items: items
                    .map((g) => DropdownMenuItem(value: g, child: Text(g, style: TextStyle(fontSize: 15.sp))))
                    .toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
