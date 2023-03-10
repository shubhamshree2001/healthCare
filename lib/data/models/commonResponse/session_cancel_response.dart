import 'dart:convert';

SessionCancelResponse sessionCancelResponseFromJson(String str) => SessionCancelResponse.fromJson(json.decode(str));

String sessionCancelResponseToJson(SessionCancelResponse data) => json.encode(data.toJson());

class SessionCancelResponse {
  SessionCancelResponse({
    required this.authMutation,
  });

  AuthMutation? authMutation;

  factory SessionCancelResponse.fromJson(Map<String, dynamic> json) => SessionCancelResponse(
    authMutation: json["authMutation"] == null ? null : AuthMutation.fromJson(json["authMutation"]),
  );

  Map<String, dynamic> toJson() => {
    "authMutation": authMutation == null ? null : authMutation?.toJson(),
  };
}

class AuthMutation {
  AuthMutation({
    required this.update,
  });

  Update? update;

  factory AuthMutation.fromJson(Map<String, dynamic> json) => AuthMutation(
    update: json["update"] == null ? null : Update.fromJson(json["update"]),
  );

  Map<String, dynamic> toJson() => {
    "update": update == null ? null : update?.toJson(),
  };
}

class Update {
  Update({
    required this.cancel,
  });

  bool? cancel;

  factory Update.fromJson(Map<String, dynamic> json) => Update(
    cancel: json["cancel"] == null ? null : json["cancel"],
  );

  Map<String, dynamic> toJson() => {
    "cancel": cancel == null ? null : cancel,
  };
}
