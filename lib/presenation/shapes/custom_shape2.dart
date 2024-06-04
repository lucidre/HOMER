// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:homer/common_libs.dart';

class CustomShape2 extends CustomPainter {
  final Color color;

  CustomShape2({super.repaint, required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();

    path.moveTo(0, 20);
    path.quadraticBezierTo(0, 0, 20, 0);

    path.lineTo(size.width - 40, 0);
    path.lineTo(size.width, 40);

    path.lineTo(size.width, size.height - 20);
    path.quadraticBezierTo(
        size.width, size.height, size.width - 20, size.height);
    path.lineTo(20, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - 20);

    path.close();

    final path2 = Path();
    path2.addOval(
      Rect.fromCircle(center: Offset(size.width - 30, 30), radius: 30),
    );
    final path3 = Path();
    path3.addOval(
      Rect.fromCircle(center: Offset(size.width - 30, 30), radius: 20),
    );

    final combinedPath = Path.combine(PathOperation.difference, path, path2);

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawPath(combinedPath, paint);
    canvas.drawPath(path3, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
