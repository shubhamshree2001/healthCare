// To parse this JSON data, do
//
//     final submitModuleStatisticsResponse = submitModuleStatisticsResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SubmitModuleStatisticsResponse submitModuleStatisticsResponseFromJson(
        String str) =>
    SubmitModuleStatisticsResponse.fromJson(json.decode(str));

String submitModuleStatisticsResponseToJson(
        SubmitModuleStatisticsResponse data) =>
    json.encode(data.toJson());

class SubmitModuleStatisticsResponse {
  SubmitModuleStatisticsResponse({
    required this.authMutation,
  });

  AuthMutation? authMutation;

  factory SubmitModuleStatisticsResponse.fromJson(Map<String, dynamic> json) =>
      SubmitModuleStatisticsResponse(
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
    required this.submitModuleStatistics,
  });

  bool submitModuleStatistics;

  factory Update.fromJson(Map<String, dynamic> json) => Update(
        submitModuleStatistics: json["submitModuleStatistics"] == null
            ? null
            : json["submitModuleStatistics"],
      );

  Map<String, dynamic> toJson() => {
        "submitModuleStatistics":
            submitModuleStatistics == null ? null : submitModuleStatistics,
      };
}
