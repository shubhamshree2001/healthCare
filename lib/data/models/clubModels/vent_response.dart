import 'dart:convert';
import 'package:mindpeers_mobile_flutter/data/models/clubModels/vent_list_response.dart';

VentResponse ventResponseFromJson(String str) => VentResponse.fromJson(json.decode(str));

String ventResponseToJson(VentResponse data) => json.encode(data.toJson());

class VentResponse {
  VentResponse({
    required this.auth,
  });

  Auth? auth;

  factory VentResponse.fromJson(Map<String, dynamic> json) => VentResponse(
    auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
  );

  Map<String, dynamic> toJson() => {
    "auth": auth?.toJson(),
  };
}

class Auth {
  Auth({
    required this.vent,
  });

  Vent? vent;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
    vent: json["getVent"] == null ? null : Vent.fromJson(json["getVent"]),
  );

  Map<String, dynamic> toJson() => {
    "getVent": vent?.toJson(),
  };
}
