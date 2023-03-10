import 'dart:convert';

EventNotifyResponse eventNotifyResponseFromJson(String str) => EventNotifyResponse.fromJson(json.decode(str));

String eventNotifyResponseToJson(EventNotifyResponse data) => json.encode(data.toJson());

class EventNotifyResponse {
  EventNotifyResponse({
    required this.authMutation,
  });

  AuthMutation? authMutation;

  factory EventNotifyResponse.fromJson(Map<String, dynamic> json) => EventNotifyResponse(
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
    required this.eventNotify,
  });

  String eventNotify;

  factory Create.fromJson(Map<String, dynamic> json) => Create(
    eventNotify: json["eventNotify"] == null ? null : json["eventNotify"],
  );

  Map<String, dynamic> toJson() => {
    "eventNotify": eventNotify == null ? null : eventNotify,
  };
}
