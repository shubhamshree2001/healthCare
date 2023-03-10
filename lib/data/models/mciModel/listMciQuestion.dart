// To parse this JSON data, do
//
//     final getListOfMciQuestionResponse = getListOfMciQuestionResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetListOfMciQuestionResponse getListOfMciQuestionResponseFromJson(String str) =>
    GetListOfMciQuestionResponse.fromJson(json.decode(str));

String getListOfMciQuestionResponseToJson(GetListOfMciQuestionResponse data) =>
    json.encode(data.toJson());

class GetListOfMciQuestionResponse {
  GetListOfMciQuestionResponse({
    required this.auth,
    required this.myPlansTotal,
    required this.mciQuestionsLimit,
    required this.mciQuestionsOffset,
  });

  Auth? auth;
  int? myPlansTotal;
  int? mciQuestionsLimit;
  int? mciQuestionsOffset;

  factory GetListOfMciQuestionResponse.fromJson(Map<String, dynamic> json) =>
      GetListOfMciQuestionResponse(
        auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
        myPlansTotal:
            json["myPlansTotal"] == null ? null : json["myPlansTotal"],
        mciQuestionsLimit: json["mciQuestionsLimit"] == null
            ? null
            : json["mciQuestionsLimit"],
        mciQuestionsOffset: json["mciQuestionsOffset"] == null
            ? null
            : json["mciQuestionsOffset"],
      );

  Map<String, dynamic> toJson() => {
        "auth": auth == null ? null : auth?.toJson(),
        "myPlansTotal": myPlansTotal == null ? null : myPlansTotal,
        "mciQuestionsLimit":
            mciQuestionsLimit == null ? null : mciQuestionsLimit,
        "mciQuestionsOffset":
            mciQuestionsOffset == null ? null : mciQuestionsOffset,
      };
}

class Auth {
  Auth({
    required this.listMciQuestions,
  });

  ListMciQuestions? listMciQuestions;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        listMciQuestions: json["listMciQuestions"] == null
            ? null
            : ListMciQuestions.fromJson(json["listMciQuestions"]),
      );

  Map<String, dynamic> toJson() => {
        "listMciQuestions":
            listMciQuestions == null ? null : listMciQuestions?.toJson(),
      };
}

class ListMciQuestions {
  ListMciQuestions({
    this.id,
    this.questions,
  });

  String? id;
  List<Question>? questions;

  factory ListMciQuestions.fromJson(Map<String, dynamic> json) =>
      ListMciQuestions(
        id: json["id"] == null ? null : json["id"],
        questions: json["questions"] == null
            ? null
            : List<Question>.from(
                json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "questions": questions == null
            ? null
            : List<dynamic>.from(questions!.map((x) => x.toJson())),
      };
}

class Question {
  Question({
    this.id,
    this.type,
    this.fieldType,
    this.heading,
    this.question,
    this.background,
    this.options,
  });

  String? id;
  String? type;
  String? fieldType;
  String? heading;
  String? question;
  Background? background;
  String? startTime;
  String? endTime;
  List<Option>? options;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : json["type"],
        fieldType: json["field_type"] == null ? null : json["field_type"],
        heading: json["heading"] == null ? "" : json["heading"],
        question: json["question"] == null ? null : json["question"],
        background: json["background"] == null
            ? null
            : Background.fromJson(json["background"]),
        options: json["options"] == null
            ? null
            : List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "type": type == null ? null : type,
        "field_type": fieldType,
        "heading": heading == null ? "" : heading,
        "question": question == null ? null : question,
        "background": background == null ? null : background?.toJson(),
        "options": options == null
            ? null
            : List<dynamic>.from(options!.map((x) => x.toJson())),
      };
}

class Background {
  Background({
    required this.type,
    required this.image,
  });

  String? type;
  String? image;

  factory Background.fromJson(Map<String, dynamic> json) => Background(
        type: json["type"] == null ? null : json["type"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "image": image == null ? null : image,
      };
}

class Option {
  Option({
    this.id,
    this.name,
    this.value,
    this.order,
  });

  String? id;
  String? name;
  String? value;
  String? order;

  bool isChecked = false;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        value: json["value"] == null ? null : json["value"],
        order: json["order"] == null ? null : json["order"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "value": value == null ? null : value,
        "order": order == null ? null : order,
      };
}
