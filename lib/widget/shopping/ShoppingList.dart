import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ShoppingListItem.dart';

class ShoppingList extends StatefulWidget {
  ShoppingList({Key key, this.productList}) : super(key: key);

  final List<Product> productList;

  @override
  _ShoppingListState createState() {
    return new _ShoppingListState();
  }
}

class _ShoppingListState extends State<ShoppingList> {
  Set<Product> _shoppingSet = new Set<Product>();

  void _handleCartChanged(Product product, bool isCart) {
    setState(() {
      if (!isCart) {
        _shoppingSet.remove(product);
      } else {
        _shoppingSet.add(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Shopping List'),
      ),
      body: new ListView(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: widget.productList.map((Product product) {
          return new ShoppingListItem(
            product: product,
            isCart: _shoppingSet.contains(product),
            cartChangedCallback: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
}
