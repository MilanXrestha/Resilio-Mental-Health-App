import 'dart:io';
import 'dart:math' show sqrt;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';

/// Full-screen image cropper with a true circular crop handle.
/// Returns a [File] of the cropped square image (ready for CircleAvatar), or null if cancelled.
class AvatarCropScreen extends StatefulWidget {
  final File imageFile;

  const AvatarCropScreen({super.key, required this.imageFile});

  @override
  State<AvatarCropScreen> createState() => _AvatarCropScreenState();
}

class _AvatarCropScreenState extends State<AvatarCropScreen> {
  late final CropController _controller;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _controller = CropController(
      aspectRatio: 1.0, // always 1:1 so the circle stays a circle
      defaultCrop: const Rect.fromLTRB(0.05, 0.05, 0.95, 0.95),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onUsePhoto() async {
    setState(() => _isSaving = true);
    try {
      final ui.Image bitmap = await _controller.croppedBitmap(
        maxSize: 600,
        quality: FilterQuality.high,
      );
      final ByteData? byteData =
          await bitmap.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) throw Exception('Failed to encode image');

      final Uint8List bytes = byteData.buffer.asUint8List();
      final dir = await getTemporaryDirectory();
      final path =
          '${dir.path}/avatar_${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File(path)..writeAsBytesSync(bytes);

      if (mounted) Navigator.of(context).pop(file);
    } catch (e) {
      setState(() => _isSaving = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to crop: $e'),
            backgroundColor: Colors.red.shade700,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Move and Scale',
          style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
        ),
        leading: TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.white70, fontSize: 15.sp),
          ),
        ),
        leadingWidth: 80.w,
        actions: [
          _isSaving
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Center(
                    child: SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: const CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    ),
                  ),
                )
              : TextButton(
                  onPressed: _onUsePhoto,
                  child: Text(
                    'Choose',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                // CropImage with all built-in visuals hidden —
                // we draw our own circular guides on top
                CropImage(
                  controller: _controller,
                  image: Image.file(widget.imageFile),
                  paddingSize: 32,
                  alwaysMove: true,
                  // Hide the default rectangular grid completely
                  gridColor: Colors.transparent,
                  scrimColor: Colors.transparent,
                ),

                // Our circular overlay replaces the package's rectangular grid
                IgnorePointer(
                  child: _CircularCropOverlay(controller: _controller),
                ),
              ],
            ),
          ),

          // Bottom bar
          Container(
            color: Colors.black,
            padding:
                EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.h),
            child: Column(
              children: [
                Text(
                  'Drag to reposition • Pinch to zoom',
                  style:
                      TextStyle(color: Colors.white38, fontSize: 12.sp),
                ),
                SizedBox(height: 18.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _BottomButton(
                      icon: Icons.rotate_left_rounded,
                      label: 'Rotate Left',
                      onTap: _controller.rotateLeft,
                    ),
                    SizedBox(width: 32.w),
                    _BottomButton(
                      icon: Icons.rotate_right_rounded,
                      label: 'Rotate Right',
                      onTap: _controller.rotateRight,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Circular overlay — drawn on top of CropImage, completely replacing the
// default rectangular handles with a circular border + 4 round drag handles.
// ---------------------------------------------------------------------------
class _CircularCropOverlay extends StatefulWidget {
  final CropController controller;
  const _CircularCropOverlay({required this.controller});

  @override
  State<_CircularCropOverlay> createState() => _CircularCropOverlayState();
}

class _CircularCropOverlayState extends State<_CircularCropOverlay> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_rebuild);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_rebuild);
    super.dispose();
  }

  void _rebuild() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CircleCropPainter(
        crop: widget.controller.crop,
        padding: 32.0,
      ),
    );
  }
}

class _CircleCropPainter extends CustomPainter {
  final Rect crop; // normalised 0‥1
  final double padding;

  const _CircleCropPainter({required this.crop, required this.padding});

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width - padding * 2;
    final double h = size.height - padding * 2;

    // The crop rect in canvas coordinates
    final Rect cropRect = Rect.fromLTWH(
      padding + crop.left * w,
      padding + crop.top * h,
      crop.width * w,
      crop.height * h,
    );

    // Inscribed circle (1:1 crop so width == height)
    final double diameter = cropRect.shortestSide;
    final Offset center = cropRect.center;
    final double radius = diameter / 2;
    final Rect circleRect = Rect.fromCircle(center: center, radius: radius);

    // 1. Dark scrim — everything outside the circle
    final scrimPaint = Paint()..color = Colors.black.withValues(alpha: 0.55);
    final fullPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final circlePath = Path()..addOval(circleRect);
    final scrimPath =
        Path.combine(PathOperation.difference, fullPath, circlePath);
    canvas.drawPath(scrimPath, scrimPaint);

    // 2. Circular border
    canvas.drawOval(
      circleRect,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.85)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0,
    );

    // 3. Rule-of-thirds lines inside the circle (subtle)
    _drawThirdsLines(canvas, circleRect, radius, center);

    // 4. Round handles at N / E / S / W of the circle
    _drawHandles(canvas, center, radius);
  }

  void _drawThirdsLines(
      Canvas canvas, Rect rect, double radius, Offset center) {
    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.25)
      ..strokeWidth = 0.8;

    // 2 horizontal + 2 vertical thirds lines, clipped to the circle
    for (int i = 1; i <= 2; i++) {
      final double yOff = rect.top + rect.height * i / 3;
      // intersect with circle
      final double dx =
          _circleXforY(center, radius, yOff);
      if (!dx.isNaN) {
        canvas.drawLine(
          Offset(center.dx - dx, yOff),
          Offset(center.dx + dx, yOff),
          linePaint,
        );
      }

      final double xOff = rect.left + rect.width * i / 3;
      final double dy = _circleYforX(center, radius, xOff);
      if (!dy.isNaN) {
        canvas.drawLine(
          Offset(xOff, center.dy - dy),
          Offset(xOff, center.dy + dy),
          linePaint,
        );
      }
    }
  }

  /// Half-chord length at vertical position y on a circle centred at [c] with [r].
  double _circleXforY(Offset c, double r, double y) {
    final double dy = y - c.dy;
    if (dy.abs() > r) return double.nan;
    final double val = r * r - dy * dy;
    return val > 0 ? sqrt(val) : 0;
  }

  /// Half-chord length at horizontal position x.
  double _circleYforX(Offset c, double r, double x) {
    final double dx = x - c.dx;
    if (dx.abs() > r) return double.nan;
    final double val = r * r - dx * dx;
    return val > 0 ? sqrt(val) : 0;
  }

  void _drawHandles(Canvas canvas, Offset center, double radius) {
    final handlePositions = [
      Offset(center.dx, center.dy - radius), // top
      Offset(center.dx + radius, center.dy), // right
      Offset(center.dx, center.dy + radius), // bottom
      Offset(center.dx - radius, center.dy), // left
    ];

    const double handleRadius = 6.0;

    for (final pos in handlePositions) {
      // White filled circle
      canvas.drawCircle(pos, handleRadius,
          Paint()..color = Colors.white);
      // Thin dark border for contrast
      canvas.drawCircle(
        pos,
        handleRadius,
        Paint()
          ..color = Colors.black26
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0,
      );
    }
  }

  @override
  bool shouldRepaint(_CircleCropPainter old) =>
      old.crop != crop || old.padding != padding;
}

// ---------------------------------------------------------------------------
class _BottomButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _BottomButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0x22FFFFFF),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(height: 5),
          Text(label,
              style: const TextStyle(color: Colors.white54, fontSize: 11)),
        ],
      ),
    );
  }
}
