// To parse this JSON data, do
//
//     final listModuleFilterResponse = listModuleFilterResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ListModuleFilterResponse listModuleFilterResponseFromJson(String str) =>
    ListModuleFilterResponse.fromJson(json.decode(str));

String listModuleFilterResponseToJson(ListModuleFilterResponse data) =>
    json.encode(data.toJson());

class ListModuleFilterResponse {
  ListModuleFilterResponse({
    required this.auth,
  });

  Auth? auth;

  factory ListModuleFilterResponse.fromJson(Map<String, dynamic> json) =>
      ListModuleFilterResponse(
        auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
      );

  Map<String, dynamic> toJson() => {
        "auth": auth == null ? null : auth?.toJson(),
      };
}

class Auth {
  Auth({
    required this.listModuleFilters,
  });

  List<ListModuleFilter>? listModuleFilters;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        listModuleFilters: json["listModuleFilters"] == null
            ? null
            : List<ListModuleFilter>.from(json["listModuleFilters"]
                .map((x) => ListModuleFilter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "listModuleFilters": listModuleFilters == null
            ? null
            : List<dynamic>.from(listModuleFilters!.map((x) => x.toJson())),
      };
}

class ListModuleFilter {
  ListModuleFilter({
    required this.id,
    required this.name,
    required this.parent,
    required this.level,
    required this.description,
  });

  String? id;
  String? name;
  String? parent;
  int? level;
  String? description;

  factory ListModuleFilter.fromJson(Map<String, dynamic> json) =>
      ListModuleFilter(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        parent: json["parent"] == null ? null : json["parent"],
        level: json["level"] == null ? null : json["level"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "parent": parent == null ? null : parent,
        "level": level == null ? null : level,
        "description": description == null ? null : description,
      };
}
