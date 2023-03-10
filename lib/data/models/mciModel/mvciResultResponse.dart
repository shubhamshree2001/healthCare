// To parse this JSON data, do
//
//     final getMciResultResponse = getMciResultResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:mindpeers_mobile_flutter/data/models/mciModel/listMciQuestion.dart';

GetMciResultResponse getMciResultResponseFromJson(String str) =>
    GetMciResultResponse.fromJson(json.decode(str));

String getMciResultResponseToJson(GetMciResultResponse data) =>
    json.encode(data.toJson());

class GetMciResultResponse {
  GetMciResultResponse({
    required this.auth,
  });

  Auth? auth;

  factory GetMciResultResponse.fromJson(Map<String, dynamic> json) =>
      GetMciResultResponse(
        auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
      );

  Map<String, dynamic> toJson() => {
        "auth": auth == null ? null : auth?.toJson(),
      };
}

class Auth {
  Auth({
    required this.getMciResult,
  });

  GetMciResult? getMciResult;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        getMciResult: json["getMciResult"] == null
            ? null
            : GetMciResult.fromJson(json["getMciResult"]),
      );

  Map<String, dynamic> toJson() => {
        "getMciResult": getMciResult == null ? null : getMciResult?.toJson(),
      };
}

class GetMciResult {
  GetMciResult({
    required this.ready,
    required this.questions,
    required this.report,
  });

  bool ready;
  //List<Question>? questions;
  List<Question>? questions;
  List<Report>? report;

  factory GetMciResult.fromJson(Map<String, dynamic> json) => GetMciResult(
        ready: json["ready"] == null ? null : json["ready"],
        questions: //json["questions"] == null
            //     ? null
            //     : Question.fromJson(json["questions"]),
            json["questions"] == null
                ? null
                : List<Question>.from(
                    json["questions"].map((x) => Question.fromJson(x))),
        report: json["report"] == null
            ? null
            : List<Report>.from(json["report"].map((x) => Report.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ready": ready == null ? null : ready,
        "questions": //questions == null ? null : questions?.toJson(),
            questions == null
                ? null
                : List<dynamic>.from(questions!.map((x) => x.toJson())),
        "report": report == null
            ? null
            : List<dynamic>.from(report!.map((x) => x.toJson())),
      };
}

// class Question {
//   Question({
//     required this.id,
//     required this.type,
//     required this.fieldType,
//     required this.heading,
//     required this.question,
//     required this.background,
//     required this.options,
//   });

//   String? id;
//   String? type;
//   String? fieldType;
//   String? heading;
//   String? question;
//   Background? background;
//   List<Option>? options;

//   factory Question.fromJson(Map<String, dynamic> json) => Question(
//         id: json["id"],
//         type: json["type"] == null ? null : json["type"],
//         fieldType: json["field_type"] == null ? null : json["field_type"],
//         heading: json["heading"] == null ? null : json["heading"],
//         question: json["question"] == null ? null : json["question"],
//         background: json["background"] == null
//             ? null
//             : Background.fromJson(json["background"]),
//         options: json["options"] == null
//             ? null
//             : List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "type": type == null ? null : type,
//         "field_type": fieldType == null ? null : fieldType,
//         "heading": heading == null ? null : heading,
//         "question": question == null ? null : question,
//         "background": background == null ? null : background?.toJson(),
//         "options": options == null
//             ? null
//             : List<dynamic>.from(options!.map((x) => x.toJson())),
//       };
// }

// class Background {
//   Background({
//     required this.type,
//     required this.image,
//   });

//   String? type;
//   String? image;

//   factory Background.fromJson(Map<String, dynamic> json) => Background(
//         type: json["type"] == null ? null : json["type"],
//         image: json["image"] == null ? null : json["image"],
//       );

//   Map<String, dynamic> toJson() => {
//         "type": type == null ? null : type,
//         "image": image == null ? null : image,
//       };
// }

// class Option {
//   Option({
//     required this.id,
//     required this.name,
//     required this.value,
//     required this.order,
//   });

//   String? id;
//   String? name;
//   String? value;
//   String? order;

//   factory Option.fromJson(Map<String, dynamic> json) => Option(
//         id: json["id"] == null ? null : json["id"],
//         name: json["name"] == null ? null : json["name"],
//         value: json["value"] == null ? null : json["value"],
//         order: json["order"] == null ? null : json["order"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id == null ? null : id,
//         "name": name == null ? null : name,
//         "value": value == null ? null : value,
//         "order": order == null ? null : order,
//       };
// }

class Report {
  Report({
    this.type,
    this.heading,
    this.cards,
  });

  String? type;
  String? heading;
  List<Cards>? cards;

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        type: json["type"] == null ? null : json["type"],
        heading: json["heading"] == null ? null : json["heading"],
        cards: json["cards"] == null
            ? null
            : List<Cards>.from(json["cards"].map((x) => Cards.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "heading": heading == null ? null : heading,
        "cards": cards == null
            ? null
            : List<dynamic>.from(cards!.map((x) => x.toJson())),
      };
}

class Cards {
  Cards({
    required this.cardType,
    required this.heading,
    required this.image,
    required this.background,
    required this.text,
    required this.score,
  });

  String? cardType;
  String? heading;
  String? image;
  String? background;
  String? text;
  int? score;

  factory Cards.fromJson(Map<String, dynamic> json) => Cards(
        cardType: json["card_type"] == null ? null : json["card_type"],
        heading: json["heading"] == null ? null : json["heading"],
        image: json["image"] == null ? null : json["image"],
        background: json["background"] == null ? null : json["background"],
        text: json["text"] == null ? null : json["text"],
        score: json["score"] == null ? null : json["score"],
      );

  Map<String, dynamic> toJson() => {
        "card_type": cardType == null ? null : cardType,
        "heading": heading == null ? null : heading,
        "image": image == null ? null : image,
        "background": background == null ? null : background,
        "text": text == null ? null : text,
        "score": score == null ? null : score,
      };
}
