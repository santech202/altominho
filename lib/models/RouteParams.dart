class RouteParams {
  String fromPlace;
  String toPlace;
  String time;
  String date;
  String mode;
  String maxWalkDistance;
  bool arriveBy;
  bool wheelchair;
  String locale;
  RouteParams({
    this.fromPlace,
    this.toPlace,
    this.time,
    this.date,
    this.mode,
    this.maxWalkDistance,
    this.arriveBy,
    this.wheelchair,
    this.locale,
  });
}
