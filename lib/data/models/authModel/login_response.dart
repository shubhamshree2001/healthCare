class LoginResponse {
  LoginResponse({
    required this.login,
  });

  Login? login;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    login: json["login"] == null ? null : Login.fromJson(json["login"]),
  );

}

class Login {
  Login({
    required this.accessToken,
    required this.refreshToken,
    required this.verifyToken,
  });

  String? accessToken;
  String? refreshToken;
  String? verifyToken;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
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
