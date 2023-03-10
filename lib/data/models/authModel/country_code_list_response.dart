
import 'dart:convert';

CountryCodeListResponse countryCodeListResponseFromJson(String str) => CountryCodeListResponse.fromJson(json.decode(str));

String countryCodeListResponseToJson(CountryCodeListResponse data) => json.encode(data.toJson());
class CountryCodeListResponse {
  CountryCodeListResponse({
    required this.countryCodeList,
  });

  List<CountryCodeItem>? countryCodeList;

  factory CountryCodeListResponse.fromJson(Map<String, dynamic> json) => CountryCodeListResponse(
    countryCodeList: json["listCountryCodesV2"] == null ? null : List<CountryCodeItem>.from(json["listCountryCodesV2"].map((x) => CountryCodeItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listCountryCodesV2": countryCodeList == null ? null : List<dynamic>.from(countryCodeList!.map((x) => x.toJson())),
  };

}

class CountryCodeItem {
  CountryCodeItem({
     this.code,
     this.flag,
  });

  String? code;
  String? flag;

  factory CountryCodeItem.fromJson(Map<String, dynamic> json) => CountryCodeItem(
    code: json["code"] == null ? null : json["code"],
    flag: json["flag"] == null ? null : json["flag"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "flag": flag == null ? null : flag,
  };

}