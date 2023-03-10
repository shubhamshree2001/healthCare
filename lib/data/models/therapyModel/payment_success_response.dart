
import 'dart:convert';

PaymentSuccessResponse paymentSuccessResponseFromJson(String str) => PaymentSuccessResponse.fromJson(json.decode(str));

String paymentSuccessResponseToJson(PaymentSuccessResponse data) => json.encode(data.toJson());

class PaymentSuccessResponse {
  PaymentSuccessResponse({
   required this.authMutation,
  });

  AuthMutation? authMutation;

  factory PaymentSuccessResponse.fromJson(Map<String, dynamic> json) => PaymentSuccessResponse(
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
   required this.success,
  });

  bool success;

  factory Update.fromJson(Map<String, dynamic> json) => Update(
    success: json["success"] == null ? null : json["success"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
  };
}
