// ignore_for_file: use_build_context_synchronously

import 'package:homer/common_libs.dart';

class CustomShape extends CustomPainter {
  final bool isMin;

  CustomShape({super.repaint, required this.isMin});
  @override
  void paint(Canvas canvas, Size size) {
    final halfWidth = size.width / 2;
    final path = Path();
    const middle = 50.0;
    const desent = 10.0;
    path.moveTo(0, 20);
    path.quadraticBezierTo(
      0,
      0,
      20,
      0,
    );
    if (isMin) {
      path.lineTo(halfWidth - middle - 40, 0);

      path.quadraticBezierTo(
        halfWidth - middle - 30,
        0,
        halfWidth - middle - 20,
        desent,
      );

      path.quadraticBezierTo(
        halfWidth - middle - 10,
        desent * 2,
        halfWidth - middle,
        desent * 2,
      );

      path.lineTo(halfWidth + middle, desent * 2);
      path.quadraticBezierTo(
        halfWidth + middle + 10,
        desent * 2,
        halfWidth + middle + 20,
        desent,
      );
      path.quadraticBezierTo(
        halfWidth + middle + 30,
        0,
        halfWidth + middle + 40,
        0,
      );
    }
    path.lineTo(size.width - 20, 0);

    path.quadraticBezierTo(
      size.width,
      0,
      size.width,
      20,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();

    final path2 = Path();
    path2.moveTo(halfWidth - middle, 0);
    path2.lineTo(halfWidth + middle, 0);
    path2.quadraticBezierTo(
      halfWidth + middle + 2,
      2,
      halfWidth + middle,
      4,
    );
    path2.lineTo(halfWidth - middle, 4);
    path2.quadraticBezierTo(
      halfWidth - middle - 2,
      2,
      halfWidth - middle,
      0,
    );
    path2.close();

    final gradient = LinearGradient(
      colors: backgroundGradient,
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
    );

    final paint = Paint()
      ..shader = gradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      )
      ..style = PaintingStyle.fill;

    if (isMin) canvas.drawPath(path2, paint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomShape oldDelegate) =>
      oldDelegate.isMin != isMin;
}
