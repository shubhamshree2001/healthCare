// To parse this JSON data, do
//
//     final therapySessionListResponse = therapySessionListResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/user_response.dart';
import 'dart:convert';

import '../schedule_list_response.dart';

TherapySessionListResponse therapySessionListResponseFromJson(String str) => TherapySessionListResponse.fromJson(json.decode(str));

String therapySessionListResponseToJson(TherapySessionListResponse data) => json.encode(data.toJson());

class TherapySessionListResponse {
  TherapySessionListResponse({
    required this.auth,
    required this.therapySessionPastTotal,
    required this.therapySessionPastLimit,
    required this.therapySessionPastOffset,
  });

  Auth? auth;
  int? therapySessionPastTotal;
  int? therapySessionPastLimit;
  int? therapySessionPastOffset;

  factory TherapySessionListResponse.fromJson(Map<String, dynamic> json) => TherapySessionListResponse(
    auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
    therapySessionPastTotal: json["therapySessionPastTotal"] ?? 0,
    therapySessionPastLimit: json["therapySessionPastLimit"] ?? 0,
    therapySessionPastOffset: json["therapySessionPastOffset"] ??0,
  );

  Map<String, dynamic> toJson() => {
    "auth": auth == null ? null : auth?.toJson(),
    "therapySessionPastTotal": therapySessionPastTotal == null ? null : therapySessionPastTotal,
    "therapySessionPastLimit": therapySessionPastLimit == null ? null : therapySessionPastLimit,
    "therapySessionPastOffset": therapySessionPastOffset == null ? null : therapySessionPastOffset,
  };
}

class Auth {
  Auth({
    required this.listTherapySessions,
  });

  List<ListTherapySession>? listTherapySessions;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
    listTherapySessions: json["listTherapySessions"] == null ? null : List<ListTherapySession>.from(json["listTherapySessions"].map((x) => ListTherapySession.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listTherapySessions": listTherapySessions == null ? null : List<dynamic>.from(listTherapySessions!.map((x) => x.toJson())),
  };
}

class ListTherapySession {
  ListTherapySession({
     this.session,
     this.canceled,
     this.feedback,
     this.homework,
  });

  Session? session;
  bool? canceled;
  bool? feedback;
  bool? homework;

  factory ListTherapySession.fromJson(Map<String, dynamic> json) => ListTherapySession(
    session: json["session"] == null ? null : Session.fromJson(json["session"]),
    canceled: json["canceled"] == null ? null : json["canceled"],
    feedback: json["feedback"] == null ? null : json["feedback"],
    homework: json["homework"] == null ? null : json["homework"],
  );

  Map<String, dynamic> toJson() => {
    "session": session == null ? null : session?.toJson(),
    "canceled": canceled == null ? null : canceled,
    "feedback": feedback == null ? null : feedback,
    "homework": homework == null ? null : homework,
  };
}

class Session {
  Session({
    required this.doctor,
    required this.id,
    required this.meeting,
    required this.mode,
    required this.schedule,
    required this.issues,
    required this.parent,
  });

  Doctor? doctor;
  String? id;
  String? meeting;
  String? mode;
  Schedule? schedule;
  String? issues;
  Parent? parent;

  factory Session.fromJson(Map<String, dynamic> json) => Session(
    doctor: json["doctor"] == null ? null : Doctor.fromJson(json["doctor"]),
    id: json["id"] == null ? null : json["id"],
    meeting: json["meeting"]==null?null:json["meeting"],
    mode: json["mode"] == null ? null : json["mode"],
    issues: json["issues"] == null ? null : json["issues"],
    schedule: json["schedule"] == null ? null : Schedule.fromJson(json["schedule"]),
    parent: json["parent"] == null ? null : Parent.fromJson(json["parent"]),
  );

  Map<String, dynamic> toJson() => {
    "doctor": doctor == null ? null : doctor?.toJson(),
    "id": id == null ? null : id,
    "meeting": meeting,
    "mode": mode == null ? null : mode,
    "issues": issues == null ? null : issues,
    "schedule": schedule == null ? null : schedule?.toJson(),
    "parent": parent == null ? null : parent?.toJson(),
  };
}

class Doctor {
  Doctor({
    required this.id,
    required this.name,
    required this.profile,
  });

  String? id;
  String? name;
  String? profile;

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] ?? "",
    profile: json["profile"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "profile": profile == null ? null : profile,
  };


}
class Parent {
  Parent({
    required this.name,
    required this.email,
    required this.phone,
  });

  String? name;
  String? email;
  Contact? phone;

  factory Parent.fromJson(Map<String, dynamic> json) => Parent(
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    phone: json["phone"] == null ? null : Contact.fromJson(json["phone"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "phone": phone == null ? null : phone?.toJson(),
  };
}
