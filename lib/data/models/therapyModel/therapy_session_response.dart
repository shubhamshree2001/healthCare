import 'dart:convert';

import 'package:mindpeers_mobile_flutter/data/models/therapyModel/request/therapy_session_list_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/schedule_list_response.dart';

TherapySessionResponse therapySessionResponseFromJson(String str) => TherapySessionResponse.fromJson(json.decode(str));

String therapySessionResponseToJson(TherapySessionResponse data) => json.encode(data.toJson());

class TherapySessionResponse {
  TherapySessionResponse({
    required this.auth,
  });

  Auth? auth;

  factory TherapySessionResponse.fromJson(Map<String, dynamic> json) => TherapySessionResponse(
    auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
  );

  Map<String, dynamic> toJson() => {
    "auth": auth == null ? null : auth?.toJson(),
  };
}

class Auth {
  Auth({
    required this.therapySession,
  });

  TherapySession? therapySession;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
    therapySession: json["getTherapySession"] == null ? null : TherapySession.fromJson(json["getTherapySession"]),
  );

  Map<String, dynamic> toJson() => {
    "getTherapySession": therapySession == null ? null : therapySession?.toJson(),
  };
}

class TherapySession {
  TherapySession({
    required this.type,
    required this.feedback,
    required this.session,
  });

  String? type;
  bool? feedback;
  Session? session;

  factory TherapySession.fromJson(Map<String, dynamic> json) => TherapySession(
    type: json["type"] == null ? null : json["type"],
    feedback: json["feedback"] == null ? null : json["feedback"],
    session: json["session"] == null ? null : Session.fromJson(json["session"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "feedback": feedback == null ? null : feedback,
    "session": session == null ? null : session?.toJson(),
  };
}

