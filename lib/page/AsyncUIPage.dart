import 'package:first_flutter_app/widget/DialogCheckBox.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AsyncUIPage extends StatefulWidget {
  @override
  _AsyncUIPageState createState() {
    return new _AsyncUIPageState();
  }
}

Future<String> mockNetworkData() async {
  return Future.delayed(Duration(seconds: 2), () => "网络返回数据");
}

Stream<int> counter() {
  return Stream.periodic(Duration(seconds: 1), (i) {
    return i;
  });
}

class _AsyncUIPageState extends State<AsyncUIPage> {
  bool withTree = false;
  bool _toggle = false;

  double _top = 0.0;
  double _left = 0.0;

  TapGestureRecognizer _tapGestureRecognizer = new TapGestureRecognizer();

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("异步UI更新"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            FutureBuilder<String>(
              future: mockNetworkData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    return Text("Content: ${snapshot.data}");
                  }
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            Divider(
              height: 24.0,
              color: Colors.blue,
            ),
            StreamBuilder<int>(
              stream: counter(),
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    return Text("Stream已关闭");
                  case ConnectionState.none:
                    return Text("没有Stream");
                  case ConnectionState.active:
                    return Text("active: ${snapshot.data}");
                  case ConnectionState.waiting:
                    return Text("等待数据...");
                }
                return null;
              },
            ),
            RaisedButton(
              child: Text("对话框1"),
              onPressed: () async {
                bool delete = await showDeleteConfirmDialog1();
                if (delete == null) {
                  print("取消删除");
                } else {
                  print("已确认删除");
                }
              },
            ),
            RaisedButton(
              child: Text("对话框2"),
              onPressed: () async {
                choiceLanguage();
              },
            ),
            RaisedButton(
              child: Text("对话框3"),
              onPressed: () async {
                showListDialog();
              },
            ),
            RaisedButton(
              child: Text("自定义缩放动画对话框"),
              onPressed: () async {
                showCustomDialog1();
              },
            ),
            RaisedButton(
              child: Text("对话框1(复选框)"),
              onPressed: () async {
                bool delete = await showDeleteConfirmDialog3();
                if (delete == null) {
                  print("取消删除");
                } else {
                  print("同时删除子目录: $delete");
                }
              },
            ),
            Divider(
              height: 20.0,
              color: Colors.blue,
            ),
            Text.rich(
              TextSpan(children: [
                TextSpan(text: "你好世界"),
                TextSpan(
                    text: "点击变色",
                    style: TextStyle(
                        fontSize: 24.0,
                        color: _toggle ? Colors.blue : Colors.red),
                    recognizer: _tapGestureRecognizer
                      ..onTap = () {
                        setState(() {
                          _toggle = !_toggle;
                        });
                      }),
                TextSpan(text: "你好世界"),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> showDeleteConfirmDialog1() {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Text("您确认要删除当前文件吗？"),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text("删除"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }

  Future<void> choiceLanguage() async {
    int i = await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text("请选择语言"),
            children: <Widget>[
              SimpleDialogOption(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: const Text("中文简体"),
                ),
                onPressed: () {
                  Navigator.pop(context, 1);
                },
              ),
              SimpleDialogOption(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: const Text("英语"),
                ),
                onPressed: () {
                  Navigator.pop(context, 2);
                },
              )
            ],
          );
        });
    if (i != null) {
      print("选择了: ${i == 1 ? "中文简体" : "英语"}");
    }
  }

  Future<void> showListDialog() async {
    int index = await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          var child = Column(
            children: <Widget>[
              ListTile(
                title: Text("请选择"),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 30,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text("$index"),
                      onTap: () => Navigator.of(context).pop(index),
                    );
                  },
                ),
              ),
            ],
          );
          //return Dialog(child: child);
          return UnconstrainedBox(
            constrainedAxis: Axis.vertical,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 280),
              child: Material(
                child: child,
                type: MaterialType.card,
              ),
            ),
          );
        });
    if (index != null) {
      print("点击了: $index");
    }
  }

  Future<T> showCustomDialog<T>({
    @required BuildContext context,
    bool barrierDismissible = true,
    WidgetBuilder builder,
  }) {
    final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
    return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        final Widget pageChild = Builder(builder: builder);
        return SafeArea(
          child: Builder(
            builder: (BuildContext context) {
              return theme != null
                  ? Theme(data: theme, child: pageChild)
                  : pageChild;
            },
          ),
        );
      },
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black26,
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder: _buildMaterialDialogTransitions,
    );
  }

  Widget _buildMaterialDialogTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    );
  }

  Future<bool> showCustomDialog1() {
    return showCustomDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Text("您确认要删除当前文件吗？"),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text("删除"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }

  Future<bool> showDeleteConfirmDialog2() {
    withTree = false;
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("您确定要删除当前文件吗?"),
                Row(
                  children: <Widget>[
                    Text("同时删除子目录？"),
                    Checkbox(
                      value: withTree,
                      onChanged: (bool value) {
                        setState(() {
                          withTree = !withTree;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text("删除"),
                onPressed: () {
                  Navigator.of(context).pop(withTree);
                },
              ),
            ],
          );
        });
  }

  Future<bool> showDeleteConfirmDialog3() {
    bool _withTree = false;
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("您确定要删除当前文件吗?"),
                Row(
                  children: <Widget>[
                    Text("同时删除子目录？"),
                    DialogCheckBox(
                      onChanged: (bool value) {
                        _withTree = !_withTree;
                      },
                      value: _withTree,
                    ),
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text("删除"),
                onPressed: () {
                  Navigator.of(context).pop(_withTree);
                },
              ),
            ],
          );
        });
  }
}
