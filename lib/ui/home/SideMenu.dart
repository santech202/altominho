import 'dart:io';

import 'package:flutter/material.dart';
import 'package:alto_minho_mobilidade/ui/SearchScreen.dart';

import 'package:alto_minho_mobilidade/utils/constants.dart';
import 'package:alto_minho_mobilidade/ui/ConfigurationScreen.dart';
import 'package:alto_minho_mobilidade/ui/MoreAppScreen.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: ColorConstant.primaryColor,
        child: Column(
          children: <Widget>[
            DrawerHeader(child: Image.asset("assets/logo-app.png")),
            ListTile(
              title: Text(
                "Pesquisa Estudantes",
                style: TextStyleConstant.titleStyleWhite18,
              ),
              leading: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SearchScreen(
                    searchMode: 'Students',
                  );
                }));
              },
            ),
            ListTile(
              title: Text(
                "Pesquisa Público",
                style: TextStyleConstant.titleStyleWhite18,
              ),
              leading: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SearchScreen(
                    searchMode: 'Public',
                  );
                }));
              },
            ),
            Platform.isIOS == false
                ? ListTile(
              title: Text(
                "Mais Aplicações",
                style: TextStyleConstant.titleStyleWhite18,
              ),
              leading: Icon(
                Icons.format_list_numbered,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return MoreAppScreen();
                    }));
              },
            )
                : SizedBox(),
            ListTile(
              title: Text(
                "Configurações",
                style: TextStyleConstant.titleStyleWhite18,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ConfigurationScreen();
                }));
              },
              leading: Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
