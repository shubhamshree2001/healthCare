import 'dart:convert';

import '../therapyModel/doctor_list_response.dart';
import 'community_list_response.dart';

VentListResponse ventListResponseFromJson(String str) => VentListResponse.fromJson(json.decode(str));

String ventListResponseToJson(VentListResponse data) => json.encode(data.toJson());

class VentListResponse {
  VentListResponse({
    required this.auth,
    required this.ventOutWallMessagesTotal,
    required this.ventOutWallMessagesLimit,
    required this.ventOutWallMessagesOffset,
  });

  Auth? auth;
  int ventOutWallMessagesTotal;
  int ventOutWallMessagesLimit;
  int ventOutWallMessagesOffset;

  factory VentListResponse.fromJson(Map<String, dynamic> json) => VentListResponse(
    auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
    ventOutWallMessagesTotal: json["ventOutWallMessagesTotal"] ?? 0,
    ventOutWallMessagesLimit: json["ventOutWallMessagesLimit"] ?? 0,
    ventOutWallMessagesOffset: json["ventOutWallMessagesOffset"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "auth": auth?.toJson(),
    "ventOutWallMessagesTotal": ventOutWallMessagesTotal,
    "ventOutWallMessagesLimit": ventOutWallMessagesLimit,
    "ventOutWallMessagesOffset": ventOutWallMessagesOffset,
  };
}

class Auth {
  Auth({
    required this.listVents,
  });

  ListVents? listVents;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
    listVents: json["listVents"] == null ? null : ListVents.fromJson(json["listVents"]),
  );

  Map<String, dynamic> toJson() => {
    "listVents": listVents == null ? null : listVents!.toJson(),
  };
}

class ListVents {
  ListVents({
    required this.ventList,
    required this.lastFetchedTime,
  });

  List<Vent>? ventList;
  String lastFetchedTime;

  factory ListVents.fromJson(Map<String, dynamic> json) => ListVents(
    ventList: json["vents"] == null ? null : List<Vent>.from(json["vents"].map((x) => Vent.fromJson(x))),
    lastFetchedTime: json["last_fetched_time"] ??"",
  );

  Map<String, dynamic> toJson() => {
    "vents": ventList == null ? null : List<dynamic>.from(ventList!.map((x) => x.toJson())),
    "last_fetched_time": lastFetchedTime,
  };
}

class Vent {
  Vent({
     this.id,
     this.userName="",
     this.message="",
     this.verified=false,
     this.userTitle="",
     this.avatar="",
     this.ventTime="",
     this.likesCount= 0,
     this.repliesCount=0,
     this.isLiked=false,
     this.isSensitive=false,
     this.isGiftingEnabled = false,
     this.share,
     this.type,
     this.backgroundImage ="",
     this.text="",
     this.image="",
     this.isAnonymous=false,
     this.resources,
     this.resourceObjects,
     this.cta,
     this.pinned,
     this.locked =false,
     this.community
  });

  String? id;
  String? userName;
  String? message;
  bool? verified;
  String? userTitle;
  String? avatar;
  String? ventTime;
  int? likesCount;
  int? repliesCount;
  bool? isLiked;
  bool? isSensitive;
  bool? isGiftingEnabled;
  Share? share;
  String? type;
  String? backgroundImage;
  String? text;
  String? image;
  bool? isAnonymous;
  List<String>? resources;
  List<ResourceObject>? resourceObjects;
  Cta? cta;
  bool? pinned;
  bool? locked;
  Community? community;

