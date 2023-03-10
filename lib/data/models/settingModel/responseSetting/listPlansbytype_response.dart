// To parse this JSON data, do
//
//     final listPlansByTypeResponse = listPlansByTypeResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ListPlansByTypeResponse listPlansByTypeResponseFromJson(String str) =>
    ListPlansByTypeResponse.fromJson(json.decode(str));

String listPlansByTypeResponseToJson(ListPlansByTypeResponse data) =>
    json.encode(data.toJson());

class ListPlansByTypeResponse {
  ListPlansByTypeResponse({
    required this.auth,
  });

  Auth? auth;

  factory ListPlansByTypeResponse.fromJson(Map<String, dynamic> json) =>
      ListPlansByTypeResponse(
        auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
      );

  Map<String, dynamic> toJson() => {
        "auth": auth == null ? null : auth?.toJson(),
      };
}

class Auth {
  Auth({
    required this.listPlansByType,
  });

  List<ListPlansByType>? listPlansByType;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        listPlansByType: json["listPlansByType"] == null
            ? null
            : List<ListPlansByType>.from(json["listPlansByType"]
                .map((x) => ListPlansByType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "listPlansByType": listPlansByType == null
            ? null
            : List<dynamic>.from(listPlansByType!.map((x) => x.toJson())),
      };
}

class ListPlansByType {
  ListPlansByType({
    required this.badge,
    required this.description,
    required this.discount,
    required this.gatewayId,
    required this.gatewayPlanType,
    required this.id,
    required this.isTaxInclusive,
    required this.name,
    required this.price,
    required this.standard,
    required this.subscription,
    required this.summary,
    required this.units,
    required this.time,
    required this.type,
    required this.code,
    required this.region,
  });

  String badge;
  String description;
  int? discount;
  String? gatewayId;
  String? gatewayPlanType;
  String id;
  bool isTaxInclusive;
  String name;
  int? price;
  bool standard;
  Subscription? subscription;
  Summary? summary;
  Subscription? units;
  String time;
  String type;
  String code;
  Region? region;

  factory ListPlansByType.fromJson(Map<String, dynamic> json) =>
      ListPlansByType(
        badge: json["badge"] == null ? null : json["badge"],
        description: json["description"] == null ? null : json["description"],
        discount: json["discount"] == null ? null : json["discount"],
        gatewayId: json["gateway_id"] == null ? null : json["gateway_id"],
        gatewayPlanType: json["gateway_plan_type"] == null
            ? null
            : json["gateway_plan_type"],
        id: json["id"] == null ? null : json["id"],
        isTaxInclusive:
            json["is_tax_inclusive"] == null ? null : json["is_tax_inclusive"],
        name: json["name"] == null ? null : json["name"],
        price: json["price"] == null ? null : json["price"],
        standard: json["standard"] == null ? null : json["standard"],
        subscription: json["subscription"] == null
            ? null
            : Subscription.fromJson(json["subscription"]),
        summary:
            json["summary"] == null ? null : Summary.fromJson(json["summary"]),
        units:
            json["units"] == null ? null : Subscription.fromJson(json["units"]),
        time: json["time"] == null ? null : json["time"],
        type: json["type"] == null ? null : json["type"],
        code: json["code"] == null ? null : json["code"],
        region: json["region"] == null ? null : Region.fromJson(json["region"]),
      );

  Map<String, dynamic> toJson() => {
        "badge": badge == null ? null : badge,
        "description": description == null ? null : description,
        "discount": discount == null ? null : discount,
        "gateway_id": gatewayId == null ? null : gatewayId,
        "gateway_plan_type": gatewayPlanType == null ? null : gatewayPlanType,
        "id": id == null ? null : id,
        "is_tax_inclusive": isTaxInclusive == null ? null : isTaxInclusive,
        "name": name == null ? null : name,
        "price": price == null ? null : price,
        "standard": standard == null ? null : standard,
        "subscription": subscription == null ? null : subscription?.toJson(),
        "summary": summary == null ? null : summary?.toJson(),
        "units": units == null ? null : units?.toJson(),
        "time": time == null ? null : time,
        "type": type == null ? null : type,
        "code": code == null ? null : code,
        "region": region == null ? null : region?.toJson(),
      };
}

class Region {
  Region({
    required this.currency,
    required this.tax,
  });

