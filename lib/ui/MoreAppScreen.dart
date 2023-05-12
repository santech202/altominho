import '../utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreAppScreen extends StatefulWidget {
  @override
  _MoreAppScreenState createState() => _MoreAppScreenState();
}

class _MoreAppScreenState extends State<MoreAppScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Mais aplicações"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        ListTile(
                          leading: Image.asset("assets/nautica-logo.jpg"),
                          title: Text("Alto Minho | Náutica e Natureza"),
                          onTap: () async {
                            const url =
                                'https://play.google.com/store/apps/details?id=com.inforneris.altominho&hl=pt';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                        ),
                        Divider(
                          height: 30,
                        ),
                        ListTile(
                          leading: Image.asset("assets/sabores-logo.jpg"),
                          title: Text("Alto Minho | Sabores"),
                          onTap: () async {
                            const url =
                                'https://play.google.com/store/apps/details?id=com.altominho.sabores&hl=en';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
