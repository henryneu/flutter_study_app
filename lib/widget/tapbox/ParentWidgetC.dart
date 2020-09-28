
import 'package:first_flutter_app/widget/tapbox/TapboxC.dart';
import 'package:flutter/cupertino.dart';

class ParentWidgetC extends StatefulWidget {
  @override
  _ParentWidgetCState createState() {
    return new _ParentWidgetCState();
  }
}

class _ParentWidgetCState extends State<ParentWidgetC> {

  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new TapboxC(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}