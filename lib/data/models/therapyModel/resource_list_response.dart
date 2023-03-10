// To parse this JSON data, do
//
//     final resourceListResponse = resourceListResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ResourceListResponse resourceListResponseFromJson(String str) => ResourceListResponse.fromJson(json.decode(str));

String resourceListResponseToJson(ResourceListResponse data) => json.encode(data.toJson());

class ResourceListResponse {
  ResourceListResponse({
    required this.auth,
  });

  Auth? auth;

  factory ResourceListResponse.fromJson(Map<String, dynamic> json) => ResourceListResponse(
    auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
  );

  Map<String, dynamic> toJson() => {
    "auth": auth == null ? null : auth?.toJson(),
  };
}

class Auth {
  Auth({
    required this.resourceList,
  });

  List<Resource>? resourceList;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
    resourceList: json["listResources"] == null ? null : List<Resource>.from(json["listResources"].map((x) => Resource.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listResources": resourceList == null ? null : List<dynamic>.from(resourceList!.map((x) => x.toJson())),
  };
}

class Resource {
  Resource({
    required this.style,
    required this.image,
    required this.mobileImage,
    required this.title,
    required this.subtitle,
    required this.redirect,
  });

  String? style;
  String? image;
  String? mobileImage;
  String? title;
  String? subtitle;
  String? redirect;

  factory Resource.fromJson(Map<String, dynamic> json) => Resource(
    style: json["style"] == null ? null : json["style"],
    image: json["image"] == null ? null : json["image"],
    mobileImage: json["mobileImage"] == null ? null : json["mobileImage"],
    title: json["title"] == null ? null : json["title"],
    subtitle: json["subtitle"] == null ? null : json["subtitle"],
    redirect: json["redirect"] == null ? null : json["redirect"],
  );

  Map<String, dynamic> toJson() => {
    "style": style == null ? null : style,
    "image": image == null ? null : image,
    "mobileImage": mobileImage == null ? null : mobileImage,
    "title": title == null ? null : title,
    "subtitle": subtitle == null ? null : subtitle,
    "redirect": redirect == null ? null : redirect,
  };
}
