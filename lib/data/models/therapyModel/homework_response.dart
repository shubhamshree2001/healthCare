import 'dart:convert';

HomeworkResponse homeworkResponseFromJson(String str) => HomeworkResponse.fromJson(json.decode(str));

String homeworkResponseToJson(HomeworkResponse data) => json.encode(data.toJson());

class HomeworkResponse {
  HomeworkResponse({
    required this.auth,
  });

  Auth? auth;

  factory HomeworkResponse.fromJson(Map<String, dynamic> json) => HomeworkResponse(
    auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
  );

  Map<String, dynamic> toJson() => {
    "auth": auth == null ? null : auth?.toJson(),
  };
}

class Auth {
  Auth({
    required this.homeWorkList,
  });

  List<Homework>? homeWorkList;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
    homeWorkList: json["getHomework"] == null ? null : List<Homework>.from(json["getHomework"].map((x) => Homework.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "getHomework": homeWorkList == null ? null : List<dynamic>.from(homeWorkList!.map((x) => x.toJson())),
  };
}

class Homework {
  Homework({
     this.id,
     this.note,
     this.audio,
     this.files,
     this.userFiles,
     this.thoughts,
     this.isCompleted,
  });

  String? id;
  String? note;
  String? audio;
  List<String>? files;
  String? userFiles;
  String? thoughts;
  bool? isCompleted;

  factory Homework.fromJson(Map<String, dynamic> json) => Homework(
    id: json["id"] == null ? null : json["id"],
    note: json["note"] == null ? null : json["note"],
    audio: json["audio"] == null ? null : json["audio"],
    files: json["files"] == null ? null : List<String>.from(json["files"].map((x) => x)),
    userFiles: json["user_files"] == null ? null : json["user_files"],
    thoughts: json["thoughts"] == null ? null : json["thoughts"],
    isCompleted: json["isCompleted"] == null ? null : json["isCompleted"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "note": note == null ? null : note,
    "audio": audio == null ? null : audio,
    "files": files == null ? null : List<dynamic>.from(files!.map((x) => x)),
    "user_files": userFiles == null ? null : userFiles,
    "thoughts": thoughts == null ? null : thoughts,
    "is_completed": isCompleted == null ? null : isCompleted,

  };
}
