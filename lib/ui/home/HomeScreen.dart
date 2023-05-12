
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../utils/size_config.dart';
import 'package:alto_minho_mobilidade/ui/home/SideMenu.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                  child: Image.asset(
                "assets/background.png",
                fit: BoxFit.fill,
              )),
              Positioned.fill(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 110,
                  width: SizeConfig.screenWidth,
                  color: Colors.black.withOpacity(0.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              "assets/ipvccc.png",
                              width: SizeConfig.safeBlockHorizontal * 20,
                              height: 50,
                            ),
                            Image.asset(
                              "assets/esce.png",
                              width: SizeConfig.safeBlockHorizontal * 20,
                              height: 50,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Image.asset(
                              "assets/cim-altominho.png",
                              width: SizeConfig.safeBlockHorizontal * 25,
                              height: 50,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Image.asset(
                              "assets/ipl2.png",
                              height: 50,
                              width: SizeConfig.safeBlockHorizontal * 25,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              "assets/transcunha.png",
                              height: 50,
                              width: SizeConfig.safeBlockHorizontal * 25,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Image.asset(
                              "assets/eu.png",
                              width: SizeConfig.safeBlockHorizontal * 70,
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
              Align(
                  alignment: Alignment(-1, 0.45),
                  child: GestureDetector(
                    onTap: () {
                      scaffoldKey.currentState.openDrawer();
                    },
                    child: Container(
                      width: 150,
                      height: 50,
                      color: ColorConstant.primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Menu",
                            style: TextStyleConstant.titleStyleWhiteBold20,
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}