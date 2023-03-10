// To parse this JSON data, do
//
//     final getSignedUrlResponse = getSignedUrlResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetSignedUrlResponse getSignedUrlResponseFromJson(String str) =>
    GetSignedUrlResponse.fromJson(json.decode(str));

String getSignedUrlResponseToJson(GetSignedUrlResponse data) =>
    json.encode(data.toJson());

class GetSignedUrlResponse {
  GetSignedUrlResponse({
    required this.getSignedUrl,
  });

  GetSignedUrl? getSignedUrl;

  factory GetSignedUrlResponse.fromJson(Map<String, dynamic> json) =>
      GetSignedUrlResponse(
        getSignedUrl: json["getSignedUrl"] == null
            ? null
            : GetSignedUrl.fromJson(json["getSignedUrl"]),
      );

  Map<String, dynamic> toJson() => {
        "getSignedUrl": getSignedUrl == null ? null : getSignedUrl?.toJson(),
      };
}

class GetSignedUrl {
  GetSignedUrl({
    this.filename,
    this.type,
    this.uri,
    this.url,
  });

  String? filename;
  String? type;
  String? uri;
  String? url;

  factory GetSignedUrl.fromJson(Map<String, dynamic> json) => GetSignedUrl(
        filename: json["filename"] == null ? null : json["filename"],
        type: json["type"] == null ? null : json["type"],
        uri: json["uri"] == null ? null : json["uri"],
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "filename": filename == null ? null : filename,
        "type": type == null ? null : type,
        "uri": uri == null ? null : uri,
        "url": url == null ? null : url,
      };
}
