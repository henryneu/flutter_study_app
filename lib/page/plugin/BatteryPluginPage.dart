import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BatteryPluginPage extends StatefulWidget {
  @override
  _BatteryPluginPageState createState() => _BatteryPluginPageState();
}

class _BatteryPluginPageState extends State<BatteryPluginPage> {
  static const platform = const MethodChannel('samples.flutter.io/battery');

  String _batteryLevel = 'UnKnown battery level';

  Future<Null> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result %.';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("获取电池电量")),
      body: Material(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                onPressed: _getBatteryLevel,
                child: new Text("Get Battery Level"),
              ),
              Text(_batteryLevel),
            ],
          ),
        ),
      ),
    );
  }
}
