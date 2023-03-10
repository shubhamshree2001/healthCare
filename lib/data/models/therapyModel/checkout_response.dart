import 'dart:convert';

CheckoutResponse checkoutResponseFromJson(String str) => CheckoutResponse.fromJson(json.decode(str));

String checkoutResponseToJson(CheckoutResponse data) => json.encode(data.toJson());

class CheckoutResponse {
  CheckoutResponse({
    required this.authMutation,
  });

  AuthMutation? authMutation;

  factory CheckoutResponse.fromJson(Map<String, dynamic> json) => CheckoutResponse(
    authMutation: json["authMutation"] == null ? null : AuthMutation.fromJson(json["authMutation"]),
  );

  Map<String, dynamic> toJson() => {
    "authMutation": authMutation == null ? null : authMutation?.toJson(),
  };
}

class AuthMutation {
  AuthMutation({
    required this.update,
  });

  Update? update;

  factory AuthMutation.fromJson(Map<String, dynamic> json) => AuthMutation(
    update: json["update"] == null ? null : Update.fromJson(json["update"]),
  );

  Map<String, dynamic> toJson() => {
    "update": update == null ? null : update?.toJson(),
  };
}

class Update {
  Update({
    required this.checkout,
  });

  Checkout? checkout;

  factory Update.fromJson(Map<String, dynamic> json) => Update(
    checkout: json["checkout"] == null ? null : Checkout.fromJson(json["checkout"]),
  );

  Map<String, dynamic> toJson() => {
    "checkout": checkout == null ? null : checkout?.toJson(),
  };
}

class Checkout {
  Checkout({
    required this.typename,
    required this.gateway,
    required this.id,
    required this.amount,
    required this.currency,
  });

  String? typename;
  String? gateway;
  String? id;
  String? amount;
  String? currency;

  factory Checkout.fromJson(Map<String, dynamic> json) => Checkout(
    typename: json["__typename"] == null ? null : json["__typename"],
    gateway: json["gateway"] == null ? null : json["gateway"],
    id: json["id"] == null ? null : json["id"],
    amount: json["amount"] == null ? null : json["amount"],
    currency: json["currency"] == null ? null : json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename == null ? null : typename,
    "gateway": gateway == null ? null : gateway,
    "id": id == null ? null : id,
    "amount": amount == null ? null : amount,
    "currency": currency == null ? null : currency,
  };
}
