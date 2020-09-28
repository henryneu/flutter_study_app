import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///产品Bean类
class Product {
  const Product({this.name});

  final String name;
}

typedef void CartChangedCallback(Product product, bool isCart);

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({Product product, this.isCart, this.cartChangedCallback})
      : product = product,
        super(key: new ObjectKey(product));

  final Product product;
  final bool isCart;
  final CartChangedCallback cartChangedCallback;

  Color _getColor(BuildContext context) {
    return isCart ? Colors.black54 : Theme
        .of(context)
        .primaryColor;
  }

  TextStyle _getTextStyle(BuildContext context) {
    if (!isCart) return null;

    return new TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      onTap: () {
        cartChangedCallback(product, !isCart);
      },
      leading: new CircleAvatar(
        backgroundColor: _getColor(context),
        child: new Text(product.name[0]),
      ),
      title: new Text(product.name, style: _getTextStyle(context),),
    );
  }
}
