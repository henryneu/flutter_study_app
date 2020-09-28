import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() {
    return new _CounterWidgetState();
  }
}

class CounterDisplayWidget extends StatelessWidget {

  CounterDisplayWidget({this.count});

  // Widget 子类中的字段往往都会定义为 "final"
  final int count;

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: new Text(
          'Count: $count',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
      ),
    );
  }
}

class CounterIncrementWidget extends StatelessWidget {

  CounterIncrementWidget({this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
      onPressed: onPressed,
      child: new Text('Increment'),
    );
  }
}

class _CounterWidgetState extends State<CounterWidget> {
  int _count = 0;

  void _increment() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new CounterDisplayWidget(
          count: _count,
        ),
        new CounterIncrementWidget(
          onPressed: _increment,
        ),
      ],
    );
  }
}