// To parse this JSON data, do
//
//     final feedbackQuestionsListResponse = feedbackQuestionsListResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

FeedbackQuestionsListResponse feedbackQuestionsListResponseFromJson(
        String str) =>
    FeedbackQuestionsListResponse.fromJson(json.decode(str));

String feedbackQuestionsListResponseToJson(
        FeedbackQuestionsListResponse data) =>
    json.encode(data.toJson());

class FeedbackQuestionsListResponse {
  FeedbackQuestionsListResponse({
    required this.auth,
  });

  Auth? auth;

  factory FeedbackQuestionsListResponse.fromJson(Map<String, dynamic> json) =>
      FeedbackQuestionsListResponse(
        auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
      );

  Map<String, dynamic> toJson() => {
        "auth": auth == null ? null : auth?.toJson(),
      };
}

class Auth {
  Auth({
    required this.getSettingsMenuData,
  });

  GetSettingsMenuData? getSettingsMenuData;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        getSettingsMenuData: json["getSettingsMenuData"] == null
            ? null
            : GetSettingsMenuData.fromJson(json["getSettingsMenuData"]),
      );

  Map<String, dynamic> toJson() => {
        "getSettingsMenuData":
            getSettingsMenuData == null ? null : getSettingsMenuData?.toJson(),
      };
}

class GetSettingsMenuData {
  GetSettingsMenuData({
    required this.questions,
  });

  Questions? questions;

  factory GetSettingsMenuData.fromJson(Map<String, dynamic> json) =>
      GetSettingsMenuData(
        questions: json["questions"] == null
            ? null
            : Questions.fromJson(json["questions"]),
      );

  Map<String, dynamic> toJson() => {
        "questions": questions == null ? null : questions?.toJson(),
      };
}

class Questions {
  Questions({
    this.appFeedbackQuestion,
    this.starRatingQuestion,
    this.userFeedbackQuestion,
  });

  Question? appFeedbackQuestion;
  Question? starRatingQuestion;
  Question? userFeedbackQuestion;

  factory Questions.fromJson(Map<String, dynamic> json) => Questions(
        appFeedbackQuestion: json["app_feedback_question"] == null
            ? null
            : Question.fromJson(json["app_feedback_question"]),
        starRatingQuestion: json["star_rating_question"] == null
            ? null
            : Question.fromJson(json["star_rating_question"]),
        userFeedbackQuestion: json["user_feedback_question"] == null
            ? null
            : Question.fromJson(json["user_feedback_question"]),
      );

  Map<String, dynamic> toJson() => {
        "app_feedback_question":
            appFeedbackQuestion == null ? null : appFeedbackQuestion?.toJson(),
        "star_rating_question":
            starRatingQuestion == null ? null : starRatingQuestion?.toJson(),
        "user_feedback_question": userFeedbackQuestion == null
            ? null
            : userFeedbackQuestion?.toJson(),
      };
}

class Question {
  Question({
    required this.id,
    required this.kind,
    required this.question,
  });

  String id;
  String kind;
  String question;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"] == null ? null : json["id"],
        kind: json["kind"] == null ? null : json["kind"],
        question: json["question"] == null ? null : json["question"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "kind": kind == null ? null : kind,
        "question": question == null ? null : question,
      };
}
