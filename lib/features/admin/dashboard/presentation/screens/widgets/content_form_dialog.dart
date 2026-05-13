import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Resilio/core/theme/app_colors.dart';
import 'package:Resilio/core/di/injection.dart';
import 'package:Resilio/core/services/cloudinary_service.dart';

class ContentFormDialog extends StatefulWidget {
  final String contentType;
  final dynamic existingData;
  final Future<void> Function(Map<String, dynamic> data) onSave;

  const ContentFormDialog({
    super.key,
    required this.contentType,
    this.existingData,
    required this.onSave,
  });

  @override
  State<ContentFormDialog> createState() => _ContentFormDialogState();
}

class _ContentFormDialogState extends State<ContentFormDialog> {
  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;

  // Common Fields
  late String _categoryId;
  late List<String> _preferenceIds;
  late bool _isFeatured;
  late bool _isPremium;

  // Data map matching SQL schema
  final Map<String, dynamic> _data = {};

  @override
  void initState() {
    super.initState();
    _initDefaults();
    if (widget.existingData != null) {
      _loadExisting();
    }
  }

  void _initDefaults() {
    _categoryId = 'general_cat';
    _preferenceIds = [];
    _isFeatured = false;
    _isPremium = false;

    // Set schema defaults per content
    if (widget.contentType == 'tips') {
      _data['tip_type'] = 'general';
    } else if (widget.contentType == 'quotes') {
      _data['quote_type'] = 'quote';
    } else if (widget.contentType == 'videos') {
      _data['video_type'] = 'long';
      _data['aspect_ratio'] = 1.7778;
    } else if (widget.contentType == 'images') {
      _data['image_type'] = 'motivation';
    }
  }

