class From {
  String name;
  double lon;
  double lat;
  String orig;
  String vertexType;
  int departure;
  int arrival;

  From({
    this.name,
    this.lon,
    this.lat,
    this.orig,
    this.vertexType,
    this.departure,
    this.arrival,
  });

  factory From.fromJson(Map<String, dynamic> json) => From(
    name: json["name"] == null ? null : json["name"],
    lon: json["lon"] == null ? null : json["lon"].toDouble(),
    lat: json["lat"] == null ? null : json["lat"].toDouble(),
    orig: json["orig"] == null ? null : json["orig"],
    vertexType: json["vertexType"] == null ? null : json["vertexType"],
    departure: json["departure"] == null ? null : json["departure"],
    arrival: json["arrival"] == null ? null : json["arrival"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "lon": lon == null ? null : lon,
    "lat": lat == null ? null : lat,
    "orig": orig == null ? null : orig,
    "vertexType": vertexType == null ? null : vertexType,
    "departure": departure == null ? null : departure,
    "arrival": arrival == null ? null : arrival,
  };
}

