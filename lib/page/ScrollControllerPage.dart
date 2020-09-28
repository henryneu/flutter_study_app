import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScrollControllerPage extends StatefulWidget {
  @override
  _ScrollControllerPageState createState() {
    return new _ScrollControllerPageState();
  }
}

class _ScrollControllerPageState extends State<ScrollControllerPage> {
  ScrollController _controller = new ScrollController();
  bool _showToTopBtn = false;
  String _progress = "0%";

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      print(_controller.offset);
      if (_controller.offset < 1000 && _showToTopBtn) {
        setState(() {
          _showToTopBtn = false;
        });
      } else if (_controller.offset >= 1000 && _showToTopBtn == false) {
        setState(() {
          _showToTopBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scroll Control'),
      ),
      body: Scrollbar(
          child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          double progress = notification.metrics.pixels /
              notification.metrics.maxScrollExtent;
          setState(() {
            _progress = "${(progress * 100).toInt()}%";
          });
          print("BottomEdge: ${notification.metrics.extentAfter == 0}");
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ListView.builder(
                itemCount: 100,
                itemExtent: 50.0,
                controller: _controller,
                itemBuilder: (context, index) {
                  return ListTile(title: Text("$index"));
                }),
            CircleAvatar(
              radius: 30.0,
              child: Text(_progress),
              backgroundColor: Colors.black54,
            ),
          ],
        ),
      )),
      floatingActionButton: !_showToTopBtn
          ? null
          : FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                _controller.animateTo(.0,
                    duration: Duration(milliseconds: 200), curve: Curves.ease);
              },
            ),
    );
  }
}
