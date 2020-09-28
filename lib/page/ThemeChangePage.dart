import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeChangePage extends StatefulWidget {
  @override
  _ThemeChangePageState createState() {
    return new _ThemeChangePageState();
  }
}

class _ThemeChangePageState extends State<ThemeChangePage> {
  Color _themeColor = Colors.teal;

  @override
  Widget build(BuildContext context) {
    // 获取当前路由主题颜色
    ThemeData themeData = Theme.of(context);
    return Theme(
      data: ThemeData(
          primarySwatch: _themeColor,
          iconTheme: IconThemeData(color: _themeColor)),
      child: Scaffold(
        appBar: AppBar(
          title: Text("主题颜色测试"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.favorite),
                Icon(Icons.airport_shuttle),
                Text("  颜色跟随主题")
              ],
            ),
            Theme(
              data: themeData.copyWith(
                  iconTheme: themeData.iconTheme.copyWith(color: Colors.black)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.favorite),
                  Icon(Icons.airport_shuttle),
                  Text("  颜色固定黑色")
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              setState(
                      () =>
                  _themeColor =
                  _themeColor == Colors.teal ? Colors.blue : Colors.teal
              ),
          child: Icon(Icons.palette),
        ),
      ),
    );
  }
}
