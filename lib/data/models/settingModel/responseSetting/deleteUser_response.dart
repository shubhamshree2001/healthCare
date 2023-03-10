// To parse this JSON data, do
//
//     final deleteUserResponse = deleteUserResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DeleteUserResponse deleteUserResponseFromJson(String str) =>
    DeleteUserResponse.fromJson(json.decode(str));

String deleteUserResponseToJson(DeleteUserResponse data) =>
    json.encode(data.toJson());

class DeleteUserResponse {
  DeleteUserResponse({
    required this.authMutation,
  });

  AuthMutation? authMutation;

  factory DeleteUserResponse.fromJson(Map<String, dynamic> json) =>
      DeleteUserResponse(
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
    @required this.deleteUser,
  });

  String? deleteUser;

  factory Update.fromJson(Map<String, dynamic> json) => Update(
        deleteUser: json["deleteUser"] == null ? null : json["deleteUser"],
      );

  Map<String, dynamic> toJson() => {
        "deleteUser": deleteUser == null ? null : deleteUser,
      };
}
