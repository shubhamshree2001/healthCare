
import 'dart:convert';

CreateTherapyOrderResponse createTherapyOrderResponseFromJson(String str) => CreateTherapyOrderResponse.fromJson(json.decode(str));

String createTherapyOrderResponseToJson(CreateTherapyOrderResponse data) => json.encode(data.toJson());

class CreateTherapyOrderResponse {
  CreateTherapyOrderResponse({
    required this.authMutation,
  });

  AuthMutation? authMutation;

  factory CreateTherapyOrderResponse.fromJson(Map<String, dynamic> json) => CreateTherapyOrderResponse(
    authMutation: json["authMutation"] == null ? null : AuthMutation.fromJson(json["authMutation"]),
  );

  Map<String, dynamic> toJson() => {
    "authMutation": authMutation == null ? null : authMutation?.toJson(),
  };
}

class AuthMutation {
  AuthMutation({
    required this.therapyGiftOrder,
  });

  TherapyGiftOrder? therapyGiftOrder;

  factory AuthMutation.fromJson(Map<String, dynamic> json) => AuthMutation(
    therapyGiftOrder: json["create"] == null ? null : TherapyGiftOrder.fromJson(json["create"]),
  );

  Map<String, dynamic> toJson() => {
    "create": therapyGiftOrder == null ? null : therapyGiftOrder?.toJson(),
  };
}

class TherapyGiftOrder {
  TherapyGiftOrder({
   required this.orderId,
  });

  String orderId;


  factory TherapyGiftOrder.fromJson(Map<String, dynamic> json) => TherapyGiftOrder(
    orderId: json["createOrder"] == null ? null : json["createOrder"],
  );

  Map<String, dynamic> toJson() => {
    "createOrder": orderId == null ? null : orderId,
  };
}
