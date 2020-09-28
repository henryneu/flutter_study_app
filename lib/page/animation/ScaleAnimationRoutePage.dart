import 'package:flutter/material.dart';

class AnimationImage extends AnimatedWidget {
  AnimationImage({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Center(
      child: Image.asset(
        'assets/images/lake.jpg',
        width: animation.value,
        height: animation.value,
      ),
    );
  }
}

class ScaleAnimationRoutePage extends StatefulWidget {
  @override
  _ScaleAnimationRoutePageState createState() {
    return new _ScaleAnimationRoutePageState();
  }
}

class GrowTransition extends StatelessWidget {
  GrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget child) {
          return new Container(
            child: child,
            width: animation.value,
            height: animation.value,
          );
        },
        child: child,
      ),
    );
  }
}

class _ScaleAnimationRoutePageState extends State<ScaleAnimationRoutePage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(seconds: 2), vsync: this);
    //animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    // 图片宽高从0变到300
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // 动画执行结束时反向执行动画
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        // 动画恢复到初始状态时执行动画(正向)
        controller.forward();
      }
    });
      /*..addListener(() {
        setState(() {});
      });*/
    // 启动动画(正向执行)
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("动画测试"),
      ),
      body: Center(
        /*child: Image.asset(
          'assets/images/lake.jpg',
          width: animation.value,
          height: animation.value,
        ),*/
        /*child: AnimatedBuilder(
          animation: animation,
          child: Image.asset(
            'assets/images/lake.jpg',
          ),
          builder: (BuildContext ctx, Widget child) {
            return new Center(
              child: Container(
                child: child,
                width: animation.value,
                height: animation.value,
              ),
            );
          },
        ),*/
        child: GrowTransition(
          child: Image.asset(
            'assets/images/lake.jpg',
          ),
          animation: animation,
        ),
      ),
    );
  }
}
