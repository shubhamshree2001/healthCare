// To parse this JSON data, do
//
//     final submitMciResponse = submitMciResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SubmitMciResponse submitMciResponseFromJson(String str) =>
    SubmitMciResponse.fromJson(json.decode(str));

String submitMciResponseToJson(SubmitMciResponse data) =>
    json.encode(data.toJson());

class SubmitMciResponse {
  SubmitMciResponse({
    required this.authMutation,
  });

  AuthMutation? authMutation;

  factory SubmitMciResponse.fromJson(Map<String, dynamic> json) =>
      SubmitMciResponse(
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
    required this.submitMci,
  });

  bool submitMci;

  factory Update.fromJson(Map<String, dynamic> json) => Update(
        submitMci: json["submitMCI"] == null ? null : json["submitMCI"],
      );

  Map<String, dynamic> toJson() => {
        "submitMCI": submitMci == null ? null : submitMci,
      };
}
