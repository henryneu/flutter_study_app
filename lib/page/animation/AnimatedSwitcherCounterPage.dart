import 'package:first_flutter_app/page/animation/AnimatedDecoratedBoxPage.dart';
import 'package:flutter/material.dart';

class AnimatedSwitcherCounterPage extends StatefulWidget {
  AnimatedSwitcherCounterPage({Key key}) : super(key: key);

  @override
  _AnimatedSwitcherCounterPageState createState() {
    return new _AnimatedSwitcherCounterPageState();
  }
}

class _AnimatedSwitcherCounterPageState
    extends State<AnimatedSwitcherCounterPage> {
  int _count = 0;

  Color _decorationColor = Colors.blue;
  var duration = Duration(seconds: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("通用动画"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                var tween =
                    Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
                return CustomSlideTransition(
                  child: child,
                  direction: AxisDirection.right,
                  position: animation,
                );
                //return ScaleTransition(child: child, scale: animation);
              },
              child: Text(
                '$_count',
                key: ValueKey<int>(_count),
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            RaisedButton(
              child: const Text('+1'),
              onPressed: () {
                setState(() {
                  _count += 1;
                });
              },
            ),
            AnimatedDecoratedBox(
              duration: duration,
              decoration: BoxDecoration(color: _decorationColor),
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    _decorationColor = Colors.red;
                  });
                },
                child: Text(
                  "AnimatedDecoratedBox",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomSlideTransition extends AnimatedWidget {
  CustomSlideTransition(
      {Key key,
      @required Animation<double> position,
      this.transformHitTests = true,
      this.direction = AxisDirection.down,
      this.child})
      : assert(position != null),
        super(key: key, listenable: position) {
    switch (direction) {
      case AxisDirection.up:
        _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
        break;
      case AxisDirection.right:
        _tween = Tween(begin: Offset(-1, 0), end: Offset(0, 0));
        break;
      case AxisDirection.down:
        _tween = Tween(begin: Offset(0, -1), end: Offset(0, 0));
        break;
      case AxisDirection.left:
        _tween = Tween(begin: Offset(1, 0), end: Offset(0, 0));
        break;
    }
  }

  Animation<double> get position => listenable;
  final bool transformHitTests;
  final AxisDirection direction;
  final Widget child;
  Tween<Offset> _tween;

  @override
  Widget build(BuildContext context) {
    Offset offset = _tween.evaluate(position);
    if (position.status == AnimationStatus.reverse) {
      switch (direction) {
        case AxisDirection.up:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.right:
          offset = Offset(-offset.dx, offset.dy);
          break;
        case AxisDirection.down:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.left:
          offset = Offset(-offset.dx, offset.dy);
          break;
      }
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}
