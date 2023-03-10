// To parse this JSON data, do
//
//     final updateUser = updateUserFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UpdateUserResponse updateUserResponseFromJson(String str) =>
    UpdateUserResponse.fromJson(json.decode(str));

String updateUserResponseToJson(UpdateUserResponse data) =>
    json.encode(data.toJson());

class UpdateUserResponse {
  UpdateUserResponse({
    required this.authMutation,
  });

  List<AuthMutation>? authMutation;

  factory UpdateUserResponse.fromJson(Map<String, dynamic> json) =>
      UpdateUserResponse(
        authMutation: json["authMutation"] == null
            ? null
            : List<AuthMutation>.from(
                json["authMutation"].map((x) => AuthMutation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "authMutation": authMutation == null
            ? null
            : List<dynamic>.from(authMutation!.map((x) => x.toJson())),
      };
}

class AuthMutation {
  AuthMutation({
    required this.update,
  });

  List<Update>? update;

  factory AuthMutation.fromJson(Map<String, dynamic> json) => AuthMutation(
        update: json["update"] == null
            ? null
            : List<Update>.from(json["update"].map((x) => Update.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "update": update == null
            ? null
            : List<dynamic>.from(update!.map((x) => x.toJson())),
      };
}

class Update {
  Update({
    required this.updateUser,
  });

  String updateUser;

  factory Update.fromJson(Map<String, dynamic> json) => Update(
        updateUser: json["updateUser"] == null ? null : json["updateUser"],
      );

  Map<String, dynamic> toJson() => {
        "updateUser": updateUser == null ? null : updateUser,
      };
}
