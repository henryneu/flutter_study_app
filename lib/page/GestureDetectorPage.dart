import 'package:flutter/material.dart';

class GestureDetectorPage extends StatefulWidget {
  @override
  _GestureDetectorPageState createState() {
    return new _GestureDetectorPageState();
  }
}

class _GestureDetectorPageState extends State<GestureDetectorPage> {
  double _top = 0.0;
  double _left = 0.0;
  double _leftB = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("手势检测识别"),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: _top,
            left: _left,
            child: GestureDetector(
              child: CircleAvatar(
                child: Text("A"),
              ),
              onVerticalDragUpdate: (DragUpdateDetails details) {
                setState(() {
                  _top += details.delta.dy;
                });
              },
              onHorizontalDragUpdate: (DragUpdateDetails details) {
                setState(() {
                  _left += details.delta.dx;
                });
              },
              onHorizontalDragEnd: (details) {
                print("Gesture onHorizontalDragEnd");
              },
              onTapDown: (details) {
                print("Gesture down");
              },
              onTapUp: (details) {
                print("Gesture up");
              },
            ),
          ),
          Positioned(
            top: 80.0,
            left: _leftB,
            child: Listener(
              onPointerDown: (details) {
                print("Listener down");
              },
              onPointerUp: (details) {
                //会触发
                print("Listener up");
              },
              child: GestureDetector(
                child: CircleAvatar(child: Text("B")),
                onHorizontalDragUpdate: (DragUpdateDetails details) {
                  setState(() {
                    _leftB += details.delta.dx;
                  });
                },
                onHorizontalDragEnd: (details) {
                  print("Listener onHorizontalDragEnd");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
