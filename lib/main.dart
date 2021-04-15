import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  //TODO Animation
  AnimationController animationController;
  Animation flipAnimation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 5), vsync: this);

    flipAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.0, 0.5, curve: Curves.linear),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(centerTitle: true, title: new Text('Flip Animation')),
      body: AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return Center(
            child: InkWell(
              onTap: () {
                animationController.repeat();
              },
              child: Container(
                height: 200.0,
                width: 200.0,
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.005)
                    ..rotateY(2 * pi * flipAnimation.value),
                  alignment: Alignment.center,
                  child: Container(
                    height: 100.0,
                    width: 100.0,
                    color: Colors.green.withOpacity(0.3),
                    child: RotationTransition(
                      turns: flipAnimation,
                      child: Center(
                        child: Text(
                          'This Flips',
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
