// To parse this JSON data, do
//
//     final therapyReviewsResponse = therapyReviewsResponseFromJson(jsonString);

import 'dart:convert';

TherapyReviewsResponse therapyReviewsResponseFromJson(String str) => TherapyReviewsResponse.fromJson(json.decode(str));

String therapyReviewsResponseToJson(TherapyReviewsResponse data) => json.encode(data.toJson());

class TherapyReviewsResponse {
  TherapyReviewsResponse({
    required this.auth,
    required this.reviewTotal,
    required this.reviewLimit,
    required this.reviewOffset,
  });

  Auth? auth;
  int? reviewTotal;
  int? reviewLimit;
  int? reviewOffset;

  factory TherapyReviewsResponse.fromJson(Map<String, dynamic> json) => TherapyReviewsResponse(
    auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
    reviewTotal: json["reviewTotal"] == null ? null : json["reviewTotal"],
    reviewLimit: json["reviewLimit"] == null ? null : json["reviewLimit"],
    reviewOffset: json["reviewOffset"] == null ? null : json["reviewOffset"],

  );

  Map<String, dynamic> toJson() => {
    "auth": auth == null ? null : auth?.toJson(),
    "reviewTotal": reviewTotal == null ? null : reviewTotal,
    "reviewLimit": reviewLimit == null ? null : reviewLimit,
    "reviewOffset": reviewOffset == null ? null : reviewOffset,
  };
}

class Auth {
  Auth({
   required this.reviewList,
  });

  List<String>? reviewList;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
    reviewList: json["listReviews"] == null ? null : List<String>.from(json["listReviews"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "listReviews": reviewList == null ? null : List<dynamic>.from(reviewList!.map((x) => x)),
  };
}
