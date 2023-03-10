import 'dart:convert';

CommonAuthResponse commonAuthResponseFromJson(String str) => CommonAuthResponse.fromJson(json.decode(str));

String commonAuthResponseToJson(CommonAuthResponse data) => json.encode(data.toJson());

class CommonAuthResponse {
  CommonAuthResponse({
    required this.auth,
  });

  Auth? auth;

  factory CommonAuthResponse.fromJson(Map<String, dynamic> json) => CommonAuthResponse(
    auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
  );

  Map<String, dynamic> toJson() => {
    "auth": auth?.toJson(),
  };
}

class Auth {
  Auth({
     this.canRescheduleSession = false,
     this.checkVentStatus = false,
     this.getBoatAvailability = false,
  });

  bool? canRescheduleSession;
  bool? checkVentStatus;
  bool? getBoatAvailability;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
    canRescheduleSession: json["canRescheduleSession"] ?? false,
    checkVentStatus: json["checkVentStatus"] ?? false,
    getBoatAvailability: json["getBoatAvailability"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "canRescheduleSession": canRescheduleSession??false,
    "checkVentStatus": checkVentStatus??false,
    "getBoatAvailability": getBoatAvailability??false,
  };
}
