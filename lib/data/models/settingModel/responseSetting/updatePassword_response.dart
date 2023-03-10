// To parse this JSON data, do
//
//     final updatePassword = updatePasswordFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UpdatePasswordResponse updatePasswordFromJson(String str) =>
    UpdatePasswordResponse.fromJson(json.decode(str));

String updatePasswordToJson(UpdatePasswordResponse data) =>
    json.encode(data.toJson());

class UpdatePasswordResponse {
  UpdatePasswordResponse({
    required this.authMutation,
  });

  AuthMutation? authMutation;

  factory UpdatePasswordResponse.fromJson(Map<String, dynamic> json) =>
      UpdatePasswordResponse(
        authMutation: json["authMutation"] == null
            ? null
            : AuthMutation.fromJson(json["authMutation"]),
      );

  Map<String, dynamic> toJson() =>
      {"authMutation": authMutation == null ? null : authMutation?.toJson};
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
    required this.updatePassword,
  });

  bool updatePassword;

  factory Update.fromJson(Map<String, dynamic> json) => Update(
        updatePassword:
            json["updatePassword"] == null ? null : json["updatePassword"],
      );

  Map<String, dynamic> toJson() => {
        "updatePassword": updatePassword == null ? null : updatePassword,
      };
}
