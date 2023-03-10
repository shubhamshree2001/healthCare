// To parse this JSON data, do
//
//     final getTherapyGiftOrderResponse = getTherapyGiftOrderResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetTherapyGiftOrderResponse getTherapyGiftOrderResponseFromJson(String str) => GetTherapyGiftOrderResponse.fromJson(json.decode(str));

String getTherapyGiftOrderResponseToJson(GetTherapyGiftOrderResponse data) => json.encode(data.toJson());

class GetTherapyGiftOrderResponse {
  GetTherapyGiftOrderResponse({
    required this.auth,
  });

  Auth? auth;

  factory GetTherapyGiftOrderResponse.fromJson(Map<String, dynamic> json) => GetTherapyGiftOrderResponse(
    auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
  );

  Map<String, dynamic> toJson() => {
    "auth": auth == null ? null : auth?.toJson(),
  };
}

class Auth {
  Auth({
    required this.getOrder,
  });

  GetOrder? getOrder;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
    getOrder: json["getOrder"] == null ? null : GetOrder.fromJson(json["getOrder"]),
  );

  Map<String, dynamic> toJson() => {
    "getOrder": getOrder == null ? null : getOrder?.toJson(),
  };
}

class GetOrder {
  GetOrder({
    required this.id,
    required this.details,
    required this.timedout,
    required this.completed,
  });

  String id;
  String details;
  bool timedout;
  bool completed;

  factory GetOrder.fromJson(Map<String, dynamic> json) => GetOrder(
    id: json["id"] == null ? null : json["id"],
    details: json["details"] == null ? null : json["details"],
    timedout: json["timedout"] == null ? null : json["timedout"],
    completed: json["completed"] == null ? null : json["completed"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "details": details == null ? null : details,
    "timedout": timedout == null ? null : timedout,
    "completed": completed == null ? null : completed,
  };
}
