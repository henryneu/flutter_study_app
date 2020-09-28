import 'package:flutter/material.dart';

/// TabView 点击选中回调
typedef OnTabViewerSelected = void Function(int index);

/// 自定义 TabView
class CustomTabView extends StatelessWidget {
  CustomTabView(this.tabTitles, this.selectedIndex,
      {Key key,
      this.onTabSelected,
      this.backgroundColor,
      this.tabTextSelectedColor,
      this.tabTextUnSelectColor})
      : super(key: key);

  static const double HEIGHT = 46;
  static const double RADIUS = 10;

  // 选中 tab 背景色
  static const Color COLOR_WHITE = Color(0xfffcfcfc);

  // 未选中 tab 背景色-可变的
  static const Color COLOR_BLACK = Color(0xff2d2c2b);

  // 选中 tab 文字颜色-可变的
  static const Color SelectTextColor = Color(0xffe0465e);

  // 未选中 tab 文字颜色
  static const Color UnSelectTextColor = Color(0xffffffff);

  final List<String> tabTitles;
  final int selectedIndex;
  final OnTabViewerSelected onTabSelected;
  final Color backgroundColor;
  final Color tabTextSelectedColor; // 选中 title 文字颜色
  final Color tabTextUnSelectColor; // 未选中 title 文字颜色

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [];
    for (int i = 0; i < tabTitles.length; i++) {
      Radius topLeft = Radius.zero;
      Radius topRight = Radius.zero;
      Radius bottomLeft = Radius.zero;
      Radius bottomRight = Radius.zero;
      if (selectedIndex == i) {
        topLeft = Radius.circular(RADIUS);
        topRight = Radius.circular(RADIUS);
        bottomLeft = Radius.zero;
        bottomRight = Radius.zero;
      } else {
        topLeft = Radius.zero;
        topRight = Radius.zero;
        if (i == selectedIndex + 1) {
          bottomLeft = Radius.circular(RADIUS);
        } else if (i == selectedIndex - 1) {
          bottomRight = Radius.circular(RADIUS);
        }
      }

      tabs.add(Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () {
            if (onTabSelected != null) {
              onTabSelected(i);
            }
          },
          child: TabViewItem(
            bgColor: selectedIndex == i
                ? (this.backgroundColor ?? COLOR_BLACK)
                : COLOR_WHITE,
            fgColor: selectedIndex == i
                ? COLOR_WHITE
                : (this.backgroundColor ?? COLOR_BLACK),
            title: tabTitles[i],
            isSelected: selectedIndex == i,
            textTitleUnSelectColor: this.tabTextUnSelectColor,
            textTitleSelectColor: this.tabTextSelectedColor,
            radius: BorderRadius.only(
                topLeft: topLeft,
                topRight: topRight,
                bottomLeft: bottomLeft,
                bottomRight: bottomRight),
          ),
        ),
      ));
    }
    return Container(
      height: HEIGHT,
      decoration: BoxDecoration(
          color: SelectTextColor,
          borderRadius: new BorderRadius.all(const Radius.circular(10.0))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: tabs,
      ),
    );
  }
}

class TabViewItem extends StatelessWidget {
  final Color bgColor;
  final Color fgColor;

  final BorderRadius radius;

  final String title;
  final bool isSelected;

  final Color textTitleSelectColor; // 选中 title 文字颜色
  final Color textTitleUnSelectColor; // 未选中 title 文字颜色

  TabViewItem({
    Key key,
    this.title,
    this.bgColor,
    this.fgColor,
    this.radius,
    this.isSelected = false,
    this.textTitleSelectColor,
    this.textTitleUnSelectColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color titleColor = isSelected
        ? (this.textTitleSelectColor ?? Color(0xff151515))
        : (this.textTitleUnSelectColor ?? Color(0xffd9cab5));
    return Container(
      color: bgColor,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(color: fgColor, borderRadius: radius),
        // child: child,
        child: Text(
          title,
          style: TextStyle(
              color: titleColor, fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
