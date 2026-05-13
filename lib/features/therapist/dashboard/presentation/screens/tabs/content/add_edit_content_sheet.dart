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

  // Shared form fields
  String _title = '';
  String _description = '';
  bool _isFeatured = false;
  bool _isPremium = false;

  // Videos / Audio Form fields
  String _mediaUrl = '';
  String _thumbnailUrl = '';
  String _artistName = '';
  int _durationSeconds = 0;
  String _videoType = 'long'; // 'short' or 'long'

  // Tips / Quotes Form fields
  String _author = '';
  String _authorIconUrl = '';
  String _tipType = 'general';
  String _quoteType = 'quote';

  File? _selectedFile;
  File? _selectedThumbnail;

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      final d = widget.initialData!;
      _isFeatured = d['isFeatured'] ?? d['is_featured'] ?? false;
      _isPremium = d['isPremium'] ?? d['is_premium'] ?? false;

      if (widget.contentType == 'tips') {
        _title = d['title'] ?? '';
        _description = d['tipText'] ?? d['tip_text'] ?? '';
        _author = d['author'] ?? '';
        _authorIconUrl = d['authorIconUrl'] ?? d['author_icon_url'] ?? '';
        _tipType = d['tipType'] ?? d['tip_type'] ?? 'general';
      } else if (widget.contentType == 'quotes') {
        _description = d['quoteText'] ?? d['quote_text'] ?? '';
        _author = d['author'] ?? '';
        _authorIconUrl = d['authorIconUrl'] ?? d['author_icon_url'] ?? '';
        _quoteType = d['quoteType'] ?? d['quote_type'] ?? 'quote';
      } else {
        _title = d['title'] ?? '';
        _description = d['description'] ?? '';
        _mediaUrl = d['videoUrl'] ?? d['audioUrl'] ?? d['video_url'] ?? d['audio_url'] ?? '';
        _thumbnailUrl = d['thumbnailUrl'] ?? d['coverImageUrl'] ?? d['thumbnail_url'] ?? d['cover_image_url'] ?? '';
        _artistName = d['artistName'] ?? d['artist_name'] ?? '';
        _durationSeconds = (d['durationSeconds'] ?? d['duration_seconds'] as num?)?.toInt() ?? 0;
        if (widget.contentType == 'videos') {
           _videoType = d['videoType'] ?? d['video_type'] ?? 'long';
        }
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
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload failed: $e')));
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
      
      // Map to proper snake_case depending on backend matching
      // The content cubit handles passing it as JSON. You should pass the camelCase keys 
      // if your backend has snakecase conversion middleware, otherwise send exactly what's below.
      data['isFeatured'] = _isFeatured;
      data['isPremium'] = _isPremium;

      if (widget.contentType == 'tips') {
        data['title'] = _title;
        data['tipText'] = _description;
        data['author'] = _author;
        data['authorIconUrl'] = _authorIconUrl;
        data['tipType'] = _tipType;
      } else if (widget.contentType == 'quotes') {
        data['quoteText'] = _description;
        data['author'] = _author;
        data['authorIconUrl'] = _authorIconUrl;
        data['quoteType'] = _quoteType;
      } else {
        data['title'] = _title;
        data['description'] = _description;
        data['artistName'] = _artistName;
        data['durationSeconds'] = _durationSeconds;
        
        if (widget.contentType == 'videos') {
          data['videoUrl'] = _mediaUrl;
          data['thumbnailUrl'] = _thumbnailUrl;
          data['videoType'] = _videoType;
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

  Widget _buildTextField({
    required String label, 
    required String initialValue, 
    FormFieldSetter<String>? onSaved,
    int maxLines = 1,
    TextInputType? keyboardType,
    bool required = true,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: TextFormField(
        initialValue: initialValue,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: maxLines > 1 ? 16.h : 0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: context.borderColor)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: context.borderColor)),
        ),
        validator: required ? (v) => v == null || v.isEmpty ? 'Required' : null : null,
        onSaved: onSaved,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.initialData == null ? 'Add New ${widget.contentType.capitalize()}' : 'Edit ${widget.contentType.capitalize()}';
    
    return Container(
      padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 20.h, bottom: MediaQuery.of(context).viewInsets.bottom + 20.h),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width: 40.w, height: 4.h, decoration: BoxDecoration(color: context.dividerColor, borderRadius: BorderRadius.circular(2.r)))),
              SizedBox(height: 24.h),
              Text(title, style: TextStyle(fontFamily: 'Poppins', fontSize: 22.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor)),
              SizedBox(height: 24.h),

              if (widget.contentType != 'quotes')
                _buildTextField(
                  label: 'Title', 
                  initialValue: _title, 
                  onSaved: (v) => _title = v!,
                ),

              _buildTextField(
                label: widget.contentType == 'quotes' ? 'Quote Text' : (widget.contentType == 'tips' ? 'Tip Content' : 'Description'),
                initialValue: _description,
                maxLines: widget.contentType == 'quotes' ? 4 : 3,
                onSaved: (v) => _description = v!,
              ),

              if (widget.contentType == 'quotes' || widget.contentType == 'tips') ...[
                _buildTextField(
                  label: 'Author Name',
                  initialValue: _author,
                  required: widget.contentType == 'quotes',
                  onSaved: (v) => _author = v ?? '',
                ),
                _buildTextField(
                  label: 'Author Icon URL (Optional)',
                  initialValue: _authorIconUrl,
                  required: false,
                  onSaved: (v) => _authorIconUrl = v ?? '',
                ),
                
                if (widget.contentType == 'quotes')
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: DropdownButtonFormField<String>(
                      value: _quoteType,
                      decoration: InputDecoration(
                        labelText: 'Quote Type',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'quote', child: Text('Quote')),
                        DropdownMenuItem(value: 'tip', child: Text('Tip')),
                        DropdownMenuItem(value: 'affirmation', child: Text('Affirmation')),
                      ],
                      onChanged: (v) => setState(() => _quoteType = v!),
                      onSaved: (v) => _quoteType = v!,
                    ),
                  ),

                if (widget.contentType == 'tips')
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: DropdownButtonFormField<String>(
                      value: _tipType,
                      decoration: InputDecoration(
                        labelText: 'Tip Type',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'general', child: Text('General')),
                        DropdownMenuItem(value: 'relationship_booster', child: Text('Relationship Booster')),
                        DropdownMenuItem(value: 'letting_go', child: Text('Letting Go')),
                        DropdownMenuItem(value: 'communication', child: Text('Communication')),
                        DropdownMenuItem(value: 'self_care', child: Text('Self Care')),
                        DropdownMenuItem(value: 'mindfulness', child: Text('Mindfulness')),
                      ],
                      onChanged: (v) => setState(() => _tipType = v!),
                      onSaved: (v) => _tipType = v!,
                    ),
                  ),
              ],

              if (widget.contentType == 'videos' || widget.contentType == 'audio') ...[
                _buildTextField(
                  label: 'Artist / Creator Name',
                  initialValue: _artistName,
                  required: false,
                  onSaved: (v) => _artistName = v ?? '',
                ),
                _buildTextField(
                  label: 'Duration (in Seconds)',
                  initialValue: _durationSeconds > 0 ? _durationSeconds.toString() : '',
                  keyboardType: TextInputType.number,
                  required: true,
                  onSaved: (v) => _durationSeconds = int.tryParse(v ?? '0') ?? 0,
                ),

                if (widget.contentType == 'videos')
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: DropdownButtonFormField<String>(
                      value: _videoType,
                      decoration: InputDecoration(
                        labelText: 'Video Type',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'long', child: Text('Long Form (16:9)')),
                        DropdownMenuItem(value: 'short', child: Text('Short/Reel (9:16)')),
                      ],
                      onChanged: (v) => setState(() => _videoType = v!),
                      onSaved: (v) => _videoType = v!,
                    ),
                  ),

                // Media Upload
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(_selectedFile != null ? 'Media File Selected' : 'Upload Media File', style: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp)),
                  subtitle: _mediaUrl.isNotEmpty && _selectedFile == null ? Text('Existing URL...', maxLines: 1) : null,
                  trailing: ElevatedButton.icon(
                    onPressed: () => _pickFile(false),
                    icon: Icon(Icons.upload_rounded, size: 18.sp),
                    label: const Text('Browse'),
                    style: ElevatedButton.styleFrom(backgroundColor: context.surfaceColor, foregroundColor: context.primaryColor, elevation: 0, side: BorderSide(color: context.primaryColor)),
                  ),
                ),
                // Thumbnail Upload
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(_selectedThumbnail != null ? 'Thumbnail Selected' : 'Upload Cover/Thumbnail', style: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp)),
                  subtitle: _thumbnailUrl.isNotEmpty && _selectedThumbnail == null ? Text('Existing URL...', maxLines: 1) : null,
                  trailing: ElevatedButton.icon(
                    onPressed: () => _pickFile(true),
                    icon: Icon(Icons.image_rounded, size: 18.sp),
                    label: const Text('Browse'),
                    style: ElevatedButton.styleFrom(backgroundColor: context.surfaceColor, foregroundColor: context.primaryColor, elevation: 0, side: BorderSide(color: context.primaryColor)),
                  ),
                ),
              ],

              // Toggles
              SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                activeColor: context.primaryColor,
                title: Text('Featured Content', style: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp, fontWeight: FontWeight.w500)),
                subtitle: Text('Show on main dashboard banners.', style: TextStyle(fontFamily: 'Poppins', fontSize: 12.sp, color: context.textSecondaryColor)),
                value: _isFeatured,
                onChanged: (v) => setState(() => _isFeatured = v),
              ),
              SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                activeColor: context.primaryColor,
                title: Text('Premium Content', style: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp, fontWeight: FontWeight.w500)),
                subtitle: Text('Requires an active subscription to access.', style: TextStyle(fontFamily: 'Poppins', fontSize: 12.sp, color: context.textSecondaryColor)),
                value: _isPremium,
                onChanged: (v) => setState(() => _isPremium = v),
              ),

              SizedBox(height: 32.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    backgroundColor: context.primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    elevation: 0,
                  ),
                  onPressed: _isUploading ? null : _submit,
                  child: _isUploading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text('Save Content', style: TextStyle(fontFamily: 'Poppins', fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
