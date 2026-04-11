import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import '../../../../../../../core/theme/app_colors.dart';
import '../../../bloc/therapist_content_cubit.dart';

class AddEditContentSheet extends StatefulWidget {
  final Map<String, dynamic>? initialData;
  final String contentType;

  const AddEditContentSheet({
    super.key,
    this.initialData,
    required this.contentType,
  });

  @override
  State<AddEditContentSheet> createState() => _AddEditContentSheetState();
}

class _AddEditContentSheetState extends State<AddEditContentSheet> {
  final _formKey = GlobalKey<FormState>();
  bool _isUploading = false;

  // Form Fields
  String _title = '';
  String _description = '';
  String _mediaUrl = '';
  String _thumbnailUrl = '';
  File? _selectedFile;
  File? _selectedThumbnail;

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      final d = widget.initialData!;
      if (widget.contentType == 'tips') {
        _title = d['title'] ?? '';
        _description = d['tipText'] ?? '';
      } else if (widget.contentType == 'quotes') {
        _description = d['quoteText'] ?? '';
      } else {
        _title = d['title'] ?? '';
        _description = d['description'] ?? '';
        _mediaUrl = d['videoUrl'] ?? d['audioUrl'] ?? '';
        _thumbnailUrl = d['thumbnailUrl'] ?? d['coverImageUrl'] ?? '';
      }
    }
  }

  Future<void> _pickFile(bool isThumbnail) async {
    if (isThumbnail || widget.contentType == 'tips') {
      final picker = ImagePicker();
      final picked = await picker.pickImage(source: ImageSource.gallery);
      if (picked != null) {
        setState(() {
          if (isThumbnail) _selectedThumbnail = File(picked.path);
          else _selectedFile = File(picked.path);
        });
      }
    } else {
      final result = await FilePicker.platform.pickFiles(
        type: widget.contentType == 'videos' ? FileType.video : FileType.audio,
      );
      if (result != null && result.files.single.path != null) {
        setState(() => _selectedFile = File(result.files.single.path!));
      }
    }
  }

  // Uses Resilio's default public preset - assuming environment configuration is set up server-side, 
  // but for the demo we'll use a placeholder or let it fail gently.
  Future<String?> _uploadToCloudinary(File file, {bool isVideo = false}) async {
    try {
      final cloudinary = CloudinaryPublic('resilio_cloud', 'ml_default', cache: false);
      final res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          file.path,
          resourceType: isVideo ? CloudinaryResourceType.Video : CloudinaryResourceType.Image,
        ),
      );
      return res.secureUrl;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload failed: $e')));
      return null;
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() => _isUploading = true);

    try {
      if (_selectedFile != null) {
        final url = await _uploadToCloudinary(_selectedFile!, isVideo: widget.contentType == 'videos');
        if (url != null) _mediaUrl = url;
      }
      if (_selectedThumbnail != null) {
        final url = await _uploadToCloudinary(_selectedThumbnail!);
        if (url != null) _thumbnailUrl = url;
      }

      final data = <String, dynamic>{};
      if (widget.contentType == 'tips') {
        data['title'] = _title;
        data['tipText'] = _description;
      } else if (widget.contentType == 'quotes') {
        data['quoteText'] = _description;
      } else {
        data['title'] = _title;
        data['description'] = _description;
        if (widget.contentType == 'videos') {
          data['videoUrl'] = _mediaUrl;
          data['thumbnailUrl'] = _thumbnailUrl;
        } else {
          data['audioUrl'] = _mediaUrl;
          data['coverImageUrl'] = _thumbnailUrl;
        }
      }

      final cubit = context.read<TherapistContentCubit>();
      bool success;
      if (widget.initialData == null) {
        success = await cubit.createContent(data);
      } else {
        success = await cubit.updateContent(widget.initialData!['id'], data);
      }

      if (success && mounted) Navigator.of(context).pop();
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.initialData == null ? 'Add New ${widget.contentType}' : 'Edit ${widget.contentType}';
    return Container(
      padding: EdgeInsets.only(
        left: 20.w, right: 20.w, top: 20.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
      ),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width: 40.w, height: 4.h, decoration: BoxDecoration(color: context.dividerColor, borderRadius: BorderRadius.circular(2.r)))),
              SizedBox(height: 20.h),
              Text(title, style: TextStyle(fontFamily: 'Poppins', fontSize: 20.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor)),
              SizedBox(height: 20.h),

              if (widget.contentType != 'quotes') ...[
                TextFormField(
                  initialValue: _title,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                  onSaved: (v) => _title = v!,
                ),
                SizedBox(height: 16.h),
              ],

              TextFormField(
                initialValue: _description,
                maxLines: widget.contentType == 'quotes' ? 4 : 3,
                decoration: InputDecoration(
                  labelText: widget.contentType == 'quotes' ? 'Quote Text' : 'Description / Text',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                validator: (v) => v!.isEmpty ? 'Required' : null,
                onSaved: (v) => _description = v!,
              ),
              SizedBox(height: 16.h),

              if (widget.contentType == 'videos' || widget.contentType == 'audio') ...[
                // Media Upload
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(_selectedFile != null ? 'Media selected' : 'Upload Media File', style: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp)),
                  subtitle: _mediaUrl.isNotEmpty && _selectedFile == null ? Text('Existing: $_mediaUrl', maxLines: 1) : null,
                  trailing: ElevatedButton(
                    onPressed: () => _pickFile(false),
                    child: const Text('Browse'),
                  ),
                ),
                // Thumbnail Upload
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(_selectedThumbnail != null ? 'Thumbnail selected' : 'Upload Thumbnail Cover', style: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp)),
                  subtitle: _thumbnailUrl.isNotEmpty && _selectedThumbnail == null ? Text('Existing: $_thumbnailUrl', maxLines: 1) : null,
                  trailing: ElevatedButton(
                    onPressed: () => _pickFile(true),
                    child: const Text('Browse'),
                  ),
                ),
              ],

              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    backgroundColor: context.primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  onPressed: _isUploading ? null : _submit,
                  child: _isUploading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text('Save ${widget.contentType}', style: TextStyle(fontFamily: 'Poppins', fontSize: 15.sp, color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