  factory Vent.fromJson(Map<String, dynamic> json) => Vent(
    id: json["id"] ?? "",
    userName: json["user_name"] ?? "",
    message: json["message"] ?? "",
    verified: json["verified"] ?? false,
    userTitle: json["user_title"] ?? "",
    avatar: json["avatar"] ?? "",
    ventTime: json["vent_time"] ?? "",
    likesCount: json["likes_count"] ?? 0,
    repliesCount: json["replies_count"] ?? 0,
    isLiked: json["is_liked"] ?? false,
    isSensitive: json["is_sensitive"] ?? false,
    isGiftingEnabled: json["is_gifting_enabled"] ?? false,
    share: json["share"] == null ? null : Share.fromJson(json["share"]),
    type: json["type"] ?? "",
    backgroundImage: json["background_image"]??"",
    text: json["text"]??"",
    image: json["image"]??"",
    isAnonymous: json["is_anonymous"] ?? false,
    resources: json["resources"] == null ? null : List<String>.from(json["resources"].map((x) => x)),
    resourceObjects: json["resource_objects"] == null ? null : List<ResourceObject>.from(json["resource_objects"].map((x) => ResourceObject.fromJson(x))),
    cta: json["cta"] == null ? null : Cta?.fromJson(json["cta"]),
    pinned: json["pinned"] ?? false,
    locked: json["locked"] ?? false,
    community: json["community"] == null ? null : Community?.fromJson(json["community"]),

  );

  Map<String, dynamic> toJson() => {
    "id": id ?? null,
    "user_name": userName ?? null,
    "message": message ?? null,
    "verified": verified ?? null,
    "user_title": userTitle ?? null,
    "avatar": avatar ?? null,
    "vent_time": ventTime ?? null,
    "likes_count": likesCount ?? null,
    "replies_count": repliesCount ?? null,
    "is_liked": isLiked ?? null,
    "is_sensitive": isSensitive ?? null,
    "is_gifting_enabled": isGiftingEnabled ?? null,
    "share": share == null ? null : share?.toJson(),
    "type": type ?? null,
    "background_image": backgroundImage,
    "text": text??"",
    "image": image??"",
    "is_anonymous": isAnonymous ?? null,
    "resources": resources == null ? null : List<dynamic>.from(resources!.map((x) => x)),
    "resource_objects": resourceObjects == null ? null : List<dynamic>.from(resourceObjects!.map((x) => x.toJson())),
    "cta": cta == null ? null : cta?.toJson(),
    "pinned": pinned ?? null,
    "locked": locked ?? null,
    "community": community == null ? null : community?.toJson(),
  };
}

class Cta {
  Cta({
    required this.text,
    required this.wait,
    required this.deeplink,
  });

  String text;
  String wait;
  Deeplink? deeplink;

  factory Cta.fromJson(Map<String, dynamic> json) => Cta(
    text: json["text"] ?? "",
    wait: json["wait"]??"",
    deeplink: json["deeplink"] == null ? null : Deeplink.fromJson(json["deeplink"]),
  );

  Map<String, dynamic> toJson() => {
    "text": text ?? null,
    "wait": wait??"",
    "deeplink": deeplink == null ? null : deeplink?.toJson(),
  };
}

class Deeplink {
  Deeplink({
    required this.screen,
    required this.paramOne,
    required this.paramTwo,
  });

  String screen;
  String paramOne;
  String paramTwo;

  factory Deeplink.fromJson(Map<String, dynamic> json) => Deeplink(
    screen: json["screen"] ?? "",
    paramOne: json["paramOne"]??"",
    paramTwo: json["paramTwo"]??"",
  );

  Map<String, dynamic> toJson() => {
    "screen": screen ?? null,
    "paramOne": paramOne??"",
    "paramTwo": paramTwo??"",
  };
}

class ResourceObject {
  ResourceObject({
    required this.name,
    required this.date,
    this.url = "",
    this.locked = true,
    required this.uploadedBy,
  });

  String? name;
  String? date;
  String? url;
  bool? locked;
  String uploadedBy;

  factory ResourceObject.fromJson(Map<String, dynamic> json) => ResourceObject(
    name: json["name"] ?? "",
    date: json["date"] ?? "",
    url: json["url"] ?? "",
    locked: json["locked"] ?? true,
    uploadedBy: json["uploaded_by"]??"",
  );

  Map<String, dynamic> toJson() => {
    "name": name ?? null,
    "date": date,
    "url": url ?? "",
    "locked": locked ?? true,
    "uploaded_by": uploadedBy,
  };
}

