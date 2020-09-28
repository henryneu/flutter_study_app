import 'package:flutter/material.dart';

class NotificationSendPage extends StatefulWidget {
  @override
  _NotificationSendPageState createState() {
    return new _NotificationSendPageState();
  }
}

class _NotificationSendPageState extends State<NotificationSendPage> {
  String _msg = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("通知"),
      ),
      body: NotificationListener<CustomNotification>(
        onNotification: (notification) {
          setState(() {
            _msg += notification.msg + " ";
          });
          return true;
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Builder(
                builder: (context) {
                  return RaisedButton(
                    onPressed: () =>
                        CustomNotification("Perfect").dispatch(context),
                    child: Text("Send Notification"),
                  );
                },
              ),
              Text(_msg),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomNotification extends Notification {
  CustomNotification(this.msg);

  final String msg;
}
