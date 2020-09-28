import 'package:first_flutter_app/widget/GradientButton.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GradientButtonPage extends StatefulWidget {
  @override
  _GradientButtonPageState createState() => _GradientButtonPageState();
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

class _GradientButtonPageState extends State<GradientButtonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("自定义Button"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            GradientButton(
              colors: [Colors.orange, Colors.red],
              height: 50.0,
              borderRadius: BorderRadius.circular(10.0),
              child: Text("Submit"),
              onPressed: onTap,
            ),
            GradientButton(
              colors: [Colors.lightGreen, Colors.green[700]],
              height: 50.0,
              borderRadius: BorderRadius.circular(10.0),
              child: Text("Submit"),
              onPressed: onTap,
            ),
            GradientButton(
              colors: [Colors.lightBlue, Colors.blueAccent],
              height: 50.0,
              borderRadius: BorderRadius.circular(10.0),
              child: Text("Submit"),
              onPressed: onTap,
            ),
          ],
        ),
      ),
    );
  }
}
