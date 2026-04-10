import 'dart:math';
import 'package:flutter/material.dart';

class DiamondPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.03)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    // Create diamond grid pattern
    final diamondSize = size.width / 15;
    final rows = (size.height / diamondSize).ceil() + 1;
    final cols = (size.width / diamondSize).ceil() + 1;

    for (int i = -1; i < rows; i++) {
      for (int j = -1; j < cols; j++) {
        final path = Path();
        final centerX = j * diamondSize + (i % 2 == 0 ? 0 : diamondSize / 2);
        final centerY = i * diamondSize;

        path.moveTo(centerX, centerY - diamondSize / 2);
        path.lineTo(centerX + diamondSize / 2, centerY);
        path.lineTo(centerX, centerY + diamondSize / 2);
        path.lineTo(centerX - diamondSize / 2, centerY);
        path.close();

        canvas.drawPath(path, borderPaint);
      }
    }

    // Add some sparkle effects
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..style = PaintingStyle.fill;

    final random = Random(42); // Fixed seed for consistent pattern
    for (int i = 0; i < 20; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = 0.8 + random.nextDouble() * 1.2;

      canvas.drawCircle(Offset(x, y), radius, paint);
    }

    // Add subtle gold gradient glow
    final gradientPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFD4AF37).withValues(alpha: 0.08),
          Colors.transparent,
        ],
        radius: 1.0,
        center: Alignment.center,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      gradientPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
