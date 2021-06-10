import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:food_charity/pages/choose.dart';

// ignore: camel_case_types
class Splace_Screen extends StatefulWidget {
  @override
  _Splace_ScreenState createState() => _Splace_ScreenState();
}

// ignore: camel_case_types
class _Splace_ScreenState extends State<Splace_Screen> {
  @override
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Icon(
          Icons.bolt,
          size: 100,
          color: Colors.amber,
        ),
        nextScreen: Choose());
  }
}
