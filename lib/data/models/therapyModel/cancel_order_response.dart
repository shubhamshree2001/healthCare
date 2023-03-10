// To parse this JSON data, do
//
//     final cancelOrderResponse = cancelOrderResponseFromJson(jsonString);

import 'dart:convert';

CancelOrderResponse cancelOrderResponseFromJson(String str) => CancelOrderResponse.fromJson(json.decode(str));

String cancelOrderResponseToJson(CancelOrderResponse data) => json.encode(data.toJson());

class CancelOrderResponse {
  CancelOrderResponse({
    required this.authMutation,
  });

  AuthMutation? authMutation;

  factory CancelOrderResponse.fromJson(Map<String, dynamic> json) => CancelOrderResponse(
    authMutation: json["authMutation"] == null ? null : AuthMutation.fromJson(json["authMutation"]),
  );

  Map<String, dynamic> toJson() => {
    "authMutation": authMutation == null ? null : authMutation?.toJson(),
  };
}

class AuthMutation {
  AuthMutation({
    required this.update,
  });

  Update? update;

  factory AuthMutation.fromJson(Map<String, dynamic> json) => AuthMutation(
    update: json["update"] == null ? null : Update.fromJson(json["update"]),
  );

  Map<String, dynamic> toJson() => {
    "update": update == null ? null : update?.toJson(),
  };
}

class Update {
  Update({
    required this.cancelOrder,
  });

  bool cancelOrder;

  factory Update.fromJson(Map<String, dynamic> json) => Update(
    cancelOrder: json["cancelOrder"] == null ? null : json["cancelOrder"],
  );

  Map<String, dynamic> toJson() => {
    "cancelOrder": cancelOrder == null ? null : cancelOrder,
  };
}
