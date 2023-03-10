import 'dart:convert';

import '../therapyModel/doctor_list_response.dart';

CommunityListResponse communityListResponseFromJson(String str) => CommunityListResponse.fromJson(json.decode(str));

String communityListResponseToJson(CommunityListResponse data) => json.encode(data.toJson());

class CommunityListResponse {
  CommunityListResponse({
    required this.auth,
    required this.communityTotal,
    required this.communityLimit,
    required this.communityOffset,
  });

  Auth? auth;
  int? communityTotal;
  int? communityLimit;
  int? communityOffset;

  factory CommunityListResponse.fromJson(Map<String, dynamic> json) => CommunityListResponse(
    auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
    communityTotal: json["communityTotal"] ?? 0,
    communityLimit: json["communityLimit"] ?? 0,
    communityOffset: json["communityOffset"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "auth": auth?.toJson(),
    "communityTotal": communityTotal ?? 0,
    "communityLimit": communityLimit ?? 0,
    "communityOffset": communityOffset ?? 0,
  };
}

class Auth {
  Auth({
    required this.communitiesList,
  });

  List<Community>? communitiesList;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
    communitiesList: json["listCommunities"] == null ? null : List<Community>.from(json["listCommunities"].map((x) => Community.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listCommunities": communitiesList == null ? null : List<dynamic>.from(communitiesList!.map((x) => x.toJson())),
  };
}

class Community {
  Community({
     this.id,
     this.slug ="",
     this.name,
     this.image,
     this.hasNewContent,
     this.description,
     this.follower,
     this.follow = false,
     this.share,
  });

  String? id;
  String? slug;
  String? name;
  ImageData? image;
  HasNewContent? hasNewContent;
  String? description;
  Follower? follower;
  bool? follow;
  Share? share;
  bool isSelected= false;

  factory Community.fromJson(Map<String, dynamic> json) => Community(
    id: json["id"] ?? "",
    slug: json["slug"] ?? "",
    name: json["name"] ?? "",
    image: json["image"] == null ? null : ImageData.fromJson(json["image"]),
    hasNewContent: json["has_new_content"] == null ? null : HasNewContent.fromJson(json["has_new_content"]),
    description: json["description"] ?? "",
    follower: json["follower"] == null ? null : Follower.fromJson(json["follower"]),
    follow: json["follow"] ?? false,
    share: json["share"] == null ? null : Share.fromJson(json["share"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id ?? "",
    "slug": slug ?? "",
    "name": name ?? "",
    "image": image?.toJson(),
    "has_new_content": hasNewContent?.toJson(),
    "description": description ?? "",
    "follower": follower?.toJson(),
    "follow": follow ?? false,
    "share": share?.toJson(),
  };
}

class Follower {
  Follower({
    required this.followerCount,
    required this.followerText,
    required this.followerImages,
  });

  int? followerCount;
  String? followerText;
  List<String>? followerImages;

  factory Follower.fromJson(Map<String, dynamic> json) => Follower(
    followerCount: json["follower_count"] ?? 0,
    followerText: json["follower_text"] ?? "",
    followerImages: json["follower_images"] == null ? null : List<String>.from(json["follower_images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "follower_count": followerCount ?? 0,
    "follower_text": followerText ?? "",
    "follower_images": followerImages == null ? null : List<dynamic>.from(followerImages!.map((x) => x)),
  };
}

class HasNewContent {
  HasNewContent({
    required this.type,
    required this.color,
  });

  String? type;
  String? color;

  factory HasNewContent.fromJson(Map<String, dynamic> json) => HasNewContent(
    type: json["type"]?? "",
    color: json["color"]?? "",
  );

  Map<String, dynamic> toJson() => {
    "type": type?? "",
    "color": color??"",
  };
}

class ImageData {
  ImageData({
     this.banner,
     this.icon,
  });

  String? banner;
  String? icon;

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
    banner: json["banner"] ?? "",
    icon: json["icon"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "banner": banner ?? "",
    "icon": icon ?? "",
  };
}


