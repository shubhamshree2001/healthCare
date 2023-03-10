// To parse this JSON data, do
//
//     final submitGiftCouponResponse = submitGiftCouponResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SubmitGiftCouponResponse submitGiftCouponResponseFromJson(String str) =>
    SubmitGiftCouponResponse.fromJson(json.decode(str));

String submitGiftCouponResponseToJson(SubmitGiftCouponResponse data) =>
    json.encode(data.toJson());

class SubmitGiftCouponResponse {
  SubmitGiftCouponResponse({
    required this.authMutation,
  });

  AuthMutation? authMutation;

  factory SubmitGiftCouponResponse.fromJson(Map<String, dynamic> json) =>
      SubmitGiftCouponResponse(
        authMutation: json["authMutation"] == null
            ? null
            : AuthMutation.fromJson(json["authMutation"]),
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
    required this.redeemGiftv2,
  });

  RedeemGiftv2? redeemGiftv2;

  factory Update.fromJson(Map<String, dynamic> json) => Update(
        redeemGiftv2: json["redeemGiftv2"] == null
            ? null
            : RedeemGiftv2.fromJson(json["redeemGiftv2"]),
      );

  Map<String, dynamic> toJson() => {
        "redeemGiftv2": redeemGiftv2 == null ? null : redeemGiftv2?.toJson(),
      };
}

class RedeemGiftv2 {
  RedeemGiftv2({
    required this.expiry,
    required this.success,
  });

  DateTime? expiry;
  bool success;

  factory RedeemGiftv2.fromJson(Map<String, dynamic> json) => RedeemGiftv2(
        expiry: json["expiry"] == null ? null : DateTime.parse(json["expiry"]),
        success: json["success"] == null ? null : json["success"],
      );

  Map<String, dynamic> toJson() => {
        "expiry": expiry == null ? null : expiry?.toIso8601String(),
        "success": success == null ? null : success,
      };
}
