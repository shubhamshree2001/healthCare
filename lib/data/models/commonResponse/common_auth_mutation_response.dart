import 'dart:convert';

CommonAuthMutationResponse commonAuthMutationResponseFromJson(String str) => CommonAuthMutationResponse.fromJson(json.decode(str));

String commonAuthMutationResponseToJson(CommonAuthMutationResponse data) => json.encode(data.toJson());

class CommonAuthMutationResponse {
  CommonAuthMutationResponse({
    required this.authMutation,
  });

  AuthMutation? authMutation;

  factory CommonAuthMutationResponse.fromJson(Map<String, dynamic> json) => CommonAuthMutationResponse(
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
    required this.rescheduleSession,
    required this.communityFollow,
    required this.updateVent,
  });

  bool? rescheduleSession;
  String? communityFollow;
  String? updateVent;

  factory Update.fromJson(Map<String, dynamic> json) => Update(
    rescheduleSession: json["rescheduleSession"] == null ? null : json["rescheduleSession"],
    communityFollow: json["communityFollow"] == null ? null : json["communityFollow"],
    updateVent: json["updateVent"] == null ? null : json["updateVent"],
  );

  Map<String, dynamic> toJson() => {
    "rescheduleSession": rescheduleSession == null ? null : rescheduleSession,
    "communityFollow": communityFollow == null ? null : communityFollow,
    "updateVent": updateVent == null ? null : updateVent,
  };
}
