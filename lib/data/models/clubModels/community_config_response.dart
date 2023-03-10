import 'dart:convert';

CommunityConfigResponse communityConfigResponseFromJson(String str) => CommunityConfigResponse.fromJson(json.decode(str));

String communityConfigResponseToJson(CommunityConfigResponse data) => json.encode(data.toJson());

class CommunityConfigResponse {
  CommunityConfigResponse({
    required this.auth,
  });

  Auth? auth;

  factory CommunityConfigResponse.fromJson(Map<String, dynamic> json) => CommunityConfigResponse(
    auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
  );

  Map<String, dynamic> toJson() => {
    "auth": auth?.toJson(),
  };
}

class Auth {
  Auth({
    required this.communityConfig,
  });

  CommunityConfig? communityConfig;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
    communityConfig: json["getCommunityConfig"] == null ? null : CommunityConfig.fromJson(json["getCommunityConfig"]),
  );

  Map<String, dynamic> toJson() => {
    "getCommunityConfig": communityConfig?.toJson(),
  };
}

class CommunityConfig {
  CommunityConfig({
     this.isPaid=false,
     this.postVentPlaceholder = "",
     this.replyVentPlaceholder ="",
     this.giftSuccessMessage = "",
     this.sendGiftMessage,
     this.syncTime,
     this.clubListCtaIcon,
     this.anonymousProfile,
     this.lockedContentImage,
     this.disableConfig,
     this.reactions,
     this.followAsset,
     this.planPageTitle,
     this.subscriptionBenefits,
     this.featureInfoScreen,
     this.feedback,
  });

  bool? isPaid;
  String? postVentPlaceholder;
  String? replyVentPlaceholder;
  String? giftSuccessMessage;
  String? sendGiftMessage;
  int? syncTime;
  String? clubListCtaIcon;
  String? anonymousProfile;
  LockedContentImage? lockedContentImage;
  DisableConfig? disableConfig;
  List<Reaction>? reactions;
  String? followAsset;
  String? planPageTitle;
  FeatureInfoScreen? subscriptionBenefits;
  FeatureInfoScreen? featureInfoScreen;
  Feedback? feedback;

  factory CommunityConfig.fromJson(Map<String, dynamic> json) => CommunityConfig(
    isPaid: json["is_paid"] ?? false,
    postVentPlaceholder: json["postVentPlaceholder"] ?? "",
    replyVentPlaceholder: json["replyVentPlaceholder"] ?? "",
    giftSuccessMessage: json["giftSuccessMessage"] ?? "",
    sendGiftMessage: json["sendGiftMessage"] ?? "",
    syncTime: json["syncTime"] ?? 0,
    clubListCtaIcon: json["clubListCtaIcon"] ?? "",
    anonymousProfile: json["anonymous_profile"] ?? "",
    lockedContentImage: json["locked_content_image"] == null ? null : LockedContentImage.fromJson(json["locked_content_image"]),
    disableConfig: json["disable_config"] == null ? null : DisableConfig.fromJson(json["disable_config"]),
    reactions: json["reactions"] == null ? null : List<Reaction>.from(json["reactions"].map((x) => Reaction.fromJson(x))),
    followAsset: json["followAsset"] ?? "",
    planPageTitle: json["plan_page_title"] ?? "",
    subscriptionBenefits: json["subscription_benefits"] == null ? null : FeatureInfoScreen.fromJson(json["subscription_benefits"]),
    featureInfoScreen: json["feature_info_screen"] == null ? null : FeatureInfoScreen.fromJson(json["feature_info_screen"]),
    feedback: json["feedback"] == null ? null : Feedback.fromJson(json["feedback"]),
  );