  Currency? currency;
  Tax? tax;

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        currency: json["currency"] == null
            ? null
            : Currency.fromJson(json["currency"]),
        tax: json["tax"] == null ? null : Tax.fromJson(json["tax"]),
      );

  Map<String, dynamic> toJson() => {
        "currency": currency == null ? null : currency?.toJson(),
        "tax": tax == null ? null : tax?.toJson(),
      };
}

class Currency {
  Currency({
    required this.code,
    required this.symbol,
  });

  String code;
  String symbol;

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        code: json["code"] == null ? null : json["code"],
        symbol: json["symbol"] == null ? null : json["symbol"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "symbol": symbol == null ? null : symbol,
      };
}

class Tax {
  Tax({
    required this.kind,
    required this.rate,
  });

  String kind;
  int? rate;

  factory Tax.fromJson(Map<String, dynamic> json) => Tax(
        kind: json["kind"] == null ? null : json["kind"],
        rate: json["rate"] == null ? null : json["rate"],
      );

  Map<String, dynamic> toJson() => {
        "kind": kind == null ? null : kind,
        "rate": rate == null ? null : rate,
      };
}

class Subscription {
  Subscription({
    required this.boat,
    required this.session,
  });

  int? boat;
  int? session;

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        boat: json["boat"] == null ? null : json["boat"],
        session: json["session"] == null ? null : json["session"],
      );

  Map<String, dynamic> toJson() => {
        "boat": boat == null ? null : boat,
        "session": session == null ? null : session,
      };
}

class Summary {
  Summary({
    required this.base,
    required this.perBase,
    required this.main,
    required this.coupon,
    required this.premium,
    required this.tax,
    required this.total,
  });

  double? base;
  double? perBase;
  Coupon? main;
  Coupon? coupon;
  Coupon? premium;
  double? tax;
  Total? total;

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        base: json["base"] == null ? null : json["base"].toDouble(),
        perBase: json["per_base"] == null ? null : json["per_base"].toDouble(),
        main: json["main"] == null ? null : Coupon.fromJson(json["main"]),
        coupon: json["coupon"] == null ? null : Coupon.fromJson(json["coupon"]),
        premium:
            json["premium"] == null ? null : Coupon.fromJson(json["premium"]),
        tax: json["tax"] == null ? null : json["tax"].toDouble(),
        total: json["total"] == null ? null : Total.fromJson(json["total"]),
      );

  Map<String, dynamic> toJson() => {
        "base": base == null ? null : base,
        "per_base": perBase == null ? null : perBase,
        "main": main == null ? null : main?.toJson(),
        "coupon": coupon == null ? null : coupon?.toJson(),
        "premium": premium == null ? null : premium?.toJson(),
        "tax": tax == null ? null : tax,
        "total": total == null ? null : total?.toJson(),
      };
}

class Coupon {
  Coupon({
    required this.rate,
    required this.value,
  });

  int? rate;
  double? value;

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        rate: json["rate"] == null ? null : json["rate"],
        value: json["value"] == null ? null : json["value"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "rate": rate == null ? null : rate,
        "value": value == null ? null : value,
      };
}

class Total {
  Total({
    required this.coupon,
    required this.grand,
    required this.sub,
  });

  double? coupon;
  double? grand;
  double? sub;

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        coupon: json["coupon"] == null ? null : json["coupon"].toDouble(),
        grand: json["grand"] == null ? null : json["grand"].toDouble(),
        sub: json["sub"] == null ? null : json["sub"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "coupon": coupon == null ? null : coupon,
        "grand": grand == null ? null : grand,
        "sub": sub == null ? null : sub,
      };
}
