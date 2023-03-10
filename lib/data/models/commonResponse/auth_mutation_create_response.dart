import 'dart:convert';

AuthMutationCreateResponse authMutationCreateResponseFromJson(String str) => AuthMutationCreateResponse.fromJson(json.decode(str));

String authMutationCreateResponseToJson(AuthMutationCreateResponse data) => json.encode(data.toJson());

class AuthMutationCreateResponse {
  AuthMutationCreateResponse({
    required this.authMutation,
  });

  AuthMutation? authMutation;

  factory AuthMutationCreateResponse.fromJson(Map<String, dynamic> json) => AuthMutationCreateResponse(
    authMutation: json["authMutation"] == null ? null : AuthMutation.fromJson(json["authMutation"]),
  );

  Map<String, dynamic> toJson() => {
    "authMutation": authMutation == null ? null : authMutation?.toJson(),
  };
}

class AuthMutation {
  AuthMutation({
    required this.create,
  });

  Create? create;

  factory AuthMutation.fromJson(Map<String, dynamic> json) => AuthMutation(
    create: json["create"] == null ? null : Create.fromJson(json["create"]),
  );

  Map<String, dynamic> toJson() => {
    "create": create == null ? null : create?.toJson(),
  };
}

class Create {
  Create({
    required this.submitFeedbackV2,
  });

  String? submitFeedbackV2;

  factory Create.fromJson(Map<String, dynamic> json) => Create(
    submitFeedbackV2: json["submitFeedbackV2"] == null ? null : json["submitFeedbackV2"],
  );

  Map<String, dynamic> toJson() => {
    "submitFeedbackV2": submitFeedbackV2 == null ? null : submitFeedbackV2,
  };
}
