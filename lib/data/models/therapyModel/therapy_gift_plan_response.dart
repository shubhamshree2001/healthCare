import 'dart:convert';

TherapyGiftPlanResponse therapyGiftPlanResponseFromJson(String str) =>
    TherapyGiftPlanResponse.fromJson(json.decode(str));

String therapyGiftPlanResponseToJson(TherapyGiftPlanResponse data) =>
    json.encode(data.toJson());

class TherapyGiftPlanResponse {
  TherapyGiftPlanResponse({
    required this.auth,
  });

  Auth? auth;

  factory TherapyGiftPlanResponse.fromJson(Map<String, dynamic> json) =>
      TherapyGiftPlanResponse(
        auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
      );

  Map<String, dynamic> toJson() => {
        "auth": auth == null ? null : auth?.toJson(),
      };
}

class Auth {
  Auth({
    required this.therapyGiftPlanList,
  });

  List<TherapyGiftPlan>? therapyGiftPlanList;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        therapyGiftPlanList: json["listPlansByType"] == null
            ? null
            : List<TherapyGiftPlan>.from(json["listPlansByType"]
                .map((x) => TherapyGiftPlan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "listPlansByType": therapyGiftPlanList == null
            ? null
            : List<dynamic>.from(therapyGiftPlanList!.map((x) => x.toJson())),
      };
}

class TherapyGiftPlan {
  TherapyGiftPlan({
    this.id,
    this.units,
    this.name,
    this.time,
    this.code,
    this.type,
    this.description,
    this.badge,
    this.price,
    this.standard,
    this.discount,
    this.isTaxInclusive,
    this.region,
    this.gatewayId,
    this.gatewayPlanType,
    this.summary,
  });

  String? id;
  Units? units;
  String? name;
  String? time;
  String? code;
  String? type;
  String? description;
  String? badge;
  int? price;
  bool? standard;
  int? discount;
  bool? isTaxInclusive;
  Region? region;
  String? gatewayId;
  String? gatewayPlanType;
  Summary? summary;
  bool? isChecked = false;

  factory TherapyGiftPlan.fromJson(Map<String, dynamic> json) =>
      TherapyGiftPlan(
        id: json["id"] == null ? null : json["id"],
        units: json["units"] == null ? null : Units.fromJson(json["units"]),
        name: json["name"] == null ? null : json["name"],
        time: json["time"] == null ? null : json["time"],
        code: json["code"] == null ? null : json["code"],
        type: json["type"] == null ? null : json["type"],
        description: json["description"] == null ? null : json["description"],
        badge: json["badge"] == null ? null : json["badge"],
        price: json["price"] == null ? null : json["price"],
        standard: json["standard"] == null ? null : json["standard"],
        discount: json["discount"] == null ? null : json["discount"],
        isTaxInclusive:
            json["is_tax_inclusive"] == null ? null : json["is_tax_inclusive"],
        region: json["region"] == null ? null : Region.fromJson(json["region"]),
        gatewayId: json["gateway_id"] == null ? null : json["gateway_id"],
        gatewayPlanType: json["gateway_plan_type"] == null
            ? null
            : json["gateway_plan_type"],
        summary:
            json["summary"] == null ? null : Summary.fromJson(json["summary"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "units": units == null ? null : units?.toJson(),
        "name": name == null ? null : name,
        "time": time == null ? null : time,
        "code": code == null ? null : code,
        "type": type == null ? null : type,
        "description": description == null ? null : description,
        "badge": badge == null ? null : badge,
        "price": price == null ? null : price,
        "standard": standard == null ? null : standard,
        "discount": discount == null ? null : discount,
        "is_tax_inclusive": isTaxInclusive == null ? null : isTaxInclusive,
        "region": region == null ? null : region?.toJson(),
        "gateway_id": gatewayId == null ? null : gatewayId,
        "gateway_plan_type": gatewayPlanType == null ? null : gatewayPlanType,
        "summary": summary == null ? null : summary?.toJson(),
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
        code: json["code"] == null ? "" : json["code"],
        symbol: json["symbol"] == null ? "" : json["symbol"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "symbol": symbol == null ? null : symbol,
      };
}

class Tax {
  Tax({
    required this.rate,
    required this.kind,
  });

  double? rate;
  String? kind;

  factory Tax.fromJson(Map<String, dynamic> json) => Tax(
        rate: json["rate"] == null ? null : json["rate"].toDouble(),
        kind: json["kind"] == null ? null : json["kind"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate == null ? null : rate,
        "kind": kind == null ? null : kind,
      };
}

class Summary {
  Summary({
    required this.base,
    required this.perBase,
    required this.main,
    required this.premium,
    required this.coupon,
    required this.tax,
    required this.total,
  });

  double? base;
  num? perBase;
  Coupon? main;
  Coupon? premium;
  Coupon? coupon;
  double? tax;
  Total? total;

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        base: json["base"] == null ? null : json["base"].toDouble(),
        perBase: json["per_base"] == null ? null : json["per_base"],
        main: json["main"] == null ? null : Coupon.fromJson(json["main"]),
        premium:
            json["premium"] == null ? null : Coupon.fromJson(json["premium"]),
        coupon: json["coupon"] == null ? null : Coupon.fromJson(json["coupon"]),
        tax: json["tax"] == null ? null : json["tax"].toDouble(),
        total: json["total"] == null ? null : Total.fromJson(json["total"]),
      );

  Map<String, dynamic> toJson() => {
        "base": base == null ? null : base,
        "perBase": perBase == null ? null : perBase,
        "main": main == null ? null : main?.toJson(),
        "premium": premium == null ? null : premium?.toJson(),
        "coupon": coupon == null ? null : coupon?.toJson(),
        "tax": tax == null ? null : tax,
        "total": total == null ? null : total?.toJson(),
      };
}

class Coupon {
  Coupon({
    required this.rate,
    required this.value,
  });
  num? rate;
  num? value;

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        rate: json["rate"] == null ? null : json["rate"].toDouble(),
        value: json["value"] == null ? null : json["value"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "rate": rate == null ? null : rate,
        "value": value == null ? null : value,
      };
}

class Total {
  Total({
    required this.sub,
    required this.coupon,
    required this.grand,
  });
  num? sub;
  num? coupon;
  double grand;

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        sub: json["sub"] == null ? null : json["sub"].toDouble(),
        coupon: json["coupon"] == null ? null : json["coupon"].toDouble(),
        grand: json["grand"] == null ? null : json["grand"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "sub": sub == null ? null : sub,
        "coupon": coupon == null ? null : coupon,
        "grand": grand == null ? null : grand,
      };
}

class Units {
  Units({
    required this.session,
    required this.boat,
  });

  int? session;
  int? boat;

  factory Units.fromJson(Map<String, dynamic> json) => Units(
        session: json["session"] == null ? null : json["session"],
        boat: json["boat"] == null ? null : json["boat"],
      );

  Map<String, dynamic> toJson() => {
        "session": session == null ? null : session,
        "boat": boat == null ? null : boat,
      };
}
