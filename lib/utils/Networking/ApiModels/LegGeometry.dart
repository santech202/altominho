class LegGeometry {
  String points;
  int length;

  LegGeometry({
    this.points,
    this.length,
  });

  factory LegGeometry.fromJson(Map<String, dynamic> json) => LegGeometry(
    points: json["points"] == null ? null : json["points"],
    length: json["length"] == null ? null : json["length"],
  );

  Map<String, dynamic> toJson() => {
    "points": points == null ? null : points,
    "length": length == null ? null : length,
  };
}