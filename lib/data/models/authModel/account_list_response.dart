// To parse this JSON data, do
//
//     final accountListResponse = accountListResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AccountListResponse accountListResponseFromJson(String str) =>
    AccountListResponse.fromJson(json.decode(str));

String accountListResponseToJson(AccountListResponse data) =>
    json.encode(data.toJson());

class AccountListResponse {
  AccountListResponse({
    required this.typename,
    required this.accountList,
  });

  String? typename;
  List<AccountItem>? accountList;

  factory AccountListResponse.fromJson(Map<String, dynamic> json) =>
      AccountListResponse(
        typename: json["_typename"] == null ? null : json["_typename"],
        accountList: json["listAllAccounts"] == null
            ? null
            : List<AccountItem>.from(
                json["listAllAccounts"].map((x) => AccountItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_typename": typename == null ? null : typename,
        "listAllAccounts": accountList == null
            ? null
            : List<dynamic>.from(accountList!.map((x) => x.toJson())),
      };
}

class AccountItem {
  AccountItem({
    required this.listAllAccountTypename,
    required this.orgName,
    required this.userEmail,
    required this.userName,
    required this.logo,
    required this.orgId,
    required this.typename,
  });

  String? listAllAccountTypename;
  String? orgName;
  String? userEmail;
  String? userName;
  String? logo;
  String? orgId;
  String? typename;

  factory AccountItem.fromJson(Map<String, dynamic> json) => AccountItem(
        listAllAccountTypename:
            json["typename"] == null ? null : json["typename"],
        orgName: json["orgName"] == null ? null : json["orgName"],
        userEmail: json["userEmail"] == null ? null : json["userEmail"],
        userName: json["userName"] == null ? null : json["userName"],
        logo: json["logo"] == null ? null : json["logo"],
        orgId: json["orgId"] == null ? null : json["orgId"],
        typename: json["_typename"] == null ? null : json["_typename"],
      );

  Map<String, dynamic> toJson() => {
        "typename":
            listAllAccountTypename == null ? null : listAllAccountTypename,
        "orgName": orgName == null ? null : orgName,
        "userEmail": userEmail == null ? null : userEmail,
        "userName": userName == null ? null : userName,
        "logo": logo == null ? null : logo,
        "orgId": orgId == null ? null : orgId,
        "_typename": typename == null ? null : typename,
      };
}
