class Step {
  double distance;
  String relativeDirection;
  String streetName;
  String absoluteDirection;
  bool stayOn;
  bool area;
  bool bogusName;
  double lon;
  double lat;
  List<dynamic> elevation;
  String exit;

  Step({
    this.distance,
    this.relativeDirection,
    this.streetName,
    this.absoluteDirection,
    this.stayOn,
    this.area,
    this.bogusName,
    this.lon,
    this.lat,
    this.elevation,
    this.exit,
  });

  factory Step.fromJson(Map<String, dynamic> json) => Step(
    distance: json["distance"] == null ? null : json["distance"].toDouble(),
    relativeDirection: json["relativeDirection"] == null
        ? null
        : json["relativeDirection"],
    streetName: json["streetName"] == null ? null : json["streetName"],
    absoluteDirection: json["absoluteDirection"] == null
        ? null
        : json["absoluteDirection"],
    stayOn: json["stayOn"] == null ? null : json["stayOn"],
    area: json["area"] == null ? null : json["area"],
    bogusName: json["bogusName"] == null ? null : json["bogusName"],
    lon: json["lon"] == null ? null : json["lon"].toDouble(),
    lat: json["lat"] == null ? null : json["lat"].toDouble(),
    elevation: json["elevation"] == null
        ? null
        : List<dynamic>.from(json["elevation"].map((x) => x)),
    exit: json["exit"] == null ? null : json["exit"],
  );

  Map<String, dynamic> toJson() => {
    "distance": distance == null ? null : distance,
    "relativeDirection":
    relativeDirection == null ? null : relativeDirection,
    "streetName": streetName == null ? null : streetName,
    "absoluteDirection":
    absoluteDirection == null ? null : absoluteDirection,
    "stayOn": stayOn == null ? null : stayOn,
    "area": area == null ? null : area,
    "bogusName": bogusName == null ? null : bogusName,
    "lon": lon == null ? null : lon,
    "lat": lat == null ? null : lat,
    "elevation": elevation == null
        ? null
        : List<dynamic>.from(elevation.map((x) => x)),
    "exit": exit == null ? null : exit,
  };
}