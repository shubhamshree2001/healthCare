
import 'dart:convert';

UserResponse userResponseFromJson(String str) => UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  UserResponse({
   required this.auth,
  });

  Auth? auth;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
    auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
  );

  Map<String, dynamic> toJson() => {
    "auth": auth == null ? null : auth?.toJson(),
  };
}

class Auth {
  Auth({
   required this.getUser,
  });

  GetUser? getUser;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
    getUser: json["getUser"] == null ? null : GetUser.fromJson(json["getUser"]),
  );

  Map<String, dynamic> toJson() => {
    "getUser": getUser == null ? null : getUser?.toJson(),
  };
}

class GetUser {
  GetUser({
    this.id,
    this.contact,
    this.name,
    this.isGiftSendingEnabled,
    this.isProfileExists,
    this.email,
    this.profile,
    this.appUpdate,
    this.gender,
    this.role,
    this.dob,
    this.organisation,
    this.designation,
    this.region,
    this.isB2C,
    this.units,
  });

  String? id;
  Contact? contact;
  String? name;
  bool? isGiftSendingEnabled;
  bool? isProfileExists;
  String? email;
  String? profile;
  AppUpdate? appUpdate;
  String? gender;
  String? role;
  Dob? dob;
  Organisation? organisation;
  String? designation;
  Region? region;
  bool? isB2C;
  Units? units;

  factory GetUser.fromJson(Map<String, dynamic> json) => GetUser(
    id: json["id"] == null ? null : json["id"],
    contact: json["contact"] == null ? null : Contact.fromJson(json["contact"]),
    name: json["name"] == null ? null : json["name"],
    isGiftSendingEnabled: json["is_gift_sending_enabled"] == null ? null : json["is_gift_sending_enabled"],
    isProfileExists: json["is_profile_exists"] == null ? null : json["is_profile_exists"],
    email: json["email"] == null ? null : json["email"],
    profile: json["profile"] == null ? null : json["profile"],
    appUpdate: json["app_update"] == null ? null : AppUpdate.fromJson(json["app_update"]),
    gender: json["gender"] == null?null:json["gender"],
    role: json["role"]== null?null:json["role"],
    dob: json["dob"] == null ? null : Dob?.fromJson(json["dob"]),
    organisation: json["organisation"] == null ? null : Organisation.fromJson(json["organisation"]),
    designation: json["designation"] == null ? null : json["designation"],
    region: json["region"] == null ? null : Region?.fromJson(json["region"]),
    isB2C: json["is_b2c"] == null ? null : json["is_b2c"],
    units: json["units"] == null ? null : Units?.fromJson(json["units"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "contact": contact == null ? null : contact?.toJson(),
    "name": name == null ? null : name,
    "is_gift_sending_enabled": isGiftSendingEnabled == null ? null : isGiftSendingEnabled,
    "is_profile_exists": isProfileExists == null ? null : isProfileExists,
    "email": email == null ? null : email,
    "profile": profile == null ? null : profile,
    "app_update": appUpdate == null ? null : appUpdate?.toJson(),
    "gender": gender==null?null:gender,
    "role": role==null?null:role,
    "dob": dob == null ? null : dob?.toJson(),
    "organisation": organisation == null ? null : organisation?.toJson(),
    "designation": designation==null?null:designation,
    "region": region == null ? null : region?.toJson(),
    "is_b2c": isB2C == null ? null : isB2C,
    "units": units == null ? null : units?.toJson(),
  };
}

class AppUpdate {
  AppUpdate({
   required this.forceUpdate,
   required this.update,
  });

  bool? forceUpdate;
  bool? update;

  factory AppUpdate.fromJson(Map<String, dynamic> json) => AppUpdate(
    forceUpdate: json["force_update"] == null ? null : json["force_update"],
    update: json["update"] == null ? null : json["update"],
  );

  Map<String, dynamic> toJson() => {
    "force_update": forceUpdate == null ? null : forceUpdate,
    "update": update == null ? null : update,
  };
}

class Contact {
  Contact({
   required this.mobile,
   required this.code,
  });

  String? mobile;
  String? code;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    mobile: json["mobile"] == null ? null : json["mobile"],
    code: json["code"] == null ? null : json["code"],
  );

  Map<String, dynamic> toJson() => {
    "mobile": mobile == null ? null : mobile,
    "code": code == null ? null : code,
  };
}

class Dob {
  Dob({
   required this.date,
   required this.year,
   required this.month,
   required this.day,
  });

