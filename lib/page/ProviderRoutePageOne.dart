// 跨组件状态共享(Provider)

// 一个通用的InheritedWidget，保存任需要跨组件共享的状态
import 'dart:collection';

import 'package:first_flutter_app/widget/CustomNavBar.dart';
import 'package:flutter/material.dart';

class InheritedProvider<T> extends InheritedWidget {
  InheritedProvider({@required this.data, Widget child}) : super(child: child);

  // 共享状态使用泛型
  final T data;

  bool updateShouldNotify(InheritedProvider<T> old) {
    // 返回true，则每次更新都会调用依赖其的子孙节点的didChangeDependencies
    return true;
  }
}

// 该方法用于Dart获取模板类型
Type _typeOf<T>() => T;

class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  ChangeNotifierProvider({
    Key key,
    this.data,
    this.child,
  });

  final Widget child;
  final T data;

  // 替换上面的便捷方法，按需求是否注册依赖关系
  static T of<T>(BuildContext context, {bool listen = true}) {
    final type = _typeOf<InheritedProvider<T>>();
    final provider = listen
        ? context.inheritFromWidgetOfExactType(type) as InheritedProvider<T>
        : context.ancestorInheritedElementForWidgetOfExactType(type)?.widget
            as InheritedProvider<T>;
    return provider.data;
  }

  _ChangeNotifierProviderState<T> createState() =>
      _ChangeNotifierProviderState<T>();
}

// _ChangeNotifierProviderState类的主要作用就是监听到共享状态（model）改变时重新构建Widget树。
// 注意，在_ChangeNotifierProviderState类中调用setState()方法，widget.child始终是同一个，
// 所以执行build时，InheritedProvider的child引用的始终是同一个子widget，
// 所以widget.child并不会重新build，这也就相当于对child进行了缓存！当然如果ChangeNotifierProvider父级Widget重新build时，则其传入的child便有可能会发生变化。
class _ChangeNotifierProviderState<T extends ChangeNotifier>
    extends State<ChangeNotifierProvider<T>> {
  void update() {
    // 如果数据发生变化（model类调用了notifyListeners)，重新构建InheritedProvider
    setState(() => {});
  }

  @override
  void didUpdateWidget(ChangeNotifierProvider<T> oldWidget) {
    // 当Provider更新时，如果新旧数据不相等，则解绑旧数据监听，同时添加新数据监听
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // 给model添加监听器
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    // 移除model的监听器
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }
}

// 购物车示例：实现一个显示购物车中所有商品总价的功能

// 用于表示商品信息
class Item {
  // 商品单价
  double price;

  // 商品份数
  int count;

  Item(this.price, this.count);
}

// 保存购物车内商品数据，跨组件共享
class CartModel extends ChangeNotifier {
  // 用于保存购物车中商品列表
  final List<Item> _items = [];

  // 禁止改变购物车里的商品信息
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  // 购物车中商品的总价
  double get totalPrice =>
      _items.fold(0, (value, item) => value + item.count * item.price);

  // 将[item]添加到购物车，这是唯一一种能从外部改变购物车的方法
  void add(Item item) {
    _items.add(item);
    // 通知监听者（订阅者），重新构建InheritedProvider，更新状态
    notifyListeners();
  }
}

// 优化
// 一个便捷类，封装一个Consumer的Widget
class Consumer<T> extends StatelessWidget {
  final Widget child;
  final Widget Function(BuildContext context, T value) builder;

  Consumer({
    Key key,
    @required this.builder,
    this.child,
  })  : assert(builder != null),
        super(key: key);

  Widget build(BuildContext context) {
    return builder(
      context,
      // 自动获取Model
      ChangeNotifierProvider.of<T>(context),
    );
  }
}

// 页面
class ProviderRoute extends StatefulWidget {
  _ProviderRouteState createState() => _ProviderRouteState();
}

class _ProviderRouteState extends State<ProviderRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('跨组件状态共享(Provider)'),
      ),
      body: Center(
        child: ChangeNotifierProvider<CartModel>(
          data: CartModel(),
          child: Builder(
            builder: (context) {
              return Column(
                children: <Widget>[
                  // 进行优化，替换上面Builder
                  Consumer<CartModel>(
                    builder: (context, cart) => Text("总价：${cart.totalPrice}"),
                  ),

                  Builder(
                    builder: (context) {
                      // 控制台打印出这句，说明按钮在每次点击时其自身都会重新build！
                      print("RaisedButton build");
                      return RaisedButton(
                        child: Text("添加商品"),
                        onPressed: () {
                          // 给购物车中添加商品，添加后总价会更新
                          //ChangeNotifierProvider.of<CartModel>(context).add(Item(20.0, 1));
                          // listen设为false，不建立依赖关系，因为按钮不需要每次重新build
                          ChangeNotifierProvider.of<CartModel>(context,
                                  listen: false)
                              .add(Item(20.0, 1));
                        },
                      );
                    },
                  ),
                  CustomNavBar(title: "标题", color: Colors.blue),
                  CustomNavBar(title: "标题", color: Colors.white),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
