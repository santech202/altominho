import 'package:alto_minho_mobilidade/models/RouteParams.dart';
import 'package:alto_minho_mobilidade/ui/route/OptionScreen.dart';
import 'package:alto_minho_mobilidade/utils/Networking/network_utils.dart';
import 'package:alto_minho_mobilidade/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:search_map_place/search_map_place.dart';

import '../utils/constants.dart';
import '../utils/size_config.dart';
import 'route/RouteScreen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
  final String searchMode;

  SearchScreen({this.searchMode});
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TimeOfDay timeOfDay = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  String _date;
  String _time;
  String modeString = "walk";

  String fromLat;
  String fromLng;
  String toLat;
  String toLng;
  Place fromPlace;
  Place toPlace;
  String optionModel = "WALK";

  onOptionChange(String newOptionModel) {
    if (newOptionModel == TranslationConstant.CAR) {
      optionModel = ModeConstants.CAR;
    } else if (newOptionModel == TranslationConstant.BUS) {
      optionModel = ModeConstants.BUS;
    } else if (newOptionModel == TranslationConstant.BICYCLE) {
      optionModel = ModeConstants.BICYCLE;
    } else if (newOptionModel == TranslationConstant.WALK) {
      optionModel = ModeConstants.WALK;
    } else if (newOptionModel == TranslationConstant.TRANSIT_WALK) {
      optionModel = ModeConstants.TRANSIT_WALK;
    }
    modeString = optionModel;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _date =
        "${selectedDate.month < 10 ? "0${selectedDate.month}" : selectedDate.month}-${selectedDate.day < 10 ? "0${selectedDate.day}" : selectedDate.day}-${selectedDate.year}";
    _time = timeOfDay.format(context).toString().trim();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            (widget.searchMode != null && widget.searchMode == 'Students')
                ? "Pesquisa Estudantes"
                : "Pesquisa Público"),
      ),
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.my_location),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: SearchMapPlaceWidget(
                            location: PlaceConstant.centerOfPortugal,
                            radius: PlaceConstant.portugalCoverageRadius,
                            strictBounds: true,
                            placeholder: 'Qual o seu ponto de partida?',
                            iconColor: ColorConstant.searchScreenTheme,
                            apiKey: StringConstant.mapAPIKey,
                            onSelected: (place) async {
                              fromPlace = place;
                              place.geolocation.then((value) {
                                value.coordinates.toString();
                                String tempLat =
                                    value.coordinates.toString().substring(7);
                                String lat = tempLat.split(",")[0];
                                String tempLong = tempLat.split(",")[1];
                                String lang =
                                    tempLong.substring(1, tempLong.length - 1);
                                fromLat = lat;
                                fromLng = lang;
                              });
                            },
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.pin_drop),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: SearchMapPlaceWidget(
                            location: PlaceConstant.centerOfPortugal,
                            radius: PlaceConstant.portugalCoverageRadius,
                            strictBounds: true,
                            placeholder: 'Qual o seu destino?',
                            iconColor: ColorConstant.searchScreenTheme,
                            apiKey: StringConstant.mapAPIKey,
                            onSelected: (place) async {
                              toPlace = place;
                              place.geolocation.then((value) {
                                value.coordinates.toString();
                                String tempLat =
                                    value.coordinates.toString().substring(7);
                                String lat = tempLat.split(",")[0];
                                String tempLong = tempLat.split(",")[1];
                                String lang =
                                    tempLong.substring(1, tempLong.length - 1);
                                toLat = lat;
                                toLng = lang;
                              });
                            },
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  color: ColorConstant.searchScreenTheme,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Row(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        _selectDate(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Text(
                                          TimeUtil.dateString(
                                              dateTime: selectedDate),
                                          style: TextStyleConstant
                                              .titleStyleBlack16,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _selectTime(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Text(
                                          _time,
                                          style: TextStyleConstant
                                              .titleStyleBlack16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              "|",
                              style: TextStyleConstant.titleStyleSecondary16,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return OptionScreen(
                                    searchMode: widget.searchMode,
                                    onChanged: onOptionChange,
                                    optionModel: optionModel,
                                  );
                                }));
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.settings,
                                    color: ColorConstant.searchScreenTheme,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Opções",
                                    style:
                                        TextStyleConstant.titleStyleSecondary16,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: FlatButton(
                              onPressed: () {
                                if (fromLng == null) {
                                  scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Please select from location")));
                                } else if (toLng == null) {
                                  scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Please select to location")));
                                } else if (selectedDate == null) {
                                  scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                          content: Text("Please select date")));
                                } else if (timeOfDay == null) {
                                  scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                          content: Text("Please select time")));
                                } else {
                                  RouteParams routeParams = RouteParams();
                                  routeParams.fromPlace = '$fromLat%2C$fromLng';
                                  routeParams.toPlace = '$toLat%2C$toLng';
                                  routeParams.time = _time;
                                  routeParams.date = _date;
                                  routeParams.mode = modeString;
                                  routeParams.maxWalkDistance = '8046.72';
                                  routeParams.arriveBy = false;
                                  routeParams.wheelchair = false;
                                  routeParams.locale = 'pt';

                                  NetworkUtils()
                                      .getRoutesCall(
                                          scaffoldKey: scaffoldKey,
                                          routeParams: routeParams)
                                      .then((getRoutes) {

                                    if (getRoutes != null) {
                                      if (getRoutes.plan != null) {
                                        final dateTimeString = TimeUtil.dateString(dateTime: selectedDate) + ' ' + _time;
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return RouteScreen(
                                              fromPlace, toPlace, dateTimeString, getRoutes);
                                        }));
                                      } else {
                                        scaffoldKey.currentState.showSnackBar(
                                            SnackBar(
                                                content:
                                                    Text(getRoutes.error.msg)));
                                      }
                                    }
                                  });
                                }
                              },
                              child: Text(
                                "Pesquisar",
                                style: TextStyleConstant.titleStyleWhite18,
                              ),
                              color: ColorConstant.searchScreenTheme,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 1095)),
      lastDate: DateTime.now().add(Duration(days: 1095)),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _date =
            "${selectedDate.month < 10 ? "0${selectedDate.month}" : selectedDate.month}-${selectedDate.day < 10 ? "0${selectedDate.day}" : selectedDate.day}-${selectedDate.year}";
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        timeOfDay = picked;
        _time = timeOfDay.format(context).toString().trim();
      });
    }
  }
}
