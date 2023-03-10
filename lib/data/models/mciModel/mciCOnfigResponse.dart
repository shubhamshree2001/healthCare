// To parse this JSON data, do
//
//     final getMciConfigResponse = getMciConfigResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetMciConfigResponse getMciConfigResponseFromJson(String str) =>
    GetMciConfigResponse.fromJson(json.decode(str));

String getMciConfigResponseToJson(GetMciConfigResponse data) =>
    json.encode(data.toJson());

class GetMciConfigResponse {
  GetMciConfigResponse({
    required this.auth,
  });

  Auth? auth;

  factory GetMciConfigResponse.fromJson(Map<String, dynamic> json) =>
      GetMciConfigResponse(
        auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
      );

  Map<String, dynamic> toJson() => {
        "auth": auth == null ? null : auth?.toJson(),
      };
}

class Auth {
  Auth({
    required this.getConfig,
  });

  GetConfig? getConfig;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        getConfig: json["getConfig"] == null
            ? null
            : GetConfig.fromJson(json["getConfig"]),
      );

  Map<String, dynamic> toJson() => {
        "getConfig": getConfig == null ? null : getConfig?.toJson(),
      };
}

class GetConfig {
  GetConfig({
    required this.mci,
  });

  Mci? mci;

  factory GetConfig.fromJson(Map<String, dynamic> json) => GetConfig(
        mci: json["mci"] == null ? null : Mci.fromJson(json["mci"]),
      );

  Map<String, dynamic> toJson() => {
        "mci": mci == null ? null : mci?.toJson(),
      };
}

class Mci {
  Mci({
    this.loaderAssets,
    this.loadingTime,
    this.introScreen,
  });

  List<LoaderAsset>? loaderAssets;
  int? loadingTime;
  IntroScreen? introScreen;

  factory Mci.fromJson(Map<String, dynamic> json) => Mci(
        loaderAssets: json["loader_assets"] == null
            ? null
            : List<LoaderAsset>.from(
                json["loader_assets"].map((x) => LoaderAsset.fromJson(x))),
        loadingTime: json["loading_time"] == null ? null : json["loading_time"],
        introScreen: json["intro_screen"] == null
            ? null
            : IntroScreen.fromJson(json["intro_screen"]),
      );

  Map<String, dynamic> toJson() => {
        "loader_assets": loaderAssets == null
            ? null
            : List<dynamic>.from(loaderAssets!.map((x) => x.toJson())),
        "loading_time": loadingTime == null ? null : loadingTime,
        "intro_screen": introScreen == null ? null : introScreen?.toJson(),
      };
}

class IntroScreen {
  IntroScreen({
    required this.image,
    required this.heading,
    required this.subHeading,
    required this.cta,
  });

  String? image;
  String? heading;
  String? subHeading;
  Cta? cta;

  factory IntroScreen.fromJson(Map<String, dynamic> json) => IntroScreen(
        image: json["image"] == null ? "" : json["image"],
        heading: json["heading"] == null ? "" : json["heading"],
        subHeading: json["sub_heading"] == null ? "" : json["sub_heading"],
        cta: json["cta"] == null ? null : Cta.fromJson(json["cta"]),
      );

  Map<String, dynamic> toJson() => {
        "image": image == null ? null : image,
        "heading": heading == null ? null : heading,
        "sub_heading": subHeading == null ? null : subHeading,
        "cta": cta == null ? null : cta?.toJson(),
      };
}

class Cta {
  Cta({
    required this.text,
    required this.deeplink,
  });

  String? text;
  Deeplink? deeplink;

  factory Cta.fromJson(Map<String, dynamic> json) => Cta(
        text: json["text"] == null ? "" : json["text"],
        deeplink: json["deeplink"] == null
            ? null
            : Deeplink.fromJson(json["deeplink"]),
      );

  Map<String, dynamic> toJson() => {
        "text": text == null ? null : text,
        "deeplink": deeplink == null ? null : deeplink?.toJson(),
      };
}

class Deeplink {
  Deeplink({
    required this.screen,
    required this.paramOne,
    required this.paramTwo,
  });

  String? screen;
  dynamic paramOne;
  dynamic paramTwo;

  factory Deeplink.fromJson(Map<String, dynamic> json) => Deeplink(
        screen: json["screen"] == null ? "" : json["screen"],
        paramOne: json["paramOne"] == null ? null : json["paramOne"],
        paramTwo: json["paramTwo"] == null ? null : json["paramOne"],
      );

  Map<String, dynamic> toJson() => {
        "screen": screen == null ? null : screen,
        "paramOne": paramOne,
        "paramTwo": paramTwo,
      };
}

class LoaderAsset {
  LoaderAsset({
    required this.image,
    required this.text,
  });

  String? image;
  String? text;

  factory LoaderAsset.fromJson(Map<String, dynamic> json) => LoaderAsset(
        image: json["image"] == null ? "" : json["image"],
        text: json["text"] == null ? "" : json["text"],
      );

  Map<String, dynamic> toJson() => {
        "image": image == null ? null : image,
        "text": text == null ? null : text,
      };
}
