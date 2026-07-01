import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Resilio/core/theme/app_colors.dart';
import 'package:Resilio/core/di/injection.dart';
import 'package:Resilio/core/services/cloudinary_service.dart';
import '../bloc/admin_preference_cubit.dart';
import 'widgets/admin_widgets.dart';

class AdminPreferencesScreen extends StatefulWidget {
  const AdminPreferencesScreen({super.key});

  @override
  State<AdminPreferencesScreen> createState() => _AdminPreferencesScreenState();
}

class _AdminPreferencesScreenState extends State<AdminPreferencesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminPreferenceCubit>().loadPreferences();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        title: Text('Onboarding Preferences', style: TextStyle(fontFamily: 'Poppins', fontSize: 20.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor)),
        backgroundColor: context.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: context.textPrimaryColor),
          onPressed: () => context.pop(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showPreferenceForm(context),
        backgroundColor: context.primaryColor,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: Text('New Preference', style: const TextStyle(color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
      ),
      body: BlocBuilder<AdminPreferenceCubit, AdminPrefState>(
        builder: (context, state) {
          if (state.status == AdminPrefStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.categories.isEmpty) {
            return AdminEmptyState(
              icon: Icons.list_alt_rounded,
              title: 'No Preferences Found',
              subtitle: 'Add onboarding selections like "Stress Relief" or "Better Sleep".',
            );
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            itemCount: state.categories.length,
            itemBuilder: (_, i) {
              final cat = state.categories[i];
              final name = cat['preference_name']?.toString() ?? 'Unknown';
              final desc = cat['preference_description']?.toString() ?? 'No description';
              final iconUrl = cat['preference_icon']?.toString();
              
              return Container(
                margin: EdgeInsets.only(bottom: 16.h),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: context.surfaceColor,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 56.w, height: 56.w,
                      decoration: BoxDecoration(color: context.primaryColor.withOpacity(0.12), borderRadius: BorderRadius.circular(16.r)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: iconUrl != null && iconUrl.isNotEmpty 
                          ? Image.network(iconUrl, fit: BoxFit.cover, errorBuilder: (_, _, _) => Icon(Icons.category_rounded, color: context.primaryColor))
                          : Icon(Icons.category_rounded, color: context.primaryColor, size: 28.sp),
                      ),
                    ),
                    SizedBox(width: 14.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name, style: TextStyle(fontFamily: 'Poppins', fontSize: 16.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor)),
                          SizedBox(height: 2.h),
                          Text(desc, style: TextStyle(fontFamily: 'Poppins', fontSize: 12.sp, color: context.textSecondaryColor), maxLines: 2, overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                    _buildActionMenu(context, cat),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildActionMenu(BuildContext context, dynamic cat) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert_rounded, color: context.textSecondaryColor),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      onSelected: (val) {
        if (val == 'edit') _showPreferenceForm(context, existingData: cat);
        if (val == 'delete') _confirmDelete(context, cat['id']);
      },
      itemBuilder: (_) => [
        PopupMenuItem(value: 'edit', child: Row(children: [Icon(Icons.edit_rounded, size: 18.sp, color: context.primaryColor), SizedBox(width: 8.w), const Text('Edit', style: TextStyle(fontFamily: 'Poppins'))])),
        PopupMenuItem(value: 'delete', child: Row(children: [Icon(Icons.delete_outline_rounded, size: 18.sp, color: const Color(0xFFEF4444)), SizedBox(width: 8.w), const Text('Delete', style: TextStyle(fontFamily: 'Poppins', color: Color(0xFFEF4444)))])),
      ],
    );
  }

  void _showPreferenceForm(BuildContext context, {dynamic existingData}) {
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<AdminPreferenceCubit>(),
        child: _PreferenceFormDialog(existingData: existingData),
      ),
    );
  }

  void _confirmDelete(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: const Text('Delete Preference', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
        content: const Text('Are you sure? This will remove this preference option from the customer app.'),
        actions: [
          TextButton(onPressed: () => context.pop(), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFEF4444)),
            onPressed: () {
              context.read<AdminPreferenceCubit>().deletePreference(id);
              context.pop();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
          ),
        ],
      ),
    );
  }
}

