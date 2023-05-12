import 'dart:async';

import 'home/HomeScreen.dart';
import '../utils/constants.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const int splashDuration = 1;

  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    return Timer(Duration(seconds: splashDuration), () {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
            return HomeScreen();
          }), (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: ColorConstant.primaryColor,
      body: Center(
        child: Image.asset(
          "assets/logo-app.png",
          height: SizeConfig.safeBlockVertical * 30,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