  Map<String, dynamic> toJson() => {
    "is_paid": isPaid ?? false,
    "postVentPlaceholder": postVentPlaceholder ?? "",
    "replyVentPlaceholder": replyVentPlaceholder ?? "",
    "giftSuccessMessage": giftSuccessMessage ?? "",
    "sendGiftMessage": sendGiftMessage ?? "",
    "syncTime": syncTime ?? "",
    "clubListCtaIcon": clubListCtaIcon ?? "",
    "anonymous_profile": anonymousProfile ?? "",
    "locked_content_image": lockedContentImage?.toJson(),
    "disable_config": disableConfig?.toJson(),
    "reactions": reactions == null ? null : List<dynamic>.from(reactions!.map((x) => x.toJson())),
    "followAsset": followAsset ?? "",
    "plan_page_title": planPageTitle ?? "",
    "subscription_benefits": subscriptionBenefits?.toJson(),
    "feature_info_screen": featureInfoScreen?.toJson(),
    "feedback": feedback?.toJson(),
  };
}

class DisableConfig {
  DisableConfig({
    required this.vents,
    required this.events,
  });

  Vents? vents;
  Events? events;

  factory DisableConfig.fromJson(Map<String, dynamic> json) => DisableConfig(
    vents: json["vents"] == null ? null : Vents.fromJson(json["vents"]),
    events: json["events"] == null ? null : Events.fromJson(json["events"]),
  );

  Map<String, dynamic> toJson() => {
    "vents": vents?.toJson(),
    "events": events?.toJson(),
  };
}

class Vents {
  Vents({
    required this.disable,
    required this.text,
    required this.image,
  });

  bool? disable;
  String? text;
  String? image;

  factory Vents.fromJson(Map<String, dynamic> json) => Vents(
    disable: json["disable"] ?? "",
    text: json["text"] ?? "",
    image: json["image"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "disable": disable ?? "",
    "text": text ?? "",
    "image": image ?? "",
  };
}

class Events {
  Events({
    required this.disable,
    required this.text,
    required this.image,
  });

  bool? disable;
  String? text;
  String? image;

  factory Events.fromJson(Map<String, dynamic> json) => Events(
    disable: json["disable"] ?? "",
    text: json["text"] ?? "",
    image: json["image"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "disable": disable ?? "",
    "text": text ?? "",
    "image": image ?? "",
  };
}

class FeatureInfoScreen {
  FeatureInfoScreen({
     this.type = "",
     this.asset,
  });

  String? type;
  List<String>? asset;

  factory FeatureInfoScreen.fromJson(Map<String, dynamic> json) => FeatureInfoScreen(
    type: json["type"] ?? "",
    asset: json["asset"] == null ? null : List<String>.from(json["asset"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "type": type ?? "",
    "asset": asset == null ? null : List<dynamic>.from(asset!.map((x) => x)),
  };
}

class Feedback {
  Feedback({
    required this.id,
    required this.kind,
    required this.question,
    required this.type,
    required this.options,
    required this.required,
  });

  String? id;
  String? kind;
  String? question;
  String? type;
  List<String>? options;
  bool? required;

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
    id: json["id"] ?? "",
    kind: json["kind"] ?? "",
    question: json["question"] ?? "",
    type: json["type"] ?? "",
    options: json["options"] == null ? null : List<String>.from(json["options"].map((x) => x)),
    required: json["required"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "id": id ?? "",
    "kind": kind ?? "",
    "question": question ?? "",
    "type": type ?? "",
    "options": options == null ? null : List<dynamic>.from(options!.map((x) => x)),
    "required": required ?? false,
  };
}

class LockedContentImage {
  LockedContentImage({
    required this.vent,
    required this.ventReply,
  });

  String? vent;
  String? ventReply;

  factory LockedContentImage.fromJson(Map<String, dynamic> json) => LockedContentImage(
    vent: json["vent"] ?? "",
    ventReply: json["vent_reply"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "vent": vent ?? "",
    "vent_reply": ventReply ?? "",
  };
}

class Reaction {
  Reaction({
    required this.coloredUrl,
    required this.uncoloredUrl,
    required this.type,
  });

  String? coloredUrl;
  String? uncoloredUrl;
  String? type;

  factory Reaction.fromJson(Map<String, dynamic> json) => Reaction(
    coloredUrl: json["colored_url"] ?? "",
    uncoloredUrl: json["uncolored_url"] ?? "",
    type: json["type"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "colored_url": coloredUrl ?? "",
    "uncolored_url": uncoloredUrl ?? "",
    "type": type ?? "",
  };
}
