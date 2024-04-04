import 'package:flutter/material.dart';
import 'package:quiz_app/config/Themes/app_colors.dart';

class BackgroundDecorationWidget extends StatelessWidget {
  const BackgroundDecorationWidget({super.key, required this.child, this.showCustomGradient = false});

  final Widget child;
  final bool showCustomGradient;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: showCustomGradient ? null : Theme.of(context).primaryColorLight,
              gradient: showCustomGradient ? getGradient() : null,
            ),
            child: CustomPaint(
              painter: BackgroundPainter(),
            ),
          ),
        ),
        Positioned(child: child),
      ],
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // ** The '..' syntax make it possible to assign a value to a data member without explicitly creating a new object for that purpose.
    Paint paint = Paint()..color = Colors.white.withOpacity(0.1);
    // ** path is used to trace the path we want using x,y coords.
    Path path = Path();
    // Initial point
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.3, 0);
    path.lineTo(0, size.height * 0.6);
    path.close();

    canvas.drawPath(path, paint);

    Path path1 = Path();
    path1.moveTo(size.width, 0);
    path1.lineTo(size.width * 0.8, 0);
    path1.lineTo(size.width * 0.3, size.height);
    path1.lineTo(size.width, size.height);
    path1.close();

    canvas.drawPath(path1, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
