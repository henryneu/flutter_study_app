import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileOperationPage extends StatefulWidget {
  FileOperationPage({Key key}) : super(key: key);

  @override
  _FileOperationPageState createState() => _FileOperationPageState();
}

class _FileOperationPageState extends State<FileOperationPage> {

  int _counts = 0;

  @override
  void initState() {
    super.initState();
    _readCountsDate().then((value) {
      setState(() {
        _counts = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("文件"),
      ),
      body: Center(
        child: Text("点击了 $_counts 次"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _increaseCounts,
        tooltip: "Increase",
        child: Icon(Icons.add),
      ),
    );
  }

  Future<Null> _increaseCounts() async {
    setState(() {
      _counts++;
    });
    await (await _getLocalFile()).writeAsString('$_counts');
  }

  Future<File> _getLocalFile() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    return new File('$dir/counts.txt');
  }

  Future<int> _readCountsDate() async {
    try {
      File file = await _getLocalFile();
      String date = await file.readAsString();
      return int.parse(date);
    } on FileSystemException {
      return 0;
    }
  }
}