  String? date;
  int? year;
  int? month;
  int? day;

  factory Dob.fromJson(Map<String, dynamic> json) => Dob(
    date: json["date"] == null ? null : json["date"],
    year: json["year"] == null ? null : json["year"],
    month: json["month"] == null ? null : json["month"],
    day: json["day"] == null ? null : json["day"],
  );

  Map<String, dynamic> toJson() => {
    "date": date == null ? null : date,
    "year": year == null ? null : year,
    "month": month == null ? null : month,
    "day": day == null ? null : day,
  };
}

class Organisation {
  Organisation({
   required this.chatWidgetLinks,
   required this.isBoatEnabled,
   required this.isTherapyEnabled,
   required this.isSelfCareEnabled,
   required this.brandingLogo,
  });

  ChatWidgetLinks? chatWidgetLinks;
  bool? isBoatEnabled;
  bool? isTherapyEnabled;
  bool? isSelfCareEnabled;
  String? brandingLogo;

  factory Organisation.fromJson(Map<String, dynamic> json) => Organisation(
    chatWidgetLinks: json["chat_widget_links"] == null ? null : ChatWidgetLinks.fromJson(json["chat_widget_links"]),
    isBoatEnabled: json["is_boat_enabled"] == null ? null : json["is_boat_enabled"],
    isTherapyEnabled: json["is_therapy_enabled"] == null ? null : json["is_therapy_enabled"],
    isSelfCareEnabled: json["is_self_care_enabled"] == null ? null : json["is_self_care_enabled"],
    brandingLogo: json["branding_logo"] == null ? null : json["branding_logo"],
  );

  Map<String, dynamic> toJson() => {
    "chat_widget_links": chatWidgetLinks == null ? null : chatWidgetLinks?.toJson(),
    "is_boat_enabled": isBoatEnabled == null ? null : isBoatEnabled,
    "is_therapy_enabled": isTherapyEnabled == null ? null : isTherapyEnabled,
    "is_self_care_enabled": isSelfCareEnabled == null ? null : isSelfCareEnabled,
    "branding_logo": brandingLogo == null ? null : brandingLogo,
  };
}

class ChatWidgetLinks {
  ChatWidgetLinks({
   required this.tawkToEmbedLink,
   required this.tawkToDirectLink,
  });

  String? tawkToEmbedLink;
  String? tawkToDirectLink;

  factory ChatWidgetLinks.fromJson(Map<String, dynamic> json) => ChatWidgetLinks(
    tawkToEmbedLink: json["tawk_to_embed_link"] == null ? null : json["tawk_to_embed_link"],
    tawkToDirectLink: json["tawk_to_direct_link"] == null ? null : json["tawk_to_direct_link"],
  );

  Map<String, dynamic> toJson() => {
    "tawk_to_embed_link": tawkToEmbedLink == null ? null : tawkToEmbedLink,
    "tawk_to_direct_link": tawkToDirectLink == null ? null : tawkToDirectLink,
  };
}

class Region {
  Region({
   required this.id,
  });

  String? id;

  factory Region.fromJson(Map<String, dynamic> json) => Region(
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
  };
}

class Units {
  Units({
   required this.session,
  });

  int? session;

  factory Units.fromJson(Map<String, dynamic> json) => Units(
    session: json["session"] == null ? null : json["session"],
  );

  Map<String, dynamic> toJson() => {
    "session": session == null ? null : session,
  };
}
