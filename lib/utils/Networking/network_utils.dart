import 'package:alto_minho_mobilidade/utils/Networking/GetRoutes.dart';
import 'package:alto_minho_mobilidade/models/RouteParams.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NetworkUtils {
  Future<GetRoutes> getRoutesCall({
    GlobalKey<ScaffoldState> scaffoldKey,
    RouteParams routeParams,
  }) async {
    try {
      Response response = await Dio().get(
        "http://otp.esce.ipvc.pt/otp/routers/default/plan?"
        "fromPlace=${routeParams.fromPlace}&"
        "toPlace=${routeParams.toPlace}&"
        "time=${routeParams.time}&"
        "date=${routeParams.date}&"
        "mode=${routeParams.mode}&"
        "maxWalkDistance=${routeParams.maxWalkDistance}&"
        "arriveBy=${routeParams.arriveBy}&"
        "wheelchair=${routeParams.wheelchair}&"
        "locale=${routeParams.locale}",
        options: Options(headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        }),
      );
      return getRoutesFromJson(response.toString());
    } catch (error) {
      print(error);
      NetworkUtils.showSnackBar(scaffoldKey, "Something goes wrong");
    }
    return null;
  }

  static showSnackBar(GlobalKey<ScaffoldState> scaffoldKey, String message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message ?? ""),
    ));
  }
}
