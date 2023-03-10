import 'dart:convert';

CreditHistoryResponse creditHistoryResponseFromJson(String str) => CreditHistoryResponse.fromJson(json.decode(str));

String creditHistoryResponseToJson(CreditHistoryResponse data) => json.encode(data.toJson());

class CreditHistoryResponse {
  CreditHistoryResponse({
    required this.auth,
  });

  Auth? auth;

  factory CreditHistoryResponse.fromJson(Map<String, dynamic> json) => CreditHistoryResponse(
    auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
  );

  Map<String, dynamic> toJson() => {
    "auth": auth == null ? null : auth?.toJson(),
  };
}

class Auth {
  Auth({
    required this.creditHistoryList,
  });

  List<CreditHistory>? creditHistoryList;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
    creditHistoryList: json["getCreditHistory"] == null ? null : List<CreditHistory>.from(json["getCreditHistory"].map((x) => CreditHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "getCreditHistory": creditHistoryList == null ? null : List<dynamic>.from(creditHistoryList!.map((x) => x.toJson())),
  };
}

class CreditHistory {
  CreditHistory({
    required this.name,
    required this.credits,
  });

  String? name;
  int? credits;

  factory CreditHistory.fromJson(Map<String, dynamic> json) => CreditHistory(
    name: json["name"] == null ? null : json["name"],
    credits: json["credits"] == null ? null : json["credits"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "credits": credits == null ? null : credits,
  };
}
