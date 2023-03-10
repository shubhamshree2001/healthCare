// To parse this JSON data, do
//
//     final googleApiPhoneNumberResponse = googleApiPhoneNumberResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GoogleApiPhoneNumberResponse googleApiPhoneNumberResponseFromJson(String str) =>
    GoogleApiPhoneNumberResponse.fromJson(json.decode(str));

String googleApiPhoneNumberResponseToJson(GoogleApiPhoneNumberResponse data) =>
    json.encode(data.toJson());

class GoogleApiPhoneNumberResponse {
  GoogleApiPhoneNumberResponse({
    required this.resourceName,
    required this.etag,
    required this.names,
    required this.phoneNumbers,
  });

  String? resourceName;
  String? etag;
  List<Name>? names;
  List<PhoneNumber>? phoneNumbers;

  factory GoogleApiPhoneNumberResponse.fromJson(Map<String, dynamic> json) =>
      GoogleApiPhoneNumberResponse(
        resourceName:
            json["resourceName"] == null ? null : json["resourceName"],
        etag: json["etag"] == null ? null : json["etag"],
        names: json["names"] == null
            ? null
            : List<Name>.from(json["names"].map((x) => Name.fromJson(x))),
        phoneNumbers: json["phoneNumbers"] == null
            ? null
            : List<PhoneNumber>.from(
                json["phoneNumbers"].map((x) => PhoneNumber.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resourceName": resourceName == null ? null : resourceName,
        "etag": etag == null ? null : etag,
        "names": names == null
            ? null
            : List<dynamic>.from(names!.map((x) => x.toJson())),
        "phoneNumbers": phoneNumbers == null
            ? null
            : List<dynamic>.from(phoneNumbers!.map((x) => x.toJson())),
      };
}

class Name {
  Name({
    required this.metadata,
    required this.displayName,
    required this.familyName,
    required this.givenName,
    required this.displayNameLastFirst,
    required this.unstructuredName,
  });

  NameMetadata? metadata;
  String? displayName;
  String? familyName;
  String? givenName;
  String? displayNameLastFirst;
  String? unstructuredName;

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        metadata: json["metadata"] == null
            ? null
            : NameMetadata.fromJson(json["metadata"]),
        displayName: json["displayName"] == null ? null : json["displayName"],
        familyName: json["familyName"] == null ? null : json["familyName"],
        givenName: json["givenName"] == null ? null : json["givenName"],
        displayNameLastFirst: json["displayNameLastFirst"] == null
            ? null
            : json["displayNameLastFirst"],
        unstructuredName:
            json["unstructuredName"] == null ? null : json["unstructuredName"],
      );

  Map<String, dynamic> toJson() => {
        "metadata": metadata == null ? null : metadata!.toJson(),
        "displayName": displayName == null ? null : displayName,
        "familyName": familyName == null ? null : familyName,
        "givenName": givenName == null ? null : givenName,
        "displayNameLastFirst":
            displayNameLastFirst == null ? null : displayNameLastFirst,
        "unstructuredName": unstructuredName == null ? null : unstructuredName,
      };
}

class NameMetadata {
  NameMetadata({
    required this.primary,
    required this.source,
    required this.sourcePrimary,
  });

  bool primary;
  Source? source;
  bool sourcePrimary;

  factory NameMetadata.fromJson(Map<String, dynamic> json) => NameMetadata(
        primary: json["primary"] == null ? null : json["primary"],
        source: json["source"] == null ? null : Source.fromJson(json["source"]),
        sourcePrimary:
            json["sourcePrimary"] == null ? null : json["sourcePrimary"],
      );

  Map<String, dynamic> toJson() => {
        "primary": primary == null ? null : primary,
        "source": source == null ? null : source!.toJson(),
        "sourcePrimary": sourcePrimary == null ? null : sourcePrimary,
      };
}

class Source {
  Source({
    required this.type,
    required this.id,
  });

  String? type;
  String? id;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        type: json["type"] == null ? null : json["type"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "id": id == null ? null : id,
      };
}

class PhoneNumber {
  PhoneNumber({
    this.metadata,
    this.value,
    this.canonicalForm,
    this.type,
    this.formattedType,
  });

  PhoneNumberMetadata? metadata;
  String? value;
  String? canonicalForm;
  String? type;
  String? formattedType;

  factory PhoneNumber.fromJson(Map<String, dynamic> json) => PhoneNumber(
        metadata: json["metadata"] == null
            ? null
            : PhoneNumberMetadata.fromJson(json["metadata"]),
        value: json["value"] == null ? null : json["value"],
        canonicalForm:
            json["canonicalForm"] == null ? null : json["canonicalForm"],
        type: json["type"] == null ? null : json["type"],
        formattedType:
            json["formattedType"] == null ? null : json["formattedType"],
      );

  Map<String, dynamic> toJson() => {
        "metadata": metadata == null ? null : metadata!.toJson(),
        "value": value == null ? null : value,
        "canonicalForm": canonicalForm == null ? null : canonicalForm,
        "type": type == null ? null : type,
        "formattedType": formattedType == null ? null : formattedType,
      };
}

class PhoneNumberMetadata {
  PhoneNumberMetadata({
    required this.primary,
    required this.verified,
    required this.source,
  });

  bool primary;
  bool verified;
  Source? source;

  factory PhoneNumberMetadata.fromJson(Map<String, dynamic> json) =>
      PhoneNumberMetadata(
        primary: json["primary"] == null ? null : json["primary"],
        verified: json["verified"] == null ? null : json["verified"],
        source: json["source"] == null ? null : Source.fromJson(json["source"]),
      );

  Map<String, dynamic> toJson() => {
        "primary": primary == null ? null : primary,
        "verified": verified == null ? null : verified,
        "source": source == null ? null : source!.toJson(),
      };
}
