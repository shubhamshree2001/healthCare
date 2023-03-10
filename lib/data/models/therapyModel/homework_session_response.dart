import 'dart:convert';

HomeworkSessionResponse homeworkSessionResponseFromJson(String str) => HomeworkSessionResponse.fromJson(json.decode(str));

String homeworkSessionResponseToJson(HomeworkSessionResponse data) => json.encode(data.toJson());

class HomeworkSessionResponse {
  HomeworkSessionResponse({
    required this.auth,
  });

  Auth? auth;

  factory HomeworkSessionResponse.fromJson(Map<String, dynamic> json) => HomeworkSessionResponse(
    auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
  );

  Map<String, dynamic> toJson() => {
    "auth": auth == null ? null : auth?.toJson(),
  };
}

class Auth {
  Auth({
    required this.getHomeworkSessions,
  });

  List<HomeworkSession>? getHomeworkSessions;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
    getHomeworkSessions: json["getHomeworkSessions"] == null ? null : List<HomeworkSession>.from(json["getHomeworkSessions"].map((x) => HomeworkSession.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "getHomeworkSessions": getHomeworkSessions == null ? null : List<dynamic>.from(getHomeworkSessions!.map((x) => x.toJson())),
  };
}

class HomeworkSession {
  HomeworkSession({
    required this.date,
    required this.sessions,
  });

  String date;
  List<HomeWorkSessionItem>? sessions;

  factory HomeworkSession.fromJson(Map<String, dynamic> json) => HomeworkSession(
    date: json["date"] == null ? null : json["date"],
    sessions: json["sessions"] == null ? null : List<HomeWorkSessionItem>.from(json["sessions"].map((x) => HomeWorkSessionItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": date == null ? null : date,
    "sessions": sessions == null ? null : List<dynamic>.from(sessions!.map((x) => x.toJson())),
  };
}

class HomeWorkSessionItem {
  HomeWorkSessionItem({
     this.doctor,
     this.session,
     this.schedule,
  });

  String? doctor;
  String? session;
  String? schedule;

  factory HomeWorkSessionItem.fromJson(Map<String, dynamic> json) => HomeWorkSessionItem(
    doctor: json["doctor"] == null ? null : json["doctor"],
    session: json["session"] == null ? null : json["session"],
    schedule: json["schedule"] == null ? null : json["schedule"],
  );

  Map<String, dynamic> toJson() => {
    "doctor": doctor == null ? null : doctor,
    "session": session == null ? null : session,
    "schedule": schedule == null ? null : schedule,
  };
}
