
import 'dart:convert';

import 'package:mindpeers_mobile_flutter/data/models/therapyModel/doctor_list_response.dart';

DoctorDetailsResponse doctorDetailsResponseFromJson(String str) => DoctorDetailsResponse.fromJson(json.decode(str));

String doctorDetailsResponseToJson(DoctorDetailsResponse data) => json.encode(data.toJson());

class DoctorDetailsResponse {
  DoctorDetailsResponse({
    required this.auth,
  });

  Auth? auth;

  factory DoctorDetailsResponse.fromJson(Map<String, dynamic> json) => DoctorDetailsResponse(
    auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
  );

  Map<String, dynamic> toJson() => {
    "auth": auth == null ? null : auth?.toJson(),
  };
}

class Auth {
  Auth({
    required this.doctorItem,
  });

  DoctorItem? doctorItem;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
    doctorItem: json["getDoctor"] == null ? null : DoctorItem.fromJson(json["getDoctor"]),
  );

  Map<String, dynamic> toJson() => {
    "getDoctor": doctorItem == null ? null : doctorItem?.toJson(),
  };
}

