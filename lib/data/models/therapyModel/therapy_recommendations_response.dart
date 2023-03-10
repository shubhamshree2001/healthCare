
import 'dart:convert';

TherapyRecommendationsResponse therapyRecommendationsResponseFromJson(String str) => TherapyRecommendationsResponse.fromJson(json.decode(str));

String therapyRecommendationsResponseToJson(TherapyRecommendationsResponse data) => json.encode(data.toJson());

class TherapyRecommendationsResponse {
  TherapyRecommendationsResponse({
    required this.auth,
  });

  Auth? auth;

  factory TherapyRecommendationsResponse.fromJson(Map<String, dynamic> json) => TherapyRecommendationsResponse(
    auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
  );

  Map<String, dynamic> toJson() => {
    "auth": auth == null ? null : auth?.toJson(),
  };
}

class Auth {
  Auth({
    required this.therapyRecommendations,
  });

  TherapyRecommendations? therapyRecommendations;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
    therapyRecommendations: json["getTherapyRecommendations"] == null ? null : TherapyRecommendations.fromJson(json["getTherapyRecommendations"]),
  );

  Map<String, dynamic> toJson() => {
    "getTherapyRecommendations": therapyRecommendations == null ? null : therapyRecommendations?.toJson(),
  };
}

class TherapyRecommendations {
  TherapyRecommendations({
     this.title,
     this.description,
     this.recommendations,
  });

  String? title;
  String? description;
  List<Recommendation>? recommendations;

  factory TherapyRecommendations.fromJson(Map<String, dynamic> json) => TherapyRecommendations(
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    recommendations: json["recommendations"] == null ? null : List<Recommendation>.from(json["recommendations"].map((x) => Recommendation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "recommendations": recommendations == null ? null : List<dynamic>.from(recommendations!.map((x) => x.toJson())),
  };
}

class Recommendation {
  Recommendation({
    required this.kind,
    required this.locked,
    required this.slug,
    required this.image,
    required this.title,
    required this.metadata,
  });

  String? kind;
  bool? locked;
  String? slug;
  String? image;
  String? title;
  dynamic? metadata;

  factory Recommendation.fromJson(Map<String, dynamic> json) => Recommendation(
    kind: json["kind"] == null ? null : json["kind"],
    locked: json["locked"] == null ? null : json["locked"],
    slug: json["slug"] == null ? null : json["slug"],
    image: json["image"] == null ? null : json["image"],
    title: json["title"] == null ? null : json["title"],
    metadata: json["metadata"] == null ? null : json["metadata"],
  );

  Map<String, dynamic> toJson() => {
    "kind": kind == null ? null : kind,
    "locked": locked == null ? null : locked,
    "slug": slug == null ? null : slug,
    "image": image == null ? null : image,
    "title": title == null ? null : title,
    "metadata":metadata == null ? null : metadata,
  };
}
