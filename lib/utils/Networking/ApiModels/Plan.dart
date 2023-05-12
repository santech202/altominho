import 'package:alto_minho_mobilidade/utils/Networking/ApiModels/Itinerary.dart';

class Plan {
  int date;
  List<Itinerary> itineraries;

  Plan({
    this.date,
    this.itineraries,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
    date: json["date"] == null ? null : json["date"],
    itineraries: json["itineraries"] == null
        ? null
        : List<Itinerary>.from(
        json["itineraries"].map((x) => Itinerary.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": date == null ? null : date,
    "itineraries": itineraries == null
        ? null
        : List<dynamic>.from(itineraries.map((x) => x.toJson())),
  };
}
