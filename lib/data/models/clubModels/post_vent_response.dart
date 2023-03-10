// To parse this JSON data, do
//
//     final postVentResponse = postVentResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PostVentResponse postVentResponseFromJson(String str) => PostVentResponse.fromJson(json.decode(str));

String postVentResponseToJson(PostVentResponse data) => json.encode(data.toJson());

class PostVentResponse {
  PostVentResponse({
    required this.authMutation,
  });

  AuthMutation? authMutation;

  factory PostVentResponse.fromJson(Map<String, dynamic> json) => PostVentResponse(
    authMutation: json["authMutation"] == null ? null : AuthMutation.fromJson(json["authMutation"]),
  );

  Map<String, dynamic> toJson() => {
    "authMutation": authMutation == null ? null : authMutation?.toJson(),
  };
}

class AuthMutation {
  AuthMutation({
    required this.create,
  });

  Create? create;

  factory AuthMutation.fromJson(Map<String, dynamic> json) => AuthMutation(
    create: json["create"] == null ? null : Create.fromJson(json["create"]),
  );

  Map<String, dynamic> toJson() => {
    "create": create == null ? null : create?.toJson(),
  };
}

class Create {
  Create({
    required this.postVent,
  });

  String? postVent;

  factory Create.fromJson(Map<String, dynamic> json) => Create(
    postVent: json["postVent"] == null ? null : json["postVent"],
  );

  Map<String, dynamic> toJson() => {
    "postVent": postVent == null ? null : postVent,
  };
}
