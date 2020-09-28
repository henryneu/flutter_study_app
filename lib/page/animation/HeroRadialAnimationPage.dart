import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'dart:math' as math;

class PhotoViewWidget extends StatelessWidget {
  PhotoViewWidget({Key key, this.photo, this.color, this.onTap, this.width})
      : super(key: key);

  final String photo;
  final Color color;
  final VoidCallback onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor.withOpacity(0.25),
      child: InkWell(
        onTap: onTap,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints size) {
            return Image.network(photo, fit: BoxFit.contain);
          },
        ),
      ),
    );
  }
}

class HeroRadialAnimationPage extends StatelessWidget {
  static const double kMinRadius = 32.0;
  static const double kMaxRadius = 128.0;
  static const opacityCurve =
      const Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  static RectTween _createRectTween(Rect begin, Rect end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }

  static Widget _buildPage(
      BuildContext context, String imageName, String description) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Card(
          elevation: 8.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: kMaxRadius * 2,
                height: kMaxRadius * 2,
                child: Hero(
                  tag: imageName,
                  createRectTween: _createRectTween,
                  child: RadialExpansion(
                    maxRadius: kMaxRadius,
                    child: PhotoViewWidget(
                      photo: imageName,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ),
              Text(
                description,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 5.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("测试径向Hero动画"),
      ),
      body: Container(
        padding: const EdgeInsets.all(32.0),
        alignment: FractionalOffset.bottomLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildHero(
                context,
                'https://raw.githubusercontent.com/flutter/website/master/examples/_animation/radial_hero_animation/images/chair-alpha.png',
                "Chair"),
            _buildHero(
                context,
                'https://raw.githubusercontent.com/flutter/website/master/examples/_animation/hero_animation/images/flippers-alpha.png',
                "Binoculars"),
            _buildHero(
                context,
                'https://raw.githubusercontent.com/flutter/website/master/examples/_animation/radial_hero_animation/images/beachball-alpha.png',
                "Beach ball"),
          ],
        ),
      ),
    );
  }

  Widget _buildHero(
      BuildContext context, String imageName, String description) {
    return Container(
      width: kMinRadius * 2,
      height: kMinRadius * 2,
      child: Hero(
        tag: imageName,
        child: RadialExpansion(
          maxRadius: kMaxRadius,
          child: PhotoViewWidget(
            photo: imageName,
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder<void>(pageBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return AnimatedBuilder(
                    animation: animation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: opacityCurve.transform(animation.value),
                        child: _buildPage(context, imageName, description),
                      );
                    },
                  );
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}

class RadialExpansion extends StatelessWidget {
  RadialExpansion({Key key, this.maxRadius, this.child})
      : clipRectSize = 2.0 * (maxRadius / math.sqrt2),
        super(key: key);

  final double maxRadius;
  final clipRectSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Center(
        child: SizedBox(
          width: clipRectSize,
          height: clipRectSize,
          child: ClipRect(
            child: child,
          ),
        ),
      ),
    );
  }
}

class HeroAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    timeDilation = 10.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Hero Animation'),
      ),
      body: Center(
        child: PhotoViewWidget(
          photo:
              'https://raw.githubusercontent.com/flutter/website/master/examples/_animation/hero_animation/images/flippers-alpha.png',
          width: 300.0,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Basic Hero Animation'),
                ),
                body: Container(
                  color: Colors.lightBlueAccent,
                  padding: EdgeInsets.all(16),
                  alignment: Alignment.topLeft,
                  child: PhotoViewWidget(
                    photo:
                        'https://raw.githubusercontent.com/flutter/website/master/examples/_animation/hero_animation/images/flippers-alpha.png',
                    width: 100,
                    onTap: () {
                      Navigator.of(context).pop(); //关闭当前界面
                    },
                  ),
                ),
              );
            }));
          },
        ),
      ),
    );
  }
}
