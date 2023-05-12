import 'package:alto_minho_mobilidade/ui/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ui/route/RouteScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Map<int, Color> color = {
    50: Color.fromRGBO(123, 114, 116, .1),
    100: Color.fromRGBO(123, 114, 116, .2),
    200: Color.fromRGBO(123, 114, 116, .3),
    300: Color.fromRGBO(123, 114, 116, .4),
    400: Color.fromRGBO(123, 114, 116, .5),
    500: Color.fromRGBO(123, 114, 116, .6),
    600: Color.fromRGBO(123, 114, 116, .7),
    700: Color.fromRGBO(123, 114, 116, .8),
    800: Color.fromRGBO(123, 114, 116, .9),
    900: Color.fromRGBO(123, 114, 116, 1),
  };
  @override
  Widget build(BuildContext context) {
    _setOrientation();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alto Minho – Mobilidade',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF7b7274, color),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
//      home: RouteScreen(Place(null, description: 'Rua Fernando Pessoa'), Place(null, description: 'Av. Humberta Delgado'), TimeUtil.dateString(dateTime: DateTime.now()),GetRoutes.fromJson(getRoutesJson)),
    );
  }

  void _setOrientation() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }
}

