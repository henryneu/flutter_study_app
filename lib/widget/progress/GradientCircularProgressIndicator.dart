import 'dart:math';

import 'package:flutter/material.dart';

class GradientCircularProgressIndicator extends StatelessWidget {
  GradientCircularProgressIndicator(
      {this.strokeWidth = 2.0,
      @required this.radius,
      @required this.colors,
      this.stops,
      this.strokeCapRound = false,
      this.backgroundColor = const Color(0xFFEEEEEE),
      this.totalAngle = 2 * pi,
      this.value});

  ///粗细
  final double strokeWidth;

  /// 圆的半径
  final double radius;

  /// 渐变色数组
  final List<Color> colors;

  /// 渐变色的终止点，对应colors属性
  final List<double> stops;

  ///两端是否为圆角
  final bool strokeCapRound;

  /// 进度条背景色
  final Color backgroundColor;

  /// 进度条的总弧度，2*PI为整圆，小于2*PI则不是整圆
  final double totalAngle;

  /// 当前进度，取值范围 [0.0-1.0]
  final double value;

  @override
  Widget build(BuildContext context) {
    double _offset = .0;

    if (strokeCapRound) {
      _offset = asin(strokeWidth / (radius * 2 - strokeWidth));
    }

    var _colors = colors;
    if (_colors == null) {
      Color color = Theme.of(context).accentColor;
      _colors = [color, color];
    }

    return Transform.rotate(
      angle: -pi / 2.0 - _offset,
      child: CustomPaint(
        size: Size.fromRadius(radius),
        painter: _GradientCircularProgressPainter(
          strokeWidth: strokeWidth,
          radius: radius,
          colors: _colors,
          strokeCapRound: strokeCapRound,
          backgroundColor: backgroundColor,
          value: value,
          total: totalAngle,
        ),
      ),
    );
  }
}

class _GradientCircularProgressPainter extends CustomPainter {
  _GradientCircularProgressPainter(
      {this.strokeWidth: 10.0,
      this.radius,
      @required this.colors,
      this.stops,
      this.strokeCapRound: false,
      this.backgroundColor = const Color(0xFFEEEEEE),
      this.total = 2 * pi,
      this.value});

  final double strokeWidth;
  final double radius;
  final List<Color> colors;
  final List<double> stops;
  final bool strokeCapRound;
  final Color backgroundColor;
  final double total;
  final double value;

  @override
  void paint(Canvas canvas, Size size) {
    if (radius != null) {
      size = Size.fromRadius(radius);
    }
    double _offset = strokeWidth / 2.0;
    double _value = (value ?? .0);
    _value = _value.clamp(.0, 1.0) * total;
    double _start = .0;

    if (strokeCapRound) {
      _start = asin(strokeWidth/ (size.width - strokeWidth));
    }

    Rect rect = Offset(_offset, _offset) & Size(
        size.width - strokeWidth,
        size.height - strokeWidth
    );

    var paint = Paint()
      ..strokeCap = strokeCapRound ? StrokeCap.round : StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth;

    if (backgroundColor != Colors.transparent) {
      paint.color = backgroundColor;
      canvas.drawArc(rect, _start, total, false, paint);
    }

    if (_value > 0) {
      paint.shader = SweepGradient(
        startAngle: 0.0,
        endAngle: _value,
        colors: colors,
        stops: stops,
      ).createShader(rect);
      canvas.drawArc(rect, _start, _value, false, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
