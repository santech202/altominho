import 'package:alto_minho_mobilidade/utils/Networking/GetRoutes.dart';
import 'package:alto_minho_mobilidade/ui/route/MapView.dart';
import 'package:alto_minho_mobilidade/ui/route/RouteListView.dart';
import 'package:alto_minho_mobilidade/utils/constants.dart';
import 'package:alto_minho_mobilidade/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:search_map_place/search_map_place.dart';

class RouteScreen extends StatefulWidget {
  final Place fromPlace;
  final Place toPlace;
  final GetRoutes getRoutes;
  final String dateTimeString;

  const RouteScreen(this.fromPlace, this.toPlace, this.dateTimeString, this.getRoutes);

  @override
  _RouteScreenState createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  int selectedTabIndex = 1;
  final tabs = ['Detalhe', 'Mapa'];
  List<Widget> tabBodies;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabBodies = [
      RouteListView(widget.getRoutes, widget.fromPlace, widget.toPlace),
      MapView(widget.getRoutes),
    ];
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150),
          child: AppBar(
            title: Text(widget.dateTimeString),
            flexibleSpace: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 70.0, vertical: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.my_location, color: ColorConstant.secondaryColor,),
                        SizedBox(
                          width: 10,
                        ),
                        Text(widget.fromPlace.description,
                        style: TextStyleConstant.titleStyleWhite18,)
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(Icons.pin_drop, color: ColorConstant.secondaryColor,),
                        SizedBox(
                          width: 10,
                        ),
                        Text(widget.toPlace.description,
                         style: TextStyleConstant.titleStyleWhite18,)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                    boxShadow: [BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 2),
                        blurRadius: 6
                    )]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: tabs
                      .map((e) {
                        final index = tabs.indexOf(e);
                        return Container(
                          width: MediaQuery.of(context).size.width / tabs.length,
                          child: FlatButton(
                            padding: EdgeInsets.all(0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0, bottom: 14.0),
                                  child: Text(
                                    e,
                                    style: TextStyleConstant.titleStyleSecondary16,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 2,
                                  color: index == selectedTabIndex? ColorConstant.secondaryColor: Theme.of(context).scaffoldBackgroundColor,
                                ),
                              ],
                            ),
                            onPressed: () {
                              setState(() {
                                selectedTabIndex = tabs.indexOf(e);
                              });
                            },
                          ),
                        );
                  })
                      .toList(),
                ),
              ),
              Expanded(child: tabBodies[selectedTabIndex])
            ],
          ),
        ));
  }
}
