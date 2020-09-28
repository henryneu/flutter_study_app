import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class InfiniteGridViewPage extends StatefulWidget {
  @override
  _InfiniteGridViewPageState createState() {
    return new _InfiniteGridViewPageState();
  }
}

class _InfiniteGridViewPageState extends State<InfiniteGridViewPage> {
  List<IconData> _icons = []; // icon数据

  @override
  void initState() {
    super.initState();
    _retrieveIconData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('商标分类'),
      ),
      body: Column(
        children: <Widget>[
          ListTile(title: Text('商标列表')),
          Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.0,
                  ),
                  itemBuilder: (context, index) {
                    if (index == _icons.length - 1 && _icons.length < 200) {
                      _retrieveIconData();
                    }
                    return Icon(_icons[index]);
                  },
                  itemCount: _icons.length)),
        ],
      ),
    );
  }

  void _retrieveIconData() {
    Future.delayed(Duration(milliseconds: 200)).then((e) {
      setState(() {
        // 重新构建列表
        _icons.addAll([
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access,
          Icons.cake,
          Icons.free_breakfast
        ]);
      });
    });
  }
}
