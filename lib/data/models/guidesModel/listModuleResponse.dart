// To parse this JSON data, do
//
//     final listModuleResponse = listModuleResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ListModuleResponse listModuleResponseFromJson(String str) =>
    ListModuleResponse.fromJson(json.decode(str));

String listModuleResponseToJson(ListModuleResponse data) =>
    json.encode(data.toJson());

class ListModuleResponse {
  ListModuleResponse({
    required this.auth,
    required this.moduleLimit,
    required this.moduleOffset,
  });

  Auth? auth;
  int? moduleLimit;
  int? moduleOffset;

  factory ListModuleResponse.fromJson(Map<String, dynamic> json) =>
      ListModuleResponse(
        auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
        moduleLimit: json["moduleLimit"] == null ? null : json["moduleLimit"],
        moduleOffset:
            json["moduleOffset"] == null ? null : json["moduleOffset"],
      );

  Map<String, dynamic> toJson() => {
        "auth": auth == null ? null : auth?.toJson(),
        "moduleLimit": moduleLimit == null ? null : moduleLimit,
        "moduleOffset": moduleOffset == null ? null : moduleOffset,
      };
}

class Auth {
  Auth({
    required this.listModules,
  });

  List<ListModule>? listModules;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        listModules: json["listModules"] == null
            ? null
            : List<ListModule>.from(
                json["listModules"].map((x) => ListModule.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "listModules": listModules == null
            ? null
            : List<dynamic>.from(listModules!.map((x) => x.toJson())),
      };
}

class ListModule {
  ListModule({
    required this.text,
    required this.image,
    required this.locked,
    required this.slug,
    required this.filters,
    required this.statistics,
  });

  String? text;
  String? image;
  bool? locked;
  String? slug;
  List<String>? filters;
  Statistics? statistics;

  factory ListModule.fromJson(Map<String, dynamic> json) => ListModule(
        text: json["text"] == null ? null : json["text"],
        image: json["image"] == null ? null : json["image"],
        locked: json["locked"] == null ? null : json["locked"],
        slug: json["slug"] == null ? null : json["slug"],
        filters: json["filters"] == null
            ? null
            : List<String>.from(json["filters"].map((x) => x)),
        statistics: json["statistics"] == null
            ? null
            : Statistics.fromJson(json["statistics"]),
      );

  Map<String, dynamic> toJson() => {
        "text": text == null ? null : text,
        "image": image == null ? null : image,
        "locked": locked == null ? null : locked,
        "slug": slug == null ? null : slug,
        "filters":
            filters == null ? null : List<dynamic>.from(filters!.map((x) => x)),
        "statistics": statistics == null ? null : statistics?.toJson(),
      };
}

class Statistics {
  Statistics({
    required this.streams,
    required this.time,
  });

  String? streams;
  String? time;

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
        streams: json["streams"] == null ? null : json["streams"],
        time: json["time"] == null ? null : json["time"],
      );

  Map<String, dynamic> toJson() => {
        "streams": streams == null ? null : streams,
        "time": time == null ? null : time,
      };
}
