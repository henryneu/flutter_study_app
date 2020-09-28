import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:fluttertoast/fluttertoast.dart';

final EdgeInsets _listVerticalPadding =
    EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0);
final EdgeInsets _listHorizontalPadding =
    EdgeInsets.symmetric(horizontal: 16.0);

class InfiniteListViewPage extends StatefulWidget {
  @override
  _InfiniteListViewPageState createState() {
    return new _InfiniteListViewPageState();
  }
}

class _InfiniteListViewPageState extends State<InfiniteListViewPage> {
  static const loadingTag = "##loading##"; //表尾标记
  var _words = <String>[loadingTag];

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('商品分类'),
      ),
      //body: _getListViewConstruction(),
      //body: _getListViewBuilder(_words),
      body: _getListViewSeparatedHorizontal(_words),
      //body: _getListViewSeparatedVertical(_words),
      //body: _getListViewCustom(_words),
    );
  }

  void _retrieveData() {
    Future.delayed(Duration(seconds: 2)).then((e) {
      setState(() {
        // 重新构建列表
        _words.insertAll(
            _words.length - 1,
            // 每次生成20个单词
            generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
      });
    });
  }
}

class _CommonItem extends StatelessWidget {
  _CommonItem({@required this.stringItem});

  final String stringItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      width: 200.0,
      //height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0), color: Colors.blue),
      child: ListTile(
        onTap: () {
          Fluttertoast.showToast(
              msg: stringItem,
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 14.0);
        },
        title: Text(stringItem),
      ),
    );
  }
}

/// 1、构造函数
Widget _getListViewConstruction() {
  return Column(
    children: <Widget>[
      ListTile(title: Text('商品列表')),
      Expanded(
        child: ListView(
          children: <Widget>[
            ListTile(title: Text('商品1')),
            ListTile(title: Text('商品2')),
            ListTile(title: Text('商品3')),
            ListTile(title: Text('商品4')),
            ListTile(title: Text('商品5')),
            ListTile(title: Text('商品6')),
            ListTile(title: Text('商品7')),
            ListTile(title: Text('商品8')),
            ListTile(title: Text('商品9')),
            ListTile(title: Text('商品10')),
            ListTile(title: Text('商品11')),
          ],
        ),
      ),
    ],
  );
}

/// 2、Builder
Widget _getListViewBuilder(List<String> _words) {
  return Column(
    children: <Widget>[
      ListTile(title: Text('商品列表')),
      Expanded(
        child: RepaintBoundary(
          child: ListView.builder(
              itemBuilder: (context, index) {
                return _CommonItem(stringItem: _words[index]);
              },
              scrollDirection: Axis.vertical,
              padding: _listVerticalPadding,
              itemExtent: 80,
              physics: BouncingScrollPhysics(),
              itemCount: _words.length),
        ),
      ),
    ],
  );
}

/// 3、Separated-Horizontal
Widget _getListViewSeparatedHorizontal(List<String> _words) {
  return Column(
    children: <Widget>[
      ListTile(title: Text('商品列表')),
      RepaintBoundary(
        child: Container(
          constraints: BoxConstraints(maxHeight: 100.0, minHeight: 0),
          child: ListView.separated(
              itemBuilder: (context, index) {
                return _CommonItem(stringItem: _words[index]);
              },
              scrollDirection: Axis.horizontal,
              padding: _listHorizontalPadding,
              physics: BouncingScrollPhysics(),
              separatorBuilder: (BuildContext context, int index) =>
                  VerticalDivider(
                    width: 16.0,
                    thickness: 8,
                    color: Color(0xFF000000),
                    indent: 8.0,
                    endIndent: 8.0,
                  ),
              itemCount: _words.length),
        ),
      ),
    ],
  );
}

/// 4、Separated-Vertical
Widget _getListViewSeparatedVertical(List<String> _words) {
  return Column(
    children: <Widget>[
      ListTile(title: Text('商品列表')),
      Expanded(
        child: RepaintBoundary(
          child: Container(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return _CommonItem(stringItem: _words[index]);
                },
                scrollDirection: Axis.vertical,
                padding: _listHorizontalPadding,
                physics: BouncingScrollPhysics(),
                separatorBuilder: (BuildContext context, int index) =>
                    /*Divider(
                      height: 16.0,
                      color: Color(0xFFFFFFFF),
                    ),*/
                      Container(
                        height: 16.0,
                        color: Color(0xFFFFFFFF),
                      ),
                itemCount: _words.length),
          ),
        ),
      ),
    ],
  );
}

