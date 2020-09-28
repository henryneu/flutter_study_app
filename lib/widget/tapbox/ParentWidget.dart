import 'package:first_flutter_app/widget/tapbox/TapboxB.dart';
import 'package:flutter/cupertino.dart';

class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() {
    return new _ParentWidgetState();
  }
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new TapboxB(
          active: _active,
          onChanged: _handleTapboxChanged,
      ),
    );
  }
}