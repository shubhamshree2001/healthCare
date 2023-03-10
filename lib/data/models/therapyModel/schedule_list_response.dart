
import 'dart:convert';

ScheduleListResponse scheduleListResponseFromJson(String str) => ScheduleListResponse.fromJson(json.decode(str));

String scheduleListResponseToJson(ScheduleListResponse data) => json.encode(data.toJson());

class ScheduleListResponse {
  ScheduleListResponse({
    required this.auth,
  });

  Auth? auth;

  factory ScheduleListResponse.fromJson(Map<String, dynamic> json) => ScheduleListResponse(
    auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
  );

  Map<String, dynamic> toJson() => {
    "auth": auth == null ? null : auth?.toJson(),
  };
}

class Auth {
  Auth({
    required this.scheduleList,
  });

  List<Schedule>? scheduleList;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
    scheduleList: json["listSchedules"] == null ? null : List<Schedule>.from(json["listSchedules"].map((x) =>Schedule.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listSchedules": scheduleList == null ? null : List<dynamic>.from(scheduleList!.map((x) => x.toJson())),
  };
}


class Schedule {
  Schedule({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.info,
  });

  String? id;
  String? startDate;
  String? endDate;
  String? info;
  bool isChecked=false;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
    id: json["id"] == null ? null : json["id"],
    startDate: json["start_date"] == null ? null : json["start_date"],
    endDate: json["end_date"] == null ? null : json["end_date"],
    info:  json["info"] == null ? null : json["info"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "start_date": startDate == null ? null : startDate,
    "end_date": endDate == null ? null : endDate,
    "info":  info == null ? null : info,
  };
}

