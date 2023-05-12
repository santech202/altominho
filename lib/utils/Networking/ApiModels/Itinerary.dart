import 'package:alto_minho_mobilidade/utils/Networking/ApiModels/Leg.dart';

class Itinerary {
  int duration;
  int startTime;
  int endTime;
  int walkTime;
  int transitTime;
  int waitingTime;
  double walkDistance;
  bool walkLimitExceeded;
  double elevationLost;
  double elevationGained;
  int transfers;
  List<Leg> legs;
  bool tooSloped;

  Itinerary({
    this.duration,
    this.startTime,
    this.endTime,
    this.walkTime,
    this.transitTime,
    this.waitingTime,
    this.walkDistance,
    this.walkLimitExceeded,
    this.elevationLost,
    this.elevationGained,
    this.transfers,
    this.legs,
    this.tooSloped,
  });

  factory Itinerary.fromJson(Map<String, dynamic> json) => Itinerary(
    duration: json["duration"] == null ? null : json["duration"],
    startTime: json["startTime"] == null ? null : json["startTime"],
    endTime: json["endTime"] == null ? null : json["endTime"],
    walkTime: json["walkTime"] == null ? null : json["walkTime"],
    transitTime: json["transitTime"] == null ? null : json["transitTime"],
    waitingTime: json["waitingTime"] == null ? null : json["waitingTime"],
    walkDistance:
    json["walkDistance"] == null ? null : json["walkDistance"],
    walkLimitExceeded: json["walkLimitExceeded"] == null
        ? null
        : json["walkLimitExceeded"],
    elevationLost:
    json["elevationLost"] == null ? null : json["elevationLost"],
    elevationGained:
    json["elevationGained"] == null ? null : json["elevationGained"],
    transfers: json["transfers"] == null ? null : json["transfers"],
    legs: json["legs"] == null
        ? null
        : List<Leg>.from(json["legs"].map((x) => Leg.fromJson(x))),
    tooSloped: json["tooSloped"] == null ? null : json["tooSloped"],
  );

  Map<String, dynamic> toJson() => {
    "duration": duration == null ? null : duration,
    "startTime": startTime == null ? null : startTime,
    "endTime": endTime == null ? null : endTime,
    "walkTime": walkTime == null ? null : walkTime,
    "transitTime": transitTime == null ? null : transitTime,
    "waitingTime": waitingTime == null ? null : waitingTime,
    "walkDistance": walkDistance == null ? null : walkDistance,
    "walkLimitExceeded":
    walkLimitExceeded == null ? null : walkLimitExceeded,
    "elevationLost": elevationLost == null ? null : elevationLost,
    "elevationGained": elevationGained == null ? null : elevationGained,
    "transfers": transfers == null ? null : transfers,
    "legs": legs == null
        ? null
        : List<dynamic>.from(legs.map((x) => x.toJson())),
    "tooSloped": tooSloped == null ? null : tooSloped,
  };
}