import 'package:flutter/material.dart';

class TurnBox extends StatefulWidget {
  TurnBox({Key key, this.turns = .0, this.speed = 200, this.child})
      : super(key: key);

  final double turns;
  final int speed;
  final Widget child;

  @override
  _TurnBoxState createState() => _TurnBoxState();
}

class _TurnBoxState extends State<TurnBox> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      lowerBound: -double.infinity,
      upperBound: double.infinity,
    );
    _animationController.value = widget.turns;
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animationController,
      child: widget.child,
    );
  }

  @override
  void didUpdateWidget(TurnBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.turns != widget.turns) {
      _animationController.animateTo(
        widget.turns,
        duration: Duration(milliseconds: widget.speed ?? 200),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
