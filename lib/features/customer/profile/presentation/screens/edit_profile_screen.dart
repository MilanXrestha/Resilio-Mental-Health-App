import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
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
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.displayName);
    _emailController = TextEditingController(text: widget.profile.email);
    _phoneController = TextEditingController(text: widget.profile.phoneNumber);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _onSave() {
    final updatedProfile = ProfileEntity(
      id: widget.profile.id,
      firebaseUid: widget.profile.firebaseUid,
      email: _emailController.text.trim(),
      username: widget.profile.username,
      displayName: _nameController.text.trim(),
      photoUrl: widget.profile.photoUrl, // Logic for new photo upload could be added here
      phoneNumber: _phoneController.text.trim(),
      dateOfBirth: widget.profile.dateOfBirth,
      gender: widget.profile.gender,
      userRole: widget.profile.userRole,
      accountStatus: widget.profile.accountStatus,
      preferencesCompleted: widget.profile.preferencesCompleted,
      fcmToken: widget.profile.fcmToken,
      timezone: widget.profile.timezone,
      language: widget.profile.language,
      createdAt: widget.profile.createdAt,
      updatedAt: DateTime.now(),
    );

    context.read<ProfileBloc>().add(UpdateProfileEvent(updatedProfile));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully')),
          );
          Navigator.pop(context);
        } else if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _onSave,
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60.r,
                      backgroundImage: _imageFile != null 
                          ? FileImage(_imageFile!) 
                          : (widget.profile.photoUrl.isNotEmpty 
                              ? NetworkImage(widget.profile.photoUrl) as ImageProvider
                              : null),
                      child: (_imageFile == null && widget.profile.photoUrl.isEmpty)
                          ? Icon(Icons.camera_alt, size: 40.sp)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.edit, size: 16.sp, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              SizedBox(height: 16.h),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                keyboardType: TextInputType.emailAddress,
                enabled: false, // Usually email is not editable directly
              ),
              SizedBox(height: 16.h),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone_android_outlined),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 40.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onSave,
                  child: const Text('Save Changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