  void _loadExisting() {
    final d = widget.existingData;
    _data.addAll(Map<String, dynamic>.from(d));
    _categoryId = d['category_id'] ?? 'general_cat';
    _preferenceIds = (d['preference_ids'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [];
    _isFeatured = d['is_featured'] == true;
    _isPremium = d['is_premium'] == true;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      backgroundColor: context.surfaceColor,
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Divider(color: context.dividerColor, height: 1),
            Expanded(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    children: [
                      ..._buildContentSpecificFields(),
                      SizedBox(height: 24.h),
                      _buildToggles(),
                    ],
                  ),
                ),
              ),
            ),
            Divider(color: context.dividerColor, height: 1),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(color: context.primaryColor.withOpacity(0.12), borderRadius: BorderRadius.circular(12.r)),
                child: Icon(_getIcon(), color: context.primaryColor, size: 22.sp),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.existingData == null ? 'Create Content' : 'Edit Content', style: TextStyle(fontFamily: 'Poppins', fontSize: 16.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor)),
                  Text(widget.contentType.toUpperCase(), style: TextStyle(fontFamily: 'Poppins', fontSize: 11.sp, color: context.textSecondaryColor)),
                ],
              ),
            ],
          ),
          IconButton(icon: Icon(Icons.close_rounded, color: context.textSecondaryColor), onPressed: () => context.pop()),
        ],
      ),
    );
  }

  IconData _getIcon() {
    switch (widget.contentType) {
      case 'tips': return Icons.lightbulb_rounded;
      case 'quotes': return Icons.format_quote_rounded;
      case 'audio': return Icons.audiotrack_rounded;
      case 'videos': return Icons.play_circle_fill_rounded;
      case 'images': return Icons.image_rounded;
      default: return Icons.folder_rounded;
    }
  }

  List<Widget> _buildContentSpecificFields() {
    switch (widget.contentType) {
      case 'tips':
        return [
          _buildTextField('title', 'Tip Title', required: true),
          _buildTextField('tip_text', 'Tip Body / Content', required: true, maxLines: 4),
          _buildTextField('author', 'Author Name', required: true),
          _MediaInput(label: 'Author Icon URL', initialUrl: _data['author_icon_url'], onSaved: (url) => _data['author_icon_url'] = url, type: 'image'),
          _buildDropdown('tip_type', 'Tip Category Type', ['general', 'relationship_booster', 'letting_go', 'communication', 'self_care', 'mindfulness']),
        ];
      case 'quotes':
        return [
          _buildTextField('quote_text', 'Quote Text', required: true, maxLines: 3),
          _buildTextField('author', 'Author Name', required: true),
          _MediaInput(label: 'Author Icon URL', initialUrl: _data['author_icon_url'], onSaved: (url) => _data['author_icon_url'] = url, type: 'image'),
          _buildDropdown('quote_type', 'Quote Type', ['quote', 'tip', 'affirmation']),
        ];
      case 'audio':
        return [
          _buildTextField('title', 'Audio Title', required: true),
          _buildTextField('description', 'Description', maxLines: 3),
          _buildTextField('artist_name', 'Artist / Creator Name'),
          _buildTextField('duration_seconds', 'Duration (Seconds)', keyboardType: TextInputType.number),
          _MediaInput(label: 'Audio File Upload', initialUrl: _data['audio_url'], onSaved: (url) => _data['audio_url'] = url, type: 'audio'),
          _MediaInput(label: 'Cover Image URL', initialUrl: _data['cover_image_url'], onSaved: (url) => _data['cover_image_url'] = url, type: 'image'),
        ];
      case 'videos':
        return [
          _buildTextField('title', 'Video Title', required: true),
          _buildTextField('description', 'Description', maxLines: 3),
          _buildTextField('artist_name', 'Artist / Creator Name'),
          _buildTextField('duration_seconds', 'Duration (Seconds)', keyboardType: TextInputType.number),
          _MediaInput(label: 'Video File Upload', initialUrl: _data['video_url'], onSaved: (url) => _data['video_url'] = url, type: 'video'),
          _MediaInput(label: 'Thumbnail URL', initialUrl: _data['thumbnail_url'], onSaved: (url) => _data['thumbnail_url'] = url, type: 'image'),
          _buildDropdown('video_type', 'Video Format', ['long', 'short']),
        ];
      case 'images':
        return [
          _buildTextField('title', 'Image Title', required: true),
          _buildTextField('description', 'Description', maxLines: 2),
          _buildTextField('author', 'Author / Studio Name'),
          _MediaInput(label: 'Image File Upload', initialUrl: _data['image_url'], onSaved: (url) => _data['image_url'] = url, type: 'image'),
          _buildDropdown('image_type', 'Image Type', ['motivation', 'nature', 'quotes', 'abstract', 'spiritual', 'general']),
        ];
      default:
        return [const Text('Unsupported content type')];
    }
  }

  Widget _buildTextField(String key, String label, {bool required = false, int maxLines = 1, TextInputType? keyboardType}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: TextFormField(
        initialValue: _data[key]?.toString() ?? '',
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp, color: context.textPrimaryColor),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontFamily: 'Poppins', fontSize: 12.sp, color: context.textSecondaryColor),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: context.dividerColor)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: context.dividerColor)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: context.primaryColor, width: 2)),
          filled: true,
          fillColor: context.backgroundColor,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        ),
        validator: required ? (v) => v == null || v.trim().isEmpty ? 'Required field' : null : null,
        onSaved: (v) {
          if (keyboardType == TextInputType.number) {
            _data[key] = int.tryParse(v ?? '0') ?? 0;
          } else {
            _data[key] = v?.trim();
          }
        },
      ),
    );
  }

  Widget _buildDropdown(String key, String label, List<String> options) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: DropdownButtonFormField<String>(
        value: _data[key] ?? options.first,
        dropdownColor: context.surfaceColor,
        style: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp, color: context.textPrimaryColor),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontFamily: 'Poppins', fontSize: 12.sp, color: context.textSecondaryColor),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: context.dividerColor)),
          filled: true,
          fillColor: context.backgroundColor,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        ),
        items: options.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontFamily: 'Poppins')))).toList(),
        onChanged: (v) => setState(() => _data[key] = v),
      ),
    );
  }

  Widget _buildToggles() {
    return Row(
      children: [
        Expanded(child: _CustomToggle(label: 'Featured Content', value: _isFeatured, onChanged: (v) => setState(() => _isFeatured = v))),
        SizedBox(width: 16.w),
        Expanded(child: _CustomToggle(label: 'Premium Access', value: _isPremium, onChanged: (v) => setState(() => _isPremium = v), activeColor: const Color(0xFFF59E0B))),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => context.pop(),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                side: BorderSide(color: context.dividerColor),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
              child: Text('Cancel', style: TextStyle(fontFamily: 'Poppins', color: context.textPrimaryColor, fontWeight: FontWeight.w600)),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _isSaving ? null : _handleSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: context.primaryColor,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                elevation: 0,
              ),
              child: _isSaving
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : const Text('Save Content', style: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    // Map the shared fields into payload matching exact schemas
    _data['category_id'] = _categoryId;
    _data['preference_ids'] = _preferenceIds; // API expects array
    _data['is_featured'] = _isFeatured;
    _data['is_premium'] = _isPremium;

    // For videos, automatically set aspect ratio based on type if missing
    if (widget.contentType == 'videos') {
      if (_data['video_type'] == 'short' && _data['aspect_ratio'] == 1.7778) _data['aspect_ratio'] = 0.5625;
      if (_data['video_type'] == 'long' && _data['aspect_ratio'] == 0.5625) _data['aspect_ratio'] = 1.7778;
    }

    setState(() => _isSaving = true);
    await widget.onSave(_data);
    setState(() => _isSaving = false);

    if (mounted) context.pop();
  }
}

class _CustomToggle extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? activeColor;

  const _CustomToggle({required this.label, required this.value, required this.onChanged, this.activeColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(color: context.backgroundColor, border: Border.all(color: context.dividerColor), borderRadius: BorderRadius.circular(12.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(label, style: TextStyle(fontFamily: 'Poppins', fontSize: 11.sp, fontWeight: FontWeight.w600, color: context.textPrimaryColor))),
          Switch.adaptive(value: value, onChanged: onChanged, activeColor: activeColor ?? context.primaryColor),
        ],
      ),
    );
  }
}

