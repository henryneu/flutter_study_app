import 'dart:collection';

import 'package:first_flutter_app/models/goods_model.dart';
import 'package:flutter/cupertino.dart';

class CartModel extends ChangeNotifier {
  // 购物车中已加入的商品列表
  final List<Goods> _goodLists = [];

  // 禁止改变购物车里的商品信息
  UnmodifiableListView<Goods> get goodLists => UnmodifiableListView(_goodLists);

  // 已加入购物车中商品的总价
  double get totalPrice => _goodLists.fold(
      0, (value, element) => value + element.count * element.price);

  // 购物车中添加商品
  void add(Goods goods) {
    _goodLists.add(goods);
    // 通知监听器(订阅者),重新构建 InheritedProvider,更新状态
    notifyListeners();
  }
}
