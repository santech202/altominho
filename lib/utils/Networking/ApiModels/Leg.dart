import 'package:alto_minho_mobilidade/utils/Networking/ApiModels/From.dart';
import 'package:alto_minho_mobilidade/utils/Networking/ApiModels/LegGeometry.dart';
import 'package:alto_minho_mobilidade/utils/Networking/ApiModels/Step.dart';

class Leg {
  int startTime;
  int endTime;
  int departureDelay;
  int arrivalDelay;
  bool realTime;
  double distance;
  bool pathway;
  String mode;
  String route;
  int agencyTimeZoneOffset;
  bool interlineWithPreviousLeg;
  From from;
  From to;
  LegGeometry legGeometry;
  bool rentedBike;
  double duration;
  bool transitLeg;
  List<Step> steps;

  Leg({
    this.startTime,
    this.endTime,
    this.departureDelay,
    this.arrivalDelay,
    this.realTime,
    this.distance,
    this.pathway,
    this.mode,
    this.route,
    this.agencyTimeZoneOffset,
    this.interlineWithPreviousLeg,
    this.from,
    this.to,
    this.legGeometry,
    this.rentedBike,
    this.duration,
    this.transitLeg,
    this.steps,
  });

  factory Leg.fromJson(Map<String, dynamic> json) => Leg(
    startTime: json["startTime"] == null ? null : json["startTime"],
    endTime: json["endTime"] == null ? null : json["endTime"],
    departureDelay:
    json["departureDelay"] == null ? null : json["departureDelay"],
    arrivalDelay:
    json["arrivalDelay"] == null ? null : json["arrivalDelay"],
    realTime: json["realTime"] == null ? null : json["realTime"],
    distance: json["distance"] == null ? null : json["distance"].toDouble(),
    pathway: json["pathway"] == null ? null : json["pathway"],
    mode: json["mode"] == null ? null : json["mode"],
    route: json["route"] == null ? null : json["route"],
    agencyTimeZoneOffset: json["agencyTimeZoneOffset"] == null
        ? null
        : json["agencyTimeZoneOffset"],
    interlineWithPreviousLeg: json["interlineWithPreviousLeg"] == null
        ? null
        : json["interlineWithPreviousLeg"],
    from: json["from"] == null ? null : From.fromJson(json["from"]),
    to: json["to"] == null ? null : From.fromJson(json["to"]),
    legGeometry: json["legGeometry"] == null
        ? null
        : LegGeometry.fromJson(json["legGeometry"]),
    rentedBike: json["rentedBike"] == null ? null : json["rentedBike"],
    duration: json["duration"] == null ? null : json["duration"],
    transitLeg: json["transitLeg"] == null ? null : json["transitLeg"],
    steps: json["steps"] == null
        ? null
        : List<Step>.from(json["steps"].map((x) => Step.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "startTime": startTime == null ? null : startTime,
    "endTime": endTime == null ? null : endTime,
    "departureDelay": departureDelay == null ? null : departureDelay,
    "arrivalDelay": arrivalDelay == null ? null : arrivalDelay,
    "realTime": realTime == null ? null : realTime,
    "distance": distance == null ? null : distance,
    "pathway": pathway == null ? null : pathway,
    "mode": mode == null ? null : mode,
    "route": route == null ? null : route,
    "agencyTimeZoneOffset":
    agencyTimeZoneOffset == null ? null : agencyTimeZoneOffset,
    "interlineWithPreviousLeg":
    interlineWithPreviousLeg == null ? null : interlineWithPreviousLeg,
    "from": from == null ? null : from.toJson(),
    "to": to == null ? null : to.toJson(),
    "legGeometry": legGeometry == null ? null : legGeometry.toJson(),
    "rentedBike": rentedBike == null ? null : rentedBike,
    "duration": duration == null ? null : duration,
    "transitLeg": transitLeg == null ? null : transitLeg,
    "steps": steps == null
        ? null
        : List<dynamic>.from(steps.map((x) => x.toJson())),
  };
}