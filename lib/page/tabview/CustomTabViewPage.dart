import 'package:first_flutter_app/widget/tabview/CustomTabView.dart';
import 'package:flutter/material.dart';

class CustomTabViewPage extends StatefulWidget {
  @override
  _CustomTabViewPageState createState() {
    return new _CustomTabViewPageState();
  }
}

class _CustomTabViewPageState extends State<CustomTabViewPage> {

  List<String> tabs = [];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    tabs.add("好评榜");
    tabs.add("热销榜");
    tabs.add("回购榜");
  }

  void onTabSelected(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("测试自定义TabView"),
        ),
        body:Column(
          children: <Widget>[
            CustomTabView(tabs, selectedIndex, onTabSelected: onTabSelected),
          ],
        )
    );
  }
}