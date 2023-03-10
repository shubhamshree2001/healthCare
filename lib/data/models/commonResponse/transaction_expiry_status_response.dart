// To parse this JSON data, do
//
//     final transactionExpiryStatusResponse = transactionExpiryStatusResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TransactionExpiryStatusResponse transactionExpiryStatusResponseFromJson(String str) => TransactionExpiryStatusResponse.fromJson(json.decode(str));

String transactionExpiryStatusResponseToJson(TransactionExpiryStatusResponse data) => json.encode(data.toJson());

class TransactionExpiryStatusResponse {
  TransactionExpiryStatusResponse({
    required this.auth,
  });

  Auth? auth;

  factory TransactionExpiryStatusResponse.fromJson(Map<String, dynamic> json) => TransactionExpiryStatusResponse(
    auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
  );

  Map<String, dynamic> toJson() => {
    "auth": auth == null ? null : auth?.toJson(),
  };
}

class Auth {
  Auth({
    required this.transactionExpiryStatus,
  });

  TransactionExpiryStatus? transactionExpiryStatus;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
    transactionExpiryStatus: json["getTransactionExpiryStatus"] == null ? null : TransactionExpiryStatus.fromJson(json["getTransactionExpiryStatus"]),
  );

  Map<String, dynamic> toJson() => {
    "getTransactionExpiryStatus": transactionExpiryStatus == null ? null : transactionExpiryStatus?.toJson(),
  };
}

class TransactionExpiryStatus {
  TransactionExpiryStatus({
    required this.creditExpired,
    required this.daysLeft,
  });

  bool? creditExpired;
  int? daysLeft;

  factory TransactionExpiryStatus.fromJson(Map<String, dynamic> json) => TransactionExpiryStatus(
    creditExpired: json["creditExpired"] == null ? null : json["creditExpired"],
    daysLeft: json["daysLeft"] == null ? null : json["daysLeft"],
  );

  Map<String, dynamic> toJson() => {
    "creditExpired": creditExpired == null ? null : creditExpired,
    "daysLeft": daysLeft == null ? null : daysLeft,
  };
}