class _PreferenceFormDialog extends StatefulWidget {
  final dynamic existingData;
  const _PreferenceFormDialog({this.existingData});

  @override
  State<_PreferenceFormDialog> createState() => _PreferenceFormDialogState();
}

class _PreferenceFormDialogState extends State<_PreferenceFormDialog> {
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _iconUrlCtrl = TextEditingController();
  
  bool _isSvg = false;
  bool _isSaving = false;
  bool _isUploadingIcon = false;

  bool get isEditing => widget.existingData != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      _nameCtrl.text = widget.existingData['preference_name'] ?? '';
      _descCtrl.text = widget.existingData['preference_description'] ?? '';
      _iconUrlCtrl.text = widget.existingData['preference_icon'] ?? '';
      _isSvg = widget.existingData['is_svg'] == true;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _iconUrlCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      backgroundColor: context.surfaceColor,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isEditing ? 'Edit Preference' : 'New Preference',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 18.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor),
                ),
                IconButton(icon: Icon(Icons.close_rounded, color: context.textSecondaryColor), onPressed: () => Navigator.pop(context)),
              ],
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: _nameCtrl,
              decoration: InputDecoration(
                labelText: 'Preference Name (e.g. Better Sleep)',
                labelStyle: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: context.dividerColor)),
                filled: true, fillColor: context.backgroundColor,
                contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: _descCtrl,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: context.dividerColor)),
                filled: true, fillColor: context.backgroundColor,
                contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              ),
            ),
            SizedBox(height: 16.h),
            
            // Icon Upload logic
            Container(
              decoration: BoxDecoration(border: Border.all(color: context.dividerColor), borderRadius: BorderRadius.circular(16.r), color: context.backgroundColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Text('Icon URL', style: TextStyle(fontFamily: 'Poppins', fontSize: 12.sp, fontWeight: FontWeight.w600, color: context.textPrimaryColor)),
                  ),
                  Divider(color: context.dividerColor, height: 1),
                  Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _iconUrlCtrl,
                            style: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp),
                            decoration: InputDecoration(
                              hintText: 'https://...',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        if (_isUploadingIcon)
                          SizedBox(width: 20.w, height: 20.w, child: CircularProgressIndicator(strokeWidth: 2, color: context.primaryColor))
                        else
                          IconButton(icon: Icon(Icons.cloud_upload_rounded, color: context.primaryColor), onPressed: _uploadIcon),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(border: Border.all(color: context.dividerColor), borderRadius: BorderRadius.circular(12.r), color: context.backgroundColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Is image SVG format?', style: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp, color: context.textPrimaryColor)),
                  Switch.adaptive(value: _isSvg, onChanged: (v) => setState(() => _isSvg = v), activeColor: context.primaryColor),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSaving ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
                  elevation: 0,
                ),
                child: _isSaving
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : Text('Save Preference', style: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp, fontWeight: FontWeight.w700, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _uploadIcon() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    setState(() => _isUploadingIcon = true);
    try {
      final uploader = getIt<CloudinaryService>();
      final url = await uploader.uploadMedia(File(pickedFile.path), 'image', folder: 'preferences');
      setState(() {
        _iconUrlCtrl.text = url;
        if (url.toLowerCase().endsWith('.svg')) _isSvg = true;
      });
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload failed: $e')));
    } finally {
      if (mounted) setState(() => _isUploadingIcon = false);
    }
  }

  Future<void> _save() async {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Name is required'), behavior: SnackBarBehavior.floating));
      return;
    }

    setState(() => _isSaving = true);
    final data = {
      'preference_name': name,
      'preference_description': _descCtrl.text.trim(),
      'preference_icon': _iconUrlCtrl.text.trim(),
      'is_svg': _isSvg,
    };

    bool ok;
    if (isEditing) {
      ok = await context.read<AdminPreferenceCubit>().updatePreference(widget.existingData['id'], data);
    } else {
      // Typically backend handles preference_id slug creation
      data['preference_id'] = 'pref_${DateTime.now().millisecondsSinceEpoch}';
      ok = await context.read<AdminPreferenceCubit>().createPreference(data);
    }
    
    setState(() => _isSaving = false);
    if (ok && mounted) Navigator.pop(context);
  }
}
