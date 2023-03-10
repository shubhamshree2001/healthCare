
import 'dart:convert';

EventListResponse eventListResponseFromJson(String str) => EventListResponse.fromJson(json.decode(str));

String eventListResponseToJson(EventListResponse data) => json.encode(data.toJson());

class EventListResponse {
  EventListResponse({
   required this.auth,
   required this.communityEventsTotal,
   required this.communityEventsLimit,
   required this.communityEventsOffset,
  });

  Auth? auth;
  int communityEventsTotal;
  int communityEventsLimit;
  int communityEventsOffset;

  factory EventListResponse.fromJson(Map<String, dynamic> json) => EventListResponse(
    auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
    communityEventsTotal: json["communityEventsTotal"] == null ? null : json["communityEventsTotal"],
    communityEventsLimit: json["communityEventsLimit"] == null ? null : json["communityEventsLimit"],
    communityEventsOffset: json["communityEventsOffset"] == null ? null : json["communityEventsOffset"],
  );

  Map<String, dynamic> toJson() => {
    "auth": auth == null ? null : auth?.toJson(),
    "communityEventsTotal": communityEventsTotal == null ? null : communityEventsTotal,
    "communityEventsLimit": communityEventsLimit == null ? null : communityEventsLimit,
    "communityEventsOffset": communityEventsOffset == null ? null : communityEventsOffset,
  };
}

class Auth {
  Auth({
   required this.eventList,
  });

  List<CommunityEvent>? eventList;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
    eventList: json["listCommunityEvents"] == null ? null : List<CommunityEvent>.from(json["listCommunityEvents"].map((x) => CommunityEvent.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listCommunityEvents": eventList == null ? null : List<dynamic>.from(eventList!.map((x) => x.toJson())),
  };
}

class CommunityEvent {
  CommunityEvent({
   required this.id,
   required this.kind,
   required this.slug,
   required this.name,
   required this.image,
   required this.locked,
   required this.start,
   required this.type,
   required this.backgroundImage,
   required this.text,
   required this.end,
   required this.isBooked,
    this.isLive = false,
   required this.enrolled,
   // required this.community,
   required this.cta,
  });

  String? id;
  String? kind;
  String? slug;
  String? name;
  String? image;
  bool? locked;
  String? start;
  String? type;
  String? backgroundImage;
  String? text;
  String? end;
  bool? isBooked;
  bool? isLive =false;
  Enrolled? enrolled;
 // Community? community;
  Cta? cta;

  factory CommunityEvent.fromJson(Map<String, dynamic> json) => CommunityEvent(
    id: json["id"] == null ? null : json["id"],
    kind: json["kind"] == null ? null : json["kind"],
    slug: json["slug"] == null ? null : json["slug"],
    name: json["name"] == null ? null : json["name"],
    image: json["image"] == null ? null : json["image"],
    locked: json["locked"] == null ? null : json["locked"],
    start: json["start"] == null ? null : json["start"],
    type: json["type"] == null ? null : json["type"],
    backgroundImage: json["background_image"],
    text: json["text"],
    end: json["end"] == null ? null : json["end"],
    isBooked: json["is_booked"] == null ? null : json["is_booked"],
    isLive: json["is_live"] ?? false,
    enrolled: json["enrolled"] == null ? null : Enrolled.fromJson(json["enrolled"]),
   // community: json["community"] == null ? null : json["community"],
    cta: json["cta"] == null ? null : Cta?.fromJson(json["cta"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "kind": kind == null ? null : kind,
    "slug": slug == null ? null : slug,
    "name": name == null ? null : name,
    "image": image == null ? null : image,
    "locked": locked == null ? null : locked,
    "start": start == null ? null : start,
    "type": type == null ? null : type,
    "background_image": backgroundImage,
    "text": text,
    "end": end == null ? null : end,
    "is_booked": isBooked == null ? null : isBooked,
    "is_live": isLive == null ? null : isLive,
    "enrolled": enrolled == null ? null : enrolled?.toJson(),
  //  "community": community == null ? null : community?.toJson(),
    "cta": cta == null ? null : cta?.toJson(),
  };
}

class Community {
  Community({
   required this.name,
  });

  String? name;

  factory Community.fromJson(Map<String, dynamic> json) => Community(
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
  };
}

class Cta {
  Cta({
   required this.text,
   required this.deeplink,
  });

  String? text;
  Deeplink? deeplink;

  factory Cta.fromJson(Map<String, dynamic> json) => Cta(
    text: json["text"] == null ? null : json["text"],
    deeplink: json["deeplink"] == null ? null : Deeplink.fromJson(json["deeplink"]),
  );

  Map<String, dynamic> toJson() => {
    "text": text == null ? null : text,
    "deeplink": deeplink == null ? null : deeplink?.toJson(),
  };
}

class Deeplink {
  Deeplink({
   required this.screen,
   required this.paramOne,
   required this.paramTwo,
  });

  String? screen;
  String? paramOne;
  String? paramTwo;

  factory Deeplink.fromJson(Map<String, dynamic> json) => Deeplink(
    screen: json["screen"] == null ? null : json["screen"],
    paramOne: json["paramOne"]??"",
    paramTwo: json["paramTwo"]??"",
  );

  Map<String, dynamic> toJson() => {
    "screen": screen == null ? null : screen,
    "paramOne": paramOne??"",
    "paramTwo": paramTwo??"",
  };
}

class Enrolled {
  Enrolled({
   required this.enrolledCount,
   required this.color,
   required this.enrolledText,
   required this.enrolledUserPhoto,
  });

  int? enrolledCount;
  String? color;
  String? enrolledText;
  List<String>? enrolledUserPhoto;

  factory Enrolled.fromJson(Map<String, dynamic> json) => Enrolled(
    enrolledCount: json["enrolled_count"]??0,
    color: json["color"] == null ? null : json["color"],
    enrolledText: json["enrolled_text"] == null ? null : json["enrolled_text"],
    enrolledUserPhoto: json["enrolled_user_photo"] == null ? null : List<String>.from(json["enrolled_user_photo"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "enrolled_count": enrolledCount??0,
    "color": color == null ? null : color,
    "enrolled_text": enrolledText == null ? null : enrolledText,
    "enrolled_user_photo": enrolledUserPhoto == null ? null : List<dynamic>.from(enrolledUserPhoto!.map((x) => x)),
  };
}
