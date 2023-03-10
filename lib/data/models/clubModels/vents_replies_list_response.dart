import 'dart:convert';

VentRepliesListResponse ventRepliesListResponseFromJson(String str) => VentRepliesListResponse.fromJson(json.decode(str));

String ventRepliesListResponseToJson(VentRepliesListResponse data) => json.encode(data.toJson());

class VentRepliesListResponse {
  VentRepliesListResponse({
    required this.auth,
    required this.ventOutWallRepliesTotal,
    required this.ventOutWallRepliesLimit,
    required this.ventOutWallRepliesOffset,
  });

  Auth? auth;
  int ventOutWallRepliesTotal;
  int ventOutWallRepliesLimit;
  int ventOutWallRepliesOffset;

  factory VentRepliesListResponse.fromJson(Map<String, dynamic> json) => VentRepliesListResponse(
    auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
    ventOutWallRepliesTotal: json["ventOutWallRepliesTotal"] == null ? null : json["ventOutWallRepliesTotal"],
    ventOutWallRepliesLimit: json["ventOutWallRepliesLimit"] == null ? null : json["ventOutWallRepliesLimit"],
    ventOutWallRepliesOffset: json["ventOutWallRepliesOffset"] == null ? null : json["ventOutWallRepliesOffset"],
  );

  Map<String, dynamic> toJson() => {
    "auth": auth == null ? null : auth?.toJson(),
    "ventOutWallRepliesTotal": ventOutWallRepliesTotal == null ? null : ventOutWallRepliesTotal,
    "ventOutWallRepliesLimit": ventOutWallRepliesLimit == null ? null : ventOutWallRepliesLimit,
    "ventOutWallRepliesOffset": ventOutWallRepliesOffset == null ? null : ventOutWallRepliesOffset,
  };
}

class Auth {
  Auth({
    required this.listVentReplies,
  });

  ListVentReplies? listVentReplies;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
    listVentReplies: json["listVentReplies"] == null ? null : ListVentReplies.fromJson(json["listVentReplies"]),
  );

  Map<String, dynamic> toJson() => {
    "listVentReplies": listVentReplies == null ? null : listVentReplies?.toJson(),
  };
}

class ListVentReplies {
  ListVentReplies({
    required this.lastFetchedTime,
    required this.replies,
  });

  String? lastFetchedTime;
  List<Reply>? replies;

  factory ListVentReplies.fromJson(Map<String, dynamic> json) => ListVentReplies(
    lastFetchedTime: json["last_fetched_time"] ?? "",
    replies: json["replies"] == null ? null : List<Reply>.from(json["replies"].map((x) => Reply.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "last_fetched_time": lastFetchedTime ?? "",
    "replies": replies == null ? null : List<dynamic>.from(replies!.map((x) => x.toJson())),
  };
}

class Reply {
  Reply({
     this.id,
     this.message = "",
     this.userName ="",
     this.avatar = "",
     this.ventTime = "",
     this.locked=false,
     this.verified=false,
     this.userTitle="",
  });

  String? id;
  String? message;
  String? userName;
  String? avatar;
  String? ventTime;
  bool? locked;
  bool? verified;
  String? userTitle;

  factory Reply.fromJson(Map<String, dynamic> json) => Reply(
    id: json["id"] ?? "",
    message: json["message"] ?? "",
    userName: json["user_name"] ?? "",
    avatar: json["avatar"] ?? "",
    ventTime: json["vent_time"] ?? "",
    locked: json["locked"] ?? "",
    verified: json["verified"] ?? "",
    userTitle: json["user_title"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id ?? "",
    "message": message ?? "",
    "user_name": userName ?? "",
    "avatar": avatar ?? "",
    "vent_time": ventTime ?? "",
    "locked": locked ?? "",
    "verified": verified ?? "",
    "user_title": userTitle ?? "",
  };
}
