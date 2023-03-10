import 'dart:convert';
import '../therapyModel/doctor_list_response.dart';
import '../therapyModel/therapy_gift_plan_response.dart';
import 'event_list_response.dart';

BoatResponse boatResponseFromJson(String str) => BoatResponse.fromJson(json.decode(str));

String boatResponseToJson(BoatResponse data) => json.encode(data.toJson());

class BoatResponse {
  BoatResponse({
    required this.auth,
  });

  Auth? auth;

  factory BoatResponse.fromJson(Map<String, dynamic> json) => BoatResponse(
    auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
  );

  Map<String, dynamic> toJson() => {
    "auth": auth == null ? null : auth?.toJson(),
  };
}

class Auth {
  Auth({
    required this.boat,
  });

  Boat? boat;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
    boat: json["getBoat"] == null ? null : Boat.fromJson(json["getBoat"]),
  );

  Map<String, dynamic> toJson() => {
    "getBoat": boat == null ? null : boat?.toJson(),
  };
}

class Boat {
  Boat({
     this.id,
     this.title ="",
     this.image ="",
     this.description = "",
     this.type = "",
     this.booked,
     this.locked = false,
     this.enrolled,
     this.cta,
     this.facilitator,
     this.share,
     this.cards,
     this.mode,
     this.video,
     this.price,
     this.slots,
     this.slug,
     this.meeting,
     this.startAt,
     this.endAt,
     this.categories,
     this.status,
     this.region,
     this.summary,
  });

  String? id;
  String? title;
  String? image;
  String? description;
  String? type;
  bool? booked;
  bool? locked;
  Enrolled? enrolled;
  Cta? cta;
  Facilitator? facilitator;
  Share? share;
  List<Card>? cards;
  String? mode;
  String? video;
  int? price;
  int? slots;
  String? slug;
  String? meeting;
  String? startAt;
  String? endAt;
  List<String>? categories;
  String? status;
  Region? region;
  Summary? summary;

  factory Boat.fromJson(Map<String, dynamic> json) => Boat(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    image: json["image"] == null ? null : json["image"],
    description: json["description"] == null ? null : json["description"],
    type: json["type"] == null ? null : json["type"],
    booked: json["booked"] == null ? null : json["booked"],
    locked: json["locked"] == null ? null : json["locked"],
    enrolled: json["enrolled"] == null ? null : Enrolled.fromJson(json["enrolled"]),
    cta: json["cta"] == null ? null : Cta.fromJson(json["cta"]),
    facilitator: json["facilitator"] == null ? null : Facilitator.fromJson(json["facilitator"]),
    share: json["share"] == null ? null : Share.fromJson(json["share"]),
    cards: json["cards"] == null ? null : List<Card>.from(json["cards"].map((x) => Card.fromJson(x))),
    mode: json["mode"] == null ? null : json["mode"],
    video: json["video"] == null ? null : json["video"],
    price: json["price"] == null ? null : json["price"],
    slots: json["slots"] == null ? null : json["slots"],
    slug: json["slug"] == null ? null : json["slug"],
    meeting: json["meeting"] == null ? null : json["meeting"],
    startAt: json["start_at"] == null ? null : json["start_at"],
    endAt: json["end_at"] == null ? null : json["end_at"],
    categories: json["categories"] == null ? null : List<String>.from(json["categories"].map((x) => x)),
    status: json["status"] == null ? null : json["status"],
    region: json["region"] == null ? null : Region.fromJson(json["region"]),
    summary: json["summary"] == null ? null : Summary.fromJson(json["summary"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "image": image == null ? null : image,
    "description": description == null ? null : description,
    "type": type == null ? null : type,
    "booked": booked == null ? null : booked,
    "locked": locked == null ? null : locked,
    "enrolled": enrolled == null ? null : enrolled?.toJson(),
    "cta": cta == null ? null : cta?.toJson(),
    "facilitator": facilitator == null ? null : facilitator?.toJson(),
    "share": share == null ? null : share?.toJson(),
    "cards": cards == null ? null : List<dynamic>.from(cards!.map((x) => x.toJson())),
    "mode": mode == null ? null : mode,
    "video": video == null ? null : video,
    "price": price == null ? null : price,
    "slots": slots == null ? null : slots,
    "slug": slug == null ? null : slug,
    "meeting": meeting == null ? null : meeting,
    "start_at": startAt == null ? null : startAt,
    "end_at": endAt == null ? null : endAt,
    "categories": categories == null ? null : List<dynamic>.from(categories!.map((x) => x)),
    "status": status == null ? null : status,
    "region": region == null ? null : region?.toJson(),
    "summary": summary == null ? null : summary?.toJson(),
  };
}

class Card {
  Card({
    required this.title,
    required this.data,
  });

  String? title;
  List<String>? data;

  factory Card.fromJson(Map<String, dynamic> json) => Card(
    title: json["title"] == null ? null : json["title"],
    data: json["data"] == null ? null : List<String>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x)),
  };
}

class Cta {
  Cta({
    required this.text,
    required this.wait,
    required this.deeplink,
  });

  String? text;
  String? wait;
  Deeplink? deeplink;

  factory Cta.fromJson(Map<String, dynamic> json) => Cta(
    text: json["text"] == null ? null : json["text"],
    wait: json["wait"]??"",
    deeplink: json["deeplink"] == null ? null : Deeplink.fromJson(json["deeplink"]),
  );

  Map<String, dynamic> toJson() => {
    "text": text == null ? null : text,
    "wait": wait,
    "deeplink": deeplink == null ? null : deeplink?.toJson(),
  };
}

class Facilitator {
  Facilitator({
    required this.name,
    required this.photo,
    required this.title,
    required this.redirect,
    required this.verified,
  });

  String name;
  String photo;
  String title;
  String redirect;
  bool verified;

  factory Facilitator.fromJson(Map<String, dynamic> json) => Facilitator(
    name: json["name"] == null ? null : json["name"],
    photo: json["photo"] == null ? null : json["photo"],
    title: json["title"] == null ? null : json["title"],
    redirect: json["redirect"] == null ? null : json["redirect"],
    verified: json["verified"] == null ? null : json["verified"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "photo": photo == null ? null : photo,
    "title": title == null ? null : title,
    "redirect": redirect == null ? null : redirect,
    "verified": verified == null ? null : verified,
  };
}

