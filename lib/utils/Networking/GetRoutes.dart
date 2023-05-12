import 'dart:convert';

import 'package:alto_minho_mobilidade/utils/Networking/ApiModels/RequestParameters.dart';
import 'package:alto_minho_mobilidade/utils/Networking/ApiModels/Plan.dart';

GetRoutes getRoutesFromJson(String str) => GetRoutes.fromJson(json.decode(str));

String getRoutesToJson(GetRoutes data) => json.encode(data.toJson());

class GetRoutes {
  RequestParameters requestParameters;
  Plan plan;
  Error error;

  GetRoutes({
    this.requestParameters,
    this.plan,
    this.error,
  });

  factory GetRoutes.fromJson(Map<String, dynamic> json) => GetRoutes(
        requestParameters: json["requestParameters"] == null
            ? null
            : RequestParameters.fromJson(json["requestParameters"]),
        plan: json["plan"] == null ? null : Plan.fromJson(json["plan"]),
        error: json["error"] == null ? null : Error.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "requestParameters":
            requestParameters == null ? null : requestParameters.toJson(),
        "plan": plan == null ? null : plan.toJson(),
        "error": error == null ? null : error.toJson(),
      };
}

class Error {
  int id;
  String msg;
  String message;
  List<String> missing;
  bool noPath;

  Error({
    this.id,
    this.msg,
    this.message,
    this.missing,
    this.noPath,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        id: json["id"] == null ? null : json["id"],
        msg: json["msg"] == null ? null : json["msg"],
        message: json["message"] == null ? null : json["message"],
        missing: json["missing"] == null
            ? null
            : List<String>.from(json["missing"].map((x) => x)),
        noPath: json["noPath"] == null ? null : json["noPath"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "msg": msg == null ? null : msg,
        "message": message == null ? null : message,
        "missing":
            missing == null ? null : List<dynamic>.from(missing.map((x) => x)),
        "noPath": noPath == null ? null : noPath,
      };
}