class OtpVerifyResponse {
  OtpVerifyResponse({
   required this.verifyOtp,
  });

  VerifyOtp? verifyOtp;

  factory OtpVerifyResponse.fromJson(Map<String, dynamic> json) => OtpVerifyResponse(
    verifyOtp: json["verify"] == null ? null : VerifyOtp.fromJson(json["verify"]),
  );

}

class VerifyOtp {
  VerifyOtp({
   required this.accessToken,
   required this.refreshToken,
   required this.verifyToken,
  });

  String? accessToken;
  String? refreshToken;
  String? verifyToken;

  factory VerifyOtp.fromJson(Map<String, dynamic> json) => VerifyOtp(
    accessToken: json["accessToken"] == null ? null : json["accessToken"],
    refreshToken: json["refreshToken"] == null ? null : json["refreshToken"],
    verifyToken: json["verifyToken"] == null ? null : json["verifyToken"],

  );

}
