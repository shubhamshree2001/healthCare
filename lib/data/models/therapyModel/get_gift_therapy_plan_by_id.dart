
import 'dart:convert';

import 'package:mindpeers_mobile_flutter/data/models/therapyModel/therapy_gift_plan_response.dart';

GetTherapyGiftPlanByIdResponse getTherapyGiftPlanByIdResponseFromJson(String str) => GetTherapyGiftPlanByIdResponse.fromJson(json.decode(str));

String getTherapyGiftPlanByIdResponseToJson(GetTherapyGiftPlanByIdResponse data) => json.encode(data.toJson());

class GetTherapyGiftPlanByIdResponse {
  GetTherapyGiftPlanByIdResponse({
    required this.auth,
  });

  Auth? auth;

  factory GetTherapyGiftPlanByIdResponse.fromJson(Map<String, dynamic> json) => GetTherapyGiftPlanByIdResponse(
    auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
  );

  Map<String, dynamic> toJson() => {
    "auth": auth == null ? null : auth?.toJson(),
  };
}

class Auth {
  Auth({
    required this.therapyGiftPlan,
  });

  TherapyGiftPlan? therapyGiftPlan;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
    therapyGiftPlan: json["getPlan"] == null ? null : TherapyGiftPlan.fromJson(json["getPlan"]),
  );

  Map<String, dynamic> toJson() => {
    "getPlan": therapyGiftPlan == null ? null : therapyGiftPlan?.toJson(),
  };
}

