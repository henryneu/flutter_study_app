import 'package:first_flutter_app/models/cart_model.dart';
import 'package:first_flutter_app/models/goods_model.dart';
import 'package:first_flutter_app/provider/ChangeNotifierProvider.dart';
import 'package:flutter/material.dart';

class ProviderRoutePage extends StatefulWidget {
  @override
  _ProviderRoutePageState createState() {
    return new _ProviderRoutePageState();
  }
}

class _ProviderRoutePageState extends State<ProviderRoutePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ChangeNotifierProvider<CartModel>(
          data: CartModel(),
          child: Builder(
            builder: (context) {
              return Column(
                children: <Widget>[
                  Builder(
                    builder: (context) {
                      var cart = ChangeNotifierProvider.of<CartModel>(context);
                      return Text("总价: ${cart.totalPrice}");
                    }
                  ),
                  Builder(
                    builder: (context) {
                      print("RaisedButton build");
                      return RaisedButton(
                        child: Text("添加商品"),
                        onPressed: (){
                          ChangeNotifierProvider.of<CartModel>(context).add(Goods(20.0, 1));
                        },
                      );
                    },
                  ),
                ],
              );
            },
          )),
    );
  }
}
