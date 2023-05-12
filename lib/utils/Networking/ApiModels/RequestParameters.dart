
class RequestParameters {
  String date;
  String mode;
  String arriveBy;
  String wheelchair;
  String fromPlace;
  String toPlace;
  String time;
  String maxWalkDistance;
  String locale;

  RequestParameters({
    this.date,
    this.mode,
    this.arriveBy,
    this.wheelchair,
    this.fromPlace,
    this.toPlace,
    this.time,
    this.maxWalkDistance,
    this.locale,
  });

  factory RequestParameters.fromJson(Map<String, dynamic> json) =>
      RequestParameters(
        date: json["date"] == null ? null : json["date"],
        mode: json["mode"] == null ? null : json["mode"],
        arriveBy: json["arriveBy"] == null ? null : json["arriveBy"],
        wheelchair: json["wheelchair"] == null ? null : json["wheelchair"],
        fromPlace: json["fromPlace"] == null ? null : json["fromPlace"],
        toPlace: json["toPlace"] == null ? null : json["toPlace"],
        time: json["time"] == null ? null : json["time"],
        maxWalkDistance:
        json["maxWalkDistance"] == null ? null : json["maxWalkDistance"],
        locale: json["locale"] == null ? null : json["locale"],
      );

  Map<String, dynamic> toJson() => {
    "date": date == null ? null : date,
    "mode": mode == null ? null : mode,
    "arriveBy": arriveBy == null ? null : arriveBy,
    "wheelchair": wheelchair == null ? null : wheelchair,
    "fromPlace": fromPlace == null ? null : fromPlace,
    "toPlace": toPlace == null ? null : toPlace,
    "time": time == null ? null : time,
    "maxWalkDistance": maxWalkDistance == null ? null : maxWalkDistance,
    "locale": locale == null ? null : locale,
  };
}
