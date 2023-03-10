import 'dart:convert';

DoctorListResponse doctorResponseFromJson(String str) => DoctorListResponse.fromJson(json.decode(str));

String doctorResponseToJson(DoctorListResponse data) => json.encode(data.toJson());

class DoctorListResponse {
  DoctorListResponse({
    required this.auth,
    required this.doctorTotal,
    required this.doctorLimit,
    required this.doctorOffset,
  });

  Auth? auth;
  int? doctorTotal;
  int? doctorLimit;
  int? doctorOffset;


  factory DoctorListResponse.fromJson(Map<String, dynamic> json) => DoctorListResponse(
    auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
    doctorTotal: json["doctorTotal"] == null ? null : json["doctorTotal"],
    doctorLimit: json["doctorLimit"] == null ? null : json["doctorLimit"],
    doctorOffset: json["doctorOffset"] == null ? null : json["doctorOffset"],
  );

  Map<String, dynamic> toJson() => {
    "auth": auth == null ? null : auth?.toJson(),
    "doctorTotal": doctorTotal == null ? null : doctorTotal,
    "doctorLimit": doctorLimit == null ? null : doctorLimit,
    "doctorOffset": doctorOffset == null ? null : doctorOffset,
  };
}

class Auth {
  Auth({
    required this.doctorList,
  });

  List<DoctorItem>? doctorList;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
    doctorList: json["listDoctors"] == null ? null : List<DoctorItem>.from(json["listDoctors"].map((x) => DoctorItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listDoctors": doctorList == null ? null : List<dynamic>.from(doctorList!.map((x) => x.toJson())),
  };
}

class DoctorItem {
  DoctorItem({
     this.id,
     this.user,
     this.schedule,
     this.experience,
     this.specialisations,
     this.degrees,
     this.pronouns,
     this.about,
     this.share,
  });

  String? id;
  User? user;
  String? schedule;
  String? experience;
  List<Specialisations>? specialisations;
  List<Degree>? degrees;
  String? pronouns;
  String? about;
  Share? share;

  factory DoctorItem.fromJson(Map<String, dynamic> json) => DoctorItem(
    id: json["id"] == null ? null : json["id"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    schedule: json["schedule"] == null ? null : json["schedule"],
    experience: json["experience"] == null ? null : json["experience"],
    specialisations: json["specialisations"] == null ? null : List<Specialisations>.from(json["specialisations"].map((x) => Specialisations.fromJson(x))),
    degrees: json["degrees"] == null ? null : List<Degree>.from(json["degrees"].map((x) => Degree.fromJson(x))),
    pronouns: json["pronouns"] == null ? null : json["pronouns"],
    about: json["about"] == null ? null : json["about"],
    share: json["share"] == null ? null : Share.fromJson(json["share"]),


  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user": user == null ? null : user?.toJson(),
    "schedule": schedule == null ? null : schedule,
    "experience": experience == null ? null : experience,
    "specialisations": specialisations == null ? null : List<dynamic>.from(specialisations!.map((x) => x.toJson())),
    "degrees": degrees == null ? null : List<dynamic>.from(degrees!.map((x) => x.toJson())),
    "pronouns": pronouns == null ? null : pronouns,
    "about": about == null ? null : about,
    "share": share == null ? null : share?.toJson(),
  };
}

class Degree {
  Degree({
    required this.name,
  });

  String? name;

  factory Degree.fromJson(Map<String, dynamic> json) => Degree(
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
  };
}

class Specialisations {
  Specialisations({
    required this.name,
  });

  String? name;

  factory Specialisations.fromJson(Map<String, dynamic> json) => Specialisations(
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
  };
}


class User {
  User({
     this.id,
     this.name,
     this.rating,
     this.profile,
     this.slug,
  });

  String? id;
  String? name;
  double? rating;
  String? profile;
  String? slug;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    rating: json["rating"] == null ? null : json["rating"].toDouble(),
    profile: json["profile"] == null ? null : json["profile"],
    slug: json["slug"] == null ? null : json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "rating": rating == null ? null : rating,
    "profile": profile == null ? null : profile,
    "slug": slug == null ? null : slug,
  };
}

class Share {
  Share({
    this.text = "",
    this.url ="",
    this.image = "",
    this.title = "",
  });

  String? text;
  String? url;
  String? image;
  String? title;

  factory Share.fromJson(Map<String, dynamic> json) => Share(
    text: json["text"] ?? "",
    url: json["url"] ?? "",
    image: json["image"] ?? "",
    title: json["title"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "text": text == null ? null : text,
    "url": url == null ? null : url,
    "image": image == null ? null : image,
    "title": title == null ? null : title,
  };
}
