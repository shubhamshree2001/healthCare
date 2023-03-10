// To parse this JSON data, do
//
//     final listMyPlansResponse = listMyPlansResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ListMyPlansResponse listMyPlansResponseFromJson(String str) =>
    ListMyPlansResponse.fromJson(json.decode(str));

String listMyPlansResponseToJson(ListMyPlansResponse data) =>
    json.encode(data.toJson());

class ListMyPlansResponse {
  ListMyPlansResponse({
    required this.auth,
  });

  Auth? auth;

  factory ListMyPlansResponse.fromJson(Map<String, dynamic> json) =>
      ListMyPlansResponse(
        auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
      );

  Map<String, dynamic> toJson() => {
        "auth": auth == null ? null : auth?.toJson(),
      };
}

class Auth {
  Auth({
    required this.listMyPlans,
  });

  ListMyPlans? listMyPlans;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        listMyPlans: json["listMyPlans"] == null
            ? null
            : ListMyPlans.fromJson(json["listMyPlans"]),
      );

  Map<String, dynamic> toJson() => {
        "listMyPlans": listMyPlans == null ? null : listMyPlans?.toJson(),
      };
}

class ListMyPlans {
  ListMyPlans({
    required this.plans,
    required this.credits,
    required this.summaryCards,
  });

  List<Plan>? plans;
  Credits? credits;
  List<SummaryCard>? summaryCards;

  factory ListMyPlans.fromJson(Map<String, dynamic> json) => ListMyPlans(
        plans: json["plans"] == null
            ? null
            : List<Plan>.from(json["plans"].map((x) => Plan.fromJson(x))),
        credits:
            json["credits"] == null ? null : Credits.fromJson(json["credits"]),
        summaryCards: json["summaryCards"] == null
            ? null
            : List<SummaryCard>.from(
                json["summaryCards"].map((x) => SummaryCard.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "plans": plans == null
            ? null
            : List<dynamic>.from(plans!.map((x) => x.toJson())),
        "credits": credits == null ? null : credits?.toJson(),
        "summaryCards": summaryCards == null
            ? null
            : List<dynamic>.from(summaryCards!.map((x) => x.toJson())),
      };
}

class Credits {
  Credits({
    this.expiredCredits,
    this.usedCredits,
    this.activeCredits,
    this.totalCredits,
  });

  int? expiredCredits;
  int? usedCredits;
  int? activeCredits;
  int? totalCredits;

  factory Credits.fromJson(Map<String, dynamic> json) => Credits(
        expiredCredits:
            json["expired_credits"] == null ? null : json["expired_credits"],
        usedCredits: json["used_credits"] == null ? null : json["used_credits"],
        activeCredits:
            json["active_credits"] == null ? null : json["active_credits"],
        totalCredits:
            json["total_credits"] == null ? null : json["total_credits"],
      );

  Map<String, dynamic> toJson() => {
        "expired_credits": expiredCredits == null ? null : expiredCredits,
        "used_credits": usedCredits == null ? null : usedCredits,
        "active_credits": activeCredits == null ? null : activeCredits,
        "total_credits": totalCredits == null ? null : totalCredits,
      };
}

class Plan {
  Plan({
    required this.buyAgainOption,
    required this.heading,
    required this.isGift,
    required this.name,
    required this.planId,
    required this.purchasedOn,
    required this.totalCredits,
    required this.validTill,
  });

  int? buyAgainOption;
  String heading;
  bool isGift;
  String name;
  String planId;
  String purchasedOn;
  int? totalCredits;
  String validTill;

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        buyAgainOption:
            json["buy_again_option"] == null ? null : json["buy_again_option"],
        heading: json["heading"] == null ? null : json["heading"],
        isGift: json["is_gift"] == null ? null : json["is_gift"],
        name: json["name"] == null ? null : json["name"],
        planId: json["plan_id"] == null ? null : json["plan_id"],
        purchasedOn: json["purchased_on"] == null ? null : json["purchased_on"],
        totalCredits:
            json["total_credits"] == null ? null : json["total_credits"],
        validTill: json["valid_till"] == null ? null : json["valid_till"],
      );

  Map<String, dynamic> toJson() => {
        "buy_again_option": buyAgainOption == null ? null : buyAgainOption,
        "heading": heading == null ? null : heading,
        "is_gift": isGift == null ? null : isGift,
        "name": name == null ? null : name,
        "plan_id": planId == null ? null : planId,
        "purchased_on": purchasedOn == null ? null : purchasedOn,
        "total_credits": totalCredits == null ? null : totalCredits,
        "valid_till": validTill == null ? null : validTill,
      };
}

class SummaryCard {
  SummaryCard({
    required this.cardType,
    required this.credits,
    required this.heading,
    required this.icon,
    required this.subHeading,
    required this.warning,
    required this.cta,
  });

  String? cardType;
  Credits? credits;
  String? heading;
  String icon;
  String? subHeading;
  Warning? warning;
  Cta? cta;

  factory SummaryCard.fromJson(Map<String, dynamic> json) => SummaryCard(
        cardType: json["card_type"] == null ? null : json["card_type"],
        credits:
            json["credits"] == null ? null : Credits.fromJson(json["credits"]),
        heading: json["heading"] == null ? null : json["heading"],
        icon: json["icon"] == null ? null : json["icon"],
        subHeading: json["sub_heading"] == null ? null : json["sub_heading"],
        warning:
            json["warning"] == null ? null : Warning.fromJson(json["warning"]),
        cta: json["cta"] == null ? null : Cta.fromJson(json["cta"]),
      );

  Map<String, dynamic> toJson() => {
        "card_type": cardType == null ? null : cardType,
        "credits": credits == null ? null : credits?.toJson(),
        "heading": heading == null ? null : heading,
        "icon": icon == null ? null : icon,
        "sub_heading": subHeading == null ? null : subHeading,
        "warning": warning == null ? null : warning?.toJson(),
        "cta": cta == null ? null : cta?.toJson(),
      };
}

class Cta {
  Cta({
    required this.text,
    required this.deeplink,
  });

  String text;
  Deeplink? deeplink;

  factory Cta.fromJson(Map<String, dynamic> json) => Cta(
        text: json["text"] == null ? null : json["text"],
        deeplink: json["deeplink"] == null
            ? null
            : Deeplink.fromJson(json["deeplink"]),
      );

  Map<String, dynamic> toJson() => {
        "text": text == null ? null : text,
        "deeplink": deeplink == null ? null : deeplink?.toJson(),
      };
}

class Deeplink {
  Deeplink({
    required this.screen,
  });

  String screen;

  factory Deeplink.fromJson(Map<String, dynamic> json) => Deeplink(
        screen: json["screen"] == null ? null : json["screen"],
      );

  Map<String, dynamic> toJson() => {
        "screen": screen == null ? null : screen,
      };
}

class Warning {
  Warning({
    required this.color,
    required this.text,
  });

  String? color;
  String? text;

  factory Warning.fromJson(Map<String, dynamic> json) => Warning(
        color: json["color"] == null ? null : json["color"],
        text: json["text"] == null ? null : json["text"],
      );

  Map<String, dynamic> toJson() => {
        "color": color == null ? null : color,
        "text": text == null ? null : text,
      };
}