class _MediaInput extends StatefulWidget {
  final String label;
  final String? initialUrl;
  final ValueChanged<String> onSaved;
  final String type; // 'image', 'audio', 'video'

  const _MediaInput({required this.label, this.initialUrl, required this.onSaved, required this.type});

  @override
  State<_MediaInput> createState() => _MediaInputState();
}

class _MediaInputState extends State<_MediaInput> {
  final _urlCtrl = TextEditingController();
  bool _isUploading = false;
  bool _useLinkInput = true;

  @override
  void initState() {
    super.initState();
    _urlCtrl.text = widget.initialUrl ?? '';
  }

  @override
  void dispose() {
    _urlCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: context.dividerColor), borderRadius: BorderRadius.circular(16.r), color: context.backgroundColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.label, style: TextStyle(fontFamily: 'Poppins', fontSize: 12.sp, fontWeight: FontWeight.w600, color: context.textPrimaryColor)),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => _useLinkInput = true),
                        child: Text('URL Link', style: TextStyle(fontFamily: 'Poppins', fontSize: 11.sp, color: _useLinkInput ? context.primaryColor : context.textSecondaryColor, fontWeight: _useLinkInput ? FontWeight.w700 : FontWeight.w500)),
                      ),
                      SizedBox(width: 12.w),
                      GestureDetector(
                        onTap: () => setState(() => _useLinkInput = false),
                        child: Text('Upload', style: TextStyle(fontFamily: 'Poppins', fontSize: 11.sp, color: !_useLinkInput ? context.primaryColor : context.textSecondaryColor, fontWeight: !_useLinkInput ? FontWeight.w700 : FontWeight.w500)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(color: context.dividerColor, height: 1),
            Padding(
              padding: EdgeInsets.all(12.w),
              child: _useLinkInput ? _buildLinkInput() : _buildUploadInput(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkInput() {
    return TextFormField(
      controller: _urlCtrl,
      style: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp),
      decoration: InputDecoration(
        hintText: 'Paste direct https:// link here...',
        hintStyle: TextStyle(fontFamily: 'Poppins', fontSize: 12.sp, color: context.textHintColor),
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
      ),
      onSaved: (v) => widget.onSaved(_urlCtrl.text),
    );
  }

  Widget _buildUploadInput() {
    return _isUploading
        ? Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 20.w, height: 20.w, child: CircularProgressIndicator(strokeWidth: 2, color: context.primaryColor)),
                SizedBox(width: 16.w),
                Text('Uploading to Cloudinary...', style: TextStyle(fontFamily: 'Poppins', fontSize: 12.sp, color: context.textPrimaryColor)),
              ],
            ),
          )
        : InkWell(
            onTap: _pickFile,
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(color: context.primaryColor.withOpacity(0.05), borderRadius: BorderRadius.circular(12.r), border: Border.all(color: context.primaryColor.withOpacity(0.3), style: BorderStyle.solid)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload_rounded, color: context.primaryColor, size: 24.sp),
                  SizedBox(height: 6.h),
                  Text(
                    _urlCtrl.text.isNotEmpty ? 'File Selected: ${_urlCtrl.text.split('/').last.substring(0, 15)}...' : 'Tap to Browse Device Files',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 11.sp, color: context.primaryColor, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          );
  }

  Future<void> _pickFile() async {
    setState(() => _isUploading = true);
    try {
      String? path;
      if (widget.type == 'image') {
        final res = await ImagePicker().pickImage(source: ImageSource.gallery);
        path = res?.path;
      } else {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: widget.type == 'audio' ? FileType.audio : FileType.video,
        );
        path = result?.files.single.path;
      }

      if (path != null) {
        final uploader = getIt<CloudinaryService>();
        final url = await uploader.uploadMedia(File(path), widget.type);
        setState(() => _urlCtrl.text = url);
        widget.onSaved(url);
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload failed: $e')));
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }
}
