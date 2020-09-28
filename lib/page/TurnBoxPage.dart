import 'package:first_flutter_app/widget/GradientButton.dart';
import 'package:first_flutter_app/widget/TurnBox.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TurnBoxPage extends StatefulWidget {
  @override
  _TurnBoxPageState createState() => _TurnBoxPageState();
}

onTap() {
  print("button click");
  Fluttertoast.showToast(
      msg: "click button",
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 14.0);
}

class _TurnBoxPageState extends State<TurnBoxPage> {
  double _turns = .0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("自定义TurnBox"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TurnBox(
              turns: _turns,
              speed: 500,
              child: Icon(
                Icons.refresh,
                size: 50,
              ),
            ),
            TurnBox(
              turns: _turns,
              speed: 1000,
              child: Icon(
                Icons.refresh,
                size: 150.0,
              ),
            ),
            RaisedButton(
              child: Text("顺时针旋转1/5圈"),
              onPressed: () {
                setState(() {
                  _turns += .2;
                });
              },
            ),
            RaisedButton(
              child: Text("逆时针旋转1/5圈"),
              onPressed: () {
                setState(() {
                  _turns -= .2;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
