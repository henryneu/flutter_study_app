import 'dart:math';

import 'package:flutter/material.dart';

class CustomPainterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("五子棋"),
      ),
      body: Center(
        child: CustomPaint(
          size: Size(300, 300),
          painter: ChessPainter(),
        ),
      ),
    );
  }
}

class ChessPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double eWidth = size.width / 15;
    double eHeight = size.height / 15;

    // 绘制棋盘
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = Color(0x77cdb175);
    canvas.drawRect(Offset.zero & size, paint);

    // 绘制网格
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.black87
      ..strokeWidth = 1.0;

    // 绘制横线
    for (int i = 0; i <= 15; i++) {
      double dy = i * eHeight;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }

    // 绘制竖线
    for (int i = 0; i <= 15; i++) {
      double dx = i * eHeight;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }

    // 绘制黑棋
    paint
      ..style = PaintingStyle.fill
      ..color = Colors.black;
    canvas.drawCircle(
        Offset(size.width / 2 + eWidth / 2, size.height / 2 - eHeight / 2),
        min(eWidth / 2, eHeight / 2) - 2,
        paint);

    // 绘制白棋
    paint
      ..style = PaintingStyle.fill
      ..color = Colors.white;
    canvas.drawCircle(
        Offset(size.width / 2 - eWidth / 2, size.height / 2 - eHeight / 2),
        min(eWidth / 2, eHeight / 2) - 2,
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
