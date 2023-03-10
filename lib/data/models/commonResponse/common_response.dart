// To parse this JSON data, do
//
//     final commonResponse = commonResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class CommonResponse {
  CommonResponse({
    required this.submitEnquiry,
  });

  bool? submitEnquiry;


  factory CommonResponse.fromJson(Map<String, dynamic> json) => CommonResponse(
        submitEnquiry:
            json["submitEnquiry"] == null ? null : json["submitEnquiry"],
      );
}
