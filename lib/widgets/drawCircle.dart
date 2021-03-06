import 'package:flutter/material.dart';

class DrawCircle extends CustomPainter {
  Paint _paint;
  DrawCircle() {
    _paint = Paint()..color = Colors.green;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(0.0, 0.0), 7.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
