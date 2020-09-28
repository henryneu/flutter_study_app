import 'package:flutter/material.dart';

enum ToastPosition {
  top,
  center,
  bottom,
}

class Toast {
  static OverlayEntry _overlayEntry;
  static bool _showing = false;
  static DateTime _startedTime;
  static String _msg;
  static int _showTime;
  static Color _bgColor;
  static Color _textColor;
  static double _textSize;
  static ToastPosition _toastPosition;
  static double _pdHorizontal;
  static double _pdVertical;

  static void toast(
    BuildContext context, {
    String msg,
    int showTime = 2000,
    Color bgColor = Colors.black,
    Color textColor = Colors.white,
    double textSize = 14.0,
    ToastPosition position = ToastPosition.center,
    double pdHorizontal = 20.0,
    double pdVertical = 10.0,
  }) async {
    assert(msg != null);
    _msg = msg;
    _startedTime = DateTime.now();
    _showTime = showTime;
    _bgColor = bgColor;
    _textColor = textColor;
    _textSize = textSize;
    _toastPosition = position;
    _pdHorizontal = pdHorizontal;
    _pdVertical = pdVertical;
    // 获取 OverlayState
    OverlayState overlayState = Overlay.of(context);
    _showing = true;
    if (_overlayEntry == null) {
      // OverlayEntry 构建布局,通过 OverlayState
      // 将构建好的布局插入到整个布局的最上层
      _overlayEntry = OverlayEntry(
          builder: (BuildContext context) => Positioned(
                // Toast 在屏幕中的显示位置
                top: buildToastPosition(context),
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: AnimatedOpacity(
                      // 透明度
                      opacity: _showing ? 1.0 : 0.0,
                      duration: _showing
                          ? Duration(milliseconds: 100)
                          : Duration(milliseconds: 400),
                      child: _buildToastWidget(),
                    ),
                  ),
                ),
              ));
      overlayState.insert(_overlayEntry);
    } else {
      // 重绘 UI, 原理和 setState 类似
      _overlayEntry.markNeedsBuild();
    }
    // Toast 的显示时长
    await Future.delayed(Duration(milliseconds: _showTime));
    // 显示时长过后, 移除 Toast
    if (DateTime.now().difference(_startedTime).inMilliseconds >= _showTime) {
      _showing = false;
      _overlayEntry.markNeedsBuild();
      await Future.delayed(Duration(milliseconds: 400));
      _overlayEntry.remove();
      _overlayEntry = null;
    }
  }

  // 设置 Toast 位置
  static buildToastPosition(BuildContext context) {
    var backResult;
    if (_toastPosition == ToastPosition.top) {
      backResult = MediaQuery.of(context).size.height * 1 / 4;
    } else if (_toastPosition == ToastPosition.center) {
      backResult = MediaQuery.of(context).size.height * 2 / 5;
    } else {
      backResult = MediaQuery.of(context).size.height * 3 / 4;
    }
    return backResult;
  }

  // 绘制 Toast
  static _buildToastWidget() {
    return Center(
      child: Card(
        color: _bgColor,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: _pdHorizontal, vertical: _pdVertical),
          child: Text(
            _msg,
            style: TextStyle(fontSize: _textSize, color: _textColor),
          ),
        ),
      ),
    );
  }
}
