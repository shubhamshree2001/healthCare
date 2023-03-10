// To parse this JSON data, do
//
//     final errorResponse = errorResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ErrorResponse errorResponseFromJson(String str) => ErrorResponse.fromJson(json.decode(str));

String errorResponseToJson(ErrorResponse data) => json.encode(data.toJson());

class ErrorResponse {
  ErrorResponse({
    required this.errors,
  });

  List<Error>? errors;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
    errors: json["errors"] == null ? null : List<Error>.from(json["errors"].map((x) => Error.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "errors": errors == null ? null : List<dynamic>.from(errors!.map((x) => x.toJson())),
  };
}

class Error {
  Error({
    required this.code,
    required this.message,
    required this.extensions,
  });

  String code;
  String message;
  Extensions? extensions;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    extensions: json["extensions"] == null ? null : Extensions.fromJson(json["extensions"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "extensions": extensions == null ? null : extensions?.toJson(),
  };
}

class Extensions {
  Extensions({
    required this.code,
  });

  String code;

  factory Extensions.fromJson(Map<String, dynamic> json) => Extensions(
    code: json["code"] == null ? null : json["code"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
  };
}
