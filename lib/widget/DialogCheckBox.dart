import 'package:flutter/material.dart';

class DialogCheckBox extends StatefulWidget {
  DialogCheckBox({Key key, @required this.onChanged, this.value});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  _DialogCheckBoxState createState() {
    return new _DialogCheckBoxState();
  }
}

class _DialogCheckBoxState extends State<DialogCheckBox> {
  bool value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (v) {
        widget.onChanged(v);
        setState(() {
          value = v;
        });
      },
    );
  }
}
