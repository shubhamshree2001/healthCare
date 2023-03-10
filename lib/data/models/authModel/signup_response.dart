class SignupResponse {
  SignupResponse({
    required this.signup,
  });

  Signup? signup;

  factory SignupResponse.fromJson(Map<String, dynamic> json) => SignupResponse(
    signup: json["signupUser"] == null ? null : Signup.fromJson(json["signupUser"]),
  );

}

class Signup {
  Signup({
    required this.accessToken,
    required this.refreshToken,
    required this.verifyToken,
  });

  String? accessToken;
  String? refreshToken;
  String? verifyToken;

  factory Signup.fromJson(Map<String, dynamic> json) => Signup(
    accessToken: json["accessToken"] == null ? null : json["accessToken"],
    refreshToken: json["refreshToken"] == null ? null : json["refreshToken"],
    verifyToken: json["verifyToken"] == null ? null : json["verifyToken"],
  );


  Map<String, dynamic> toJson() =>
      {
        "accessToken": accessToken == null ? null : accessToken,
        "refreshToken": refreshToken == null ? null : refreshToken,
        "verifyToken": verifyToken == null ? null : verifyToken
      };

}