/// 5、Custom
Widget _getListViewCustom(List<String> _words) {
  return Column(
    children: <Widget>[
      ListTile(title: Text('商品列表')),
      Expanded(
            child: ListView.custom(
              childrenDelegate:
                  MyChildrenDelegate((BuildContext context, int index) {
                return new Container(
                  child: _CommonItem(stringItem: _words[index]),
                );
              }, childCount: _words.length),
              itemExtent: 80.0,
              padding: _listHorizontalPadding,
            ),
          ),
    ],
  );
}

/// Creates a material design divider.
class MyDivider extends StatelessWidget {
  const MyDivider({
    Key key,
    this.height,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
  }) : assert(height == null || height >= 0.0),
        assert(thickness == null || thickness >= 0.0),
        assert(indent == null || indent >= 0.0),
        assert(endIndent == null || endIndent >= 0.0),
        super(key: key);

  /// 水平分割器的高度值,都不设置,默认为：16.0
  final double height;

  /// 分割器内绘制的线的厚度
  final double thickness;

  /// 分割器内绘制的线距离前边缘的空间
  final double indent;

  /// 分割器内绘制的线距离后边缘的间距
  final double endIndent;

  /// 分割器内绘制的线的颜色值
  final Color color;

  /// 创建并计算分割器的边界
  static BorderSide createBorderSide(BuildContext context, { Color color, double width }) {
    final Color effectiveColor = color
        ?? (context != null ? (DividerTheme.of(context).color ?? Theme.of(context).dividerColor) : null);
    final double effectiveWidth =  width
        ?? (context != null ? DividerTheme.of(context).thickness : null)
        ?? 0.0;

    // Prevent assertion since it is possible that context is null and no color
    // is specified.
    if (effectiveColor == null) {
      return BorderSide(
        width: effectiveWidth,
      );
    }
    return BorderSide(
      color: effectiveColor,
      width: effectiveWidth,
    );
  }

  @override
  Widget build(BuildContext context) {
    final DividerThemeData dividerTheme = DividerTheme.of(context);
    final double height = this.height ?? dividerTheme.space ?? 16.0;
    final double thickness = this.thickness ?? dividerTheme.thickness ?? 0.0;
    final double indent = this.indent ?? dividerTheme.indent ?? 0.0;
    final double endIndent = this.endIndent ?? dividerTheme.endIndent ?? 0.0;

    /// 组合一些系统 Widget 来实现
    return SizedBox(
      // 分割器的高度
      height: height,
      child: Center(
        child: Container(
          // 分割器内绘制分割线的厚度
          height: thickness,
          // 分割器内绘制的分割线距离前后边缘的间距
          margin: EdgeInsetsDirectional.only(start: indent, end: endIndent),
          decoration: BoxDecoration(
            border: Border(
              bottom: createBorderSide(context, color: color, width: thickness),
            ),
          ),
        ),
      ),
    );
  }
}

class MyChildrenDelegate extends SliverChildBuilderDelegate {
  MyChildrenDelegate(
    Widget Function(BuildContext, int) builder, {
    int childCount,
    bool addAutomaticKeepAlive = true,
    bool addRepaintBoundaries = true,
  }) : super(builder,
            childCount: childCount,
            addAutomaticKeepAlives: addAutomaticKeepAlive,
            addRepaintBoundaries: addRepaintBoundaries);

  ///监听 在可见的列表中 显示的第一个位置和最后一个位置
  @override
  void didFinishLayout(int firstIndex, int lastIndex) {
    print('firstIndex: $firstIndex, lastIndex: $lastIndex');
  }

  ///可不重写 重写不能为null  默认是true  添加进来的实例与之前的实例是否相同 相同返回true 反之false
  ///listView 暂时没有看到应用场景 源码中使用在 SliverFillViewport 中
  @override
  bool shouldRebuild(SliverChildBuilderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    print("oldDelegate$oldDelegate");
    return super.shouldRebuild(oldDelegate);
  }
}
