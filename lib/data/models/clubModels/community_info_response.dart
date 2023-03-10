// To parse this JSON data, do
//
//     final communityInfoResponse = communityInfoResponseFromJson(jsonString);

import 'dart:convert';

import 'community_list_response.dart';

CommunityInfoResponse communityInfoResponseFromJson(String str) => CommunityInfoResponse.fromJson(json.decode(str));

String communityInfoResponseToJson(CommunityInfoResponse data) => json.encode(data.toJson());

class CommunityInfoResponse {
  CommunityInfoResponse({
    required this.auth,
  });

  Auth? auth;

  factory CommunityInfoResponse.fromJson(Map<String, dynamic> json) => CommunityInfoResponse(
    auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
  );

  Map<String, dynamic> toJson() => {
    "auth": auth?.toJson(),
  };
}

class Auth {
  Auth({
    required this.communityInfo,
  });

  CommunityInfo? communityInfo;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
    communityInfo: json["getCommunityInfo"] == null ? null : CommunityInfo.fromJson(json["getCommunityInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "getCommunityInfo":communityInfo?.toJson(),
  };
}

class CommunityInfo {
  CommunityInfo({
     this.id,
     this.name,
     this.description,
     this.moderators,
     this.locked,
     this.resources,
     this.follower,
  });

  String? id;
  String? name;
  String? description;
  List<Moderator>? moderators;
  bool? locked;
  List<ResourceItem>? resources;
  Follower? follower;

  factory CommunityInfo.fromJson(Map<String, dynamic> json) => CommunityInfo(
    id: json["id"] ?? "",
    name: json["name"] ?? "",
    description: json["description"] ?? "",
    moderators: json["moderators"] == null ? null : List<Moderator>.from(json["moderators"].map((x) => Moderator.fromJson(x))),
    locked: json["locked"] ?? false,
    resources: json["resources"] == null ? null : List<ResourceItem>.from(json["resources"].map((x) => ResourceItem.fromJson(x))),
    follower: json["follower"] == null ? null : Follower.fromJson(json["follower"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id ?? "",
    "name": name ?? "",
    "description": description ?? "",
    "moderators": moderators == null ? null : List<dynamic>.from(moderators!.map((x) => x.toJson())),
    "locked": locked ?? false,
    "resources": resources == null ? null : List<dynamic>.from(resources!.map((x) => x.toJson())),
    "follower": follower?.toJson(),
  };
}


class Moderator {
  Moderator({
    required this.name,
    required this.photo,
    required this.verified,
    required this.title,
  });

  String? name;
  String? photo;
  bool? verified;
  String? title;

  factory Moderator.fromJson(Map<String, dynamic> json) => Moderator(
    name: json["name"] ?? "",
    photo: json["photo"] ?? "",
    verified: json["verified"] ?? false,
    title: json["title"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "name": name ?? "",
    "photo": photo ?? "",
    "verified": verified ?? false,
    "title": title ?? "",
  };
}

class ResourceItem {
  ResourceItem({
     this.name = "",
     this.date = "",
     this.url = "",
     this.locked = true,
     this.uploadedBy ="",
  });

  String? name;
  String? date;
  String? url;
  bool? locked;
  String? uploadedBy;

  factory ResourceItem.fromJson(Map<String, dynamic> json) => ResourceItem(
    name: json["name"] ?? "",
    date: json["date"] ?? "",
    url: json["url"] ?? "",
    locked: json["locked"] ?? "",
    uploadedBy: json["uploaded_by"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "name": name ?? "",
    "date": date ?? "",
    "url": url ?? "",
    "locked": locked ?? false,
    "uploaded_by": uploadedBy ?? "",
  };
}
