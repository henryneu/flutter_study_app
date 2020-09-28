import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketPage extends StatefulWidget {
  @override
  _WebSocketPageState createState() => _WebSocketPageState();
}

class _WebSocketPageState extends State<WebSocketPage> {
  TextEditingController _editingController;
  IOWebSocketChannel channel;
  String _text = "";

  @override
  void initState() {
    super.initState();
    _editingController = new TextEditingController();
    channel = new IOWebSocketChannel.connect('ws://echo.websocket.org');
  }

  @override
  void dispose() {
    _editingController.dispose();
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("WebSocket回显")),
      body: new Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              child: new TextFormField(
                controller: _editingController,
                decoration: InputDecoration(labelText: "Send a message"),
              ),
            ),
            StreamBuilder(
              stream: channel.stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  _text = "网络不通...";
                } else if (snapshot.hasData) {
                  _text = "echo: " + snapshot.data;
                }
                return new Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Text(_text));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
          onPressed: _sendMessage,
          tooltip: 'Send Message',
          child: new Icon(Icons.send)),
    );
  }

  void _sendMessage() {
    if (_editingController.text.isNotEmpty) {
      channel.sink.add(_editingController.text);
    }
  }
}
