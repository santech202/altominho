import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ColorConstant {
  static const Color primaryColor = Color(0xFF7b7274);
  static const Color secondaryColor = Color(0xFF5dcc87);
  static const Color walkIconBackgroundColor = Color(0xFF5dcc87);
  static const Color bicycleIconBackgroundColor = Color(0xFF1DB378);
  static const Color busIconBackgroundColor = Color(0xFFc0c0c0);
  static const Color carIconBackgroundColor = Color(0xFFa0c0c0);
  static const Color transitWalkBackgroundColor = Color(0xFF95BD21);
  static const Color defaultIconColor = Color(0xFFc0c0c0);
  static const Color routeListItemSeparatorIconColor = Colors.white;
  static const Color routeListTopSectionColor = Color(0xFFedf4f4);
  static const Color searchScreenTheme = Color(0xFFD4CB8F);
}

class TextStyleConstant {
  static const TextStyle titleStyleWhiteBold20 =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
  static const TextStyle titleStyleWhite18 =
      TextStyle(fontSize: 14, color: Colors.white);
  static const TextStyle titleStyleSecondary16 =
      TextStyle(fontSize: 16, color: ColorConstant.searchScreenTheme);
  static const TextStyle titleStyleBlack16 =
  TextStyle(fontSize: 16, color: Colors.black);
  static const TextStyle titleStyleBlackBold16 =
  TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold);
}

class StringConstant {
  //previous mapApiKey
  //static const String mapAPIKey = "AIzaSyDlCWO9YyenKEKaWiTwpvddW0NwvltgmvE";

  //To change this key, change here first
  //then for android, change in app/src/main/AndroidManifest.xml
  //then for iOS, change in Appdelegate.swift

  //static const String mapAPIKey = "AIzaSyDkjddRzH60NSNZMF4vGF1vG1MVsDv0Q24";
  static const String mapAPIKey = "AIzaSyDjB26VCKi22-O0OTOuskANIfgoKPtYFsY";
}

class PlaceConstant {
  static const centerOfPortugal = LatLng(39.812653, -8.042664);
  static const portugalCoverageRadius = 430 * 1000; //430Km
}

class ModeConstants {
  static const BICYCLE = 'BICYCLE';
  static const WALK = "WALK";
  static const CAR = "CAR";
  static const BUS = "BUS";
  static const TRANSIT_WALK = 'TRANSIT,WALK';
}

class TranslationConstant {
  static const BICYCLE = 'Bicicleta';
  static const WALK = "A pé";
  static const CAR = "Carro";
  static const BUS = "Autocarro";
  static const TRANSIT_WALK = 'Autocarro';
  static const DESTINATION = 'Destino';
  static const ORIGIN = 'Partida de';
}