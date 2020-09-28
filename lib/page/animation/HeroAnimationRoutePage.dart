import 'package:flutter/material.dart';

class HeroAnimationRoutePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hero"),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            InkWell(
              child: Hero(
                tag: "avator",
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/lake.jpg',
                    width: 60.0,
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(context, PageRouteBuilder(pageBuilder:
                    (BuildContext context, Animation animation,
                        Animation secondaryAnimation) {
                  return new FadeTransition(
                    opacity: animation,
                    child: Scaffold(
                      appBar: AppBar(
                        title: Text("原图"),
                      ),
                      body: HeroAnimationRoutePageB(),
                    ),
                  );
                }));
              },
            ),
            MarkWidget(rankIndex: 2),
            Prices(500, 1099),
          ],
        ),
      ),
    );
  }
}

class HeroAnimationRoutePageB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: "avator",
        child: Image.asset(
          'assets/images/lake.jpg',
        ),
      ),
    );
  }
}

/// 商品排行前三名标签
class MarkWidget extends StatelessWidget {
  final int rankIndex;

  Color _markBgColor;

  MarkWidget({this.rankIndex});

  Color _getMarkBgColor() {
    switch (rankIndex) {
      case 0:
        _markBgColor = Color(0xFFFFC66C);
        break;
      case 1:
        _markBgColor = Color(0xFFD9CAA6);
        break;
      case 2:
        _markBgColor = Color(0xFFD4AD9C);
        break;
    }
    return _markBgColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 80.0,
      height: 38.0,
      decoration: BoxDecoration(
        color: _getMarkBgColor(),
        borderRadius: BorderRadius.only(
          topLeft: Radius.zero,
          topRight: Radius.zero,
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
      ),
      child: Text(
        'TOP${this.rankIndex + 1}',
        style: TextStyle(
            color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.w800),
      ),
    );
  }
}

/// 商品价格：折扣价格、原价
class Prices extends StatelessWidget {
  final int price; // 折扣价
  final int shopPrice; // 商品原价
  Prices(this.price, this.shopPrice);

  static final _style$ = TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600);

  static final _styleNormal$ = TextStyle(fontSize: 8.0);

  static final _styleDiscount =
      TextStyle(fontSize: 26.0, fontWeight: FontWeight.w600);

  static final _styleNorma = TextStyle(
    fontSize: 14.0,
  );

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: Text.rich(
          TextSpan(children: [
            WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 11.0),
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(text: '¥', style: _style$),
                      TextSpan(text: '599', style: _styleDiscount),
                    ], style: TextStyle(letterSpacing: -1)),
                    style: TextStyle(color: Color(0xFFF53C54)),
                  ),
                )),
            WidgetSpan(
                child: SizedBox(
                  width: 7.0,
                ),
            ),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 11.0),
                child: Text.rich(
                  TextSpan(children: [
                    TextSpan(text: '¥', style: _styleNormal$),
                    TextSpan(text: '${shopPrice}', style: _styleNorma,),
                  ], style: TextStyle(letterSpacing: -1)),
                  style: TextStyle(color: Color(0xFFD0D0D0)),
                ),
              ),
            ),
          ]),
        ),
      )
    ]);
  }
}
