// To parse this JSON data, do
//
//     final getModuleLastSessionResponse = getModuleLastSessionResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetModuleLastSessionResponse getModuleLastSessionResponseFromJson(String str) =>
    GetModuleLastSessionResponse.fromJson(json.decode(str));

String getModuleLastSessionResponseToJson(GetModuleLastSessionResponse data) =>
    json.encode(data.toJson());

class GetModuleLastSessionResponse {
  GetModuleLastSessionResponse({
    required this.auth,
  });

  Auth? auth;

  factory GetModuleLastSessionResponse.fromJson(Map<String, dynamic> json) =>
      GetModuleLastSessionResponse(
        auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
      );

  Map<String, dynamic> toJson() => {
        "auth": auth == null ? null : auth?.toJson(),
      };
}

class Auth {
  Auth({
    required this.getModuleLastSession,
  });

  GetModuleLastSession? getModuleLastSession;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        getModuleLastSession: json["getModuleLastSession"] == null
            ? null
            : GetModuleLastSession.fromJson(json["getModuleLastSession"]),
      );

  Map<String, dynamic> toJson() => {
        "getModuleLastSession": getModuleLastSession == null
            ? null
            : getModuleLastSession?.toJson(),
      };
}

class GetModuleLastSession {
  GetModuleLastSession({
    required this.ref,
    required this.feedback,
    required this.audio,
    required this.module,
  });

  String? ref;
  bool? feedback;
  bool? audio;
  Module? module;

  factory GetModuleLastSession.fromJson(Map<String, dynamic> json) =>
      GetModuleLastSession(
        ref: json["ref"] == null ? null : json["ref"],
        feedback: json["feedback"] == null ? null : json["feedback"],
        audio: json["audio"] == null ? null : json["audio"],
        module: json["module"] == null ? null : Module.fromJson(json["module"]),
      );

  Map<String, dynamic> toJson() => {
        "ref": ref == null ? null : ref,
        "feedback": feedback == null ? null : feedback,
        "audio": audio == null ? null : audio,
        "module": module == null ? null : module?.toJson(),
      };
}

class Module {
  Module({
    required this.id,
    required this.name,
    required this.version,
    required this.topics,
    required this.filters,
    required this.share,
    required this.statistics,
    required this.background,
    required this.theme,
    required this.bgm,
    required this.heading,
    required this.contents,
  });

  String? id;
  String? name;
  int? version;
  List<TopicElement>? topics;
  List<String>? filters;
  Share? share;
  Statistics? statistics;
  Background? background;
  dynamic theme;
  Bgm? bgm;
  String? heading;
  List<Content>? contents;

  factory Module.fromJson(Map<String, dynamic> json) => Module(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        version: json["version"] == null ? null : json["version"],
        topics: json["topics"] == null
            ? null
            : List<TopicElement>.from(
                json["topics"].map((x) => TopicElement.fromJson(x))),
        filters: json["filters"] == null
            ? null
            : List<String>.from(json["filters"].map((x) => x)),
        share: json["share"] == null ? null : Share.fromJson(json["share"]),
        statistics: json["statistics"] == null
            ? null
            : Statistics.fromJson(json["statistics"]),
        background: json["background"] == null
            ? null
            : Background.fromJson(json["background"]),
        theme: json["theme"],
        bgm: json["bgm"] == null ? null : Bgm.fromJson(json["bgm"]),
        heading: json["heading"] == null ? null : json["heading"],
        contents: json["contents"] == null
            ? null
            : List<Content>.from(
                json["contents"].map((x) => Content.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "version": version == null ? null : version,
        "topics": topics == null
            ? null
            : List<dynamic>.from(topics!.map((x) => x.toJson())),
        "filters":
            filters == null ? null : List<dynamic>.from(filters!.map((x) => x)),
        "share": share == null ? null : share?.toJson(),
        "statistics": statistics == null ? null : statistics?.toJson(),
        "background": background == null ? null : background?.toJson(),
        "theme": theme,
        "bgm": bgm == null ? null : bgm?.toJson(),
        "heading": heading == null ? null : heading,
        "contents": contents == null
            ? null
            : List<dynamic>.from(contents!.map((x) => x.toJson())),
      };
}

class Background {
  Background({
    required this.desktop,
    required this.mobile,
  });

  String? desktop;
  String? mobile;

  factory Background.fromJson(Map<String, dynamic> json) => Background(
        desktop: json["desktop"] == null ? null : json["desktop"],
        mobile: json["mobile"] == null ? null : json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "desktop": desktop == null ? null : desktop,
        "mobile": mobile == null ? null : mobile,
      };
}

class Bgm {
  Bgm({
    required this.url,
    required this.volume,
  });

  String? url;
  int? volume;

  factory Bgm.fromJson(Map<String, dynamic> json) => Bgm(
        url: json["url"] == null ? null : json["url"],
        volume: json["volume"] == null ? null : json["volume"],
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "volume": volume == null ? null : volume,
      };
}

class Content {
  Content({
    required this.id,
    required this.type,
    required this.key,
    required this.topic,
    required this.audio,
    required this.exercise,
    required this.heading,
    required this.subHeading,
    required this.title,
    required this.subTitle,
    required this.image,
    required this.info,
    required this.enums,
    required this.game,
    required this.required,
    required this.cardType,
    required this.stories,
    required this.cards,
    required this.cta,
    required this.onSkip,
    required this.onComplete,
    required this.submit,
    required this.fetch,
  });

  String? id;
  String? type;
  dynamic key;
  ContentTopic? topic;
  dynamic audio;
  Exercise? exercise;
  dynamic heading;
  dynamic subHeading;
  dynamic title;
  dynamic subTitle;
  dynamic image;
  dynamic info;
  List<dynamic>? enums;
  dynamic game;
  dynamic required;
  dynamic cardType;
  List<dynamic>? stories;
  List<Card>? cards;
  dynamic cta;
  dynamic onSkip;
  dynamic onComplete;
  Fetch? submit;
  Fetch? fetch;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : json["type"],
        key: json["key"],
        topic:
            json["topic"] == null ? null : ContentTopic.fromJson(json["topic"]),
        audio: json["audio"],
        exercise: json["exercise"] == null
            ? null
            : Exercise.fromJson(json["exercise"]),
        heading: json["heading"],
        subHeading: json["sub_heading"],
        title: json["title"],
        subTitle: json["sub_title"],
        image: json["image"],
        info: json["info"],
        enums: json["enums"] == null
            ? null
            : List<dynamic>.from(json["enums"].map((x) => x)),
        game: json["game"],
        required: json["required"],
        cardType: json["card_type"],
        stories: json["stories"] == null
            ? null
            : List<dynamic>.from(json["stories"].map((x) => x)),
        cards: json["cards"] == null
            ? null
            : List<Card>.from(json["cards"].map((x) => Card.fromJson(x))),
        cta: json["cta"],
        onSkip: json["on_skip"],
        onComplete: json["on_complete"],
        submit: json["submit"] == null ? null : Fetch.fromJson(json["submit"]),
        fetch: json["fetch"] == null ? null : Fetch.fromJson(json["fetch"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "type": type == null ? null : type,
        "key": key,
        "topic": topic == null ? null : topic?.toJson(),
        "audio": audio,
        "exercise": exercise == null ? null : exercise?.toJson(),
        "heading": heading,
        "sub_heading": subHeading,
        "title": title,
        "sub_title": subTitle,
        "image": image,
        "info": info,
        "enums":
            enums == null ? null : List<dynamic>.from(enums!.map((x) => x)),
        "game": game,
        "required": required,
        "card_type": cardType,
        "stories":
            stories == null ? null : List<dynamic>.from(stories!.map((x) => x)),
        "cards": cards == null
            ? null
            : List<dynamic>.from(cards!.map((x) => x.toJson())),
        "cta": cta,
        "on_skip": onSkip,
        "on_complete": onComplete,
        "submit": submit == null ? null : submit?.toJson(),
        "fetch": fetch == null ? null : fetch?.toJson(),
      };
}

class Card {
  Card({
    required this.type,
    required this.emoticon,
    required this.block,
    required this.info,
    required this.title,
    required this.image,
    required this.locked,
    required this.heading,
    required this.body,
    required this.enums,
    required this.choices,
    required this.cases,
    required this.items,
    required this.options,
    required this.cta,
  });

  String? type;
  dynamic emoticon;
  dynamic block;
  dynamic info;
  List<dynamic>? title;
  String? image;
  bool? locked;
  String? heading;
  dynamic body;
  List<dynamic>? enums;
  List<dynamic>? choices;
  List<dynamic>? cases;
  List<dynamic>? items;
  List<dynamic>? options;
  Cta? cta;

  factory Card.fromJson(Map<String, dynamic> json) => Card(
        type: json["type"] == null ? null : json["type"],
        emoticon: json["emoticon"],
        block: json["block"],
        info: json["info"],
        title: json["title"] == null
            ? null
            : List<dynamic>.from(json["title"].map((x) => x)),
        image: json["image"] == null ? null : json["image"],
        locked: json["locked"] == null ? null : json["locked"],
        heading: json["heading"] == null ? null : json["heading"],
        body: json["body"],
        enums: json["enums"] == null
            ? null
            : List<dynamic>.from(json["enums"].map((x) => x)),
        choices: json["choices"] == null
            ? null
            : List<dynamic>.from(json["choices"].map((x) => x)),
        cases: json["cases"] == null
            ? null
            : List<dynamic>.from(json["cases"].map((x) => x)),
        items: json["items"] == null
            ? null
            : List<dynamic>.from(json["items"].map((x) => x)),
        options: json["options"] == null
            ? null
            : List<dynamic>.from(json["options"].map((x) => x)),
        cta: json["cta"] == null ? null : Cta.fromJson(json["cta"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "emoticon": emoticon,
        "block": block,
        "info": info,
        "title":
            title == null ? null : List<dynamic>.from(title!.map((x) => x)),
        "image": image == null ? null : image,
        "locked": locked == null ? null : locked,
        "heading": heading == null ? null : heading,
        "body": body,
        "enums":
            enums == null ? null : List<dynamic>.from(enums!.map((x) => x)),
        "choices":
            choices == null ? null : List<dynamic>.from(choices!.map((x) => x)),
        "cases":
            cases == null ? null : List<dynamic>.from(cases!.map((x) => x)),
        "items":
            items == null ? null : List<dynamic>.from(items!.map((x) => x)),
        "options":
            options == null ? null : List<dynamic>.from(options!.map((x) => x)),
        "cta": cta == null ? null : cta!.toJson(),
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
        text: json["text"] == null ? null : json["text"],
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
    required this.paramOne,
    required this.paramTwo,
    required this.screen,
  });

  String paramOne;
  dynamic paramTwo;
  String screen;

  factory Deeplink.fromJson(Map<String, dynamic> json) => Deeplink(
        paramOne: json["paramOne"] == null ? null : json["paramOne"],
        paramTwo: json["paramTwo"],
        screen: json["screen"] == null ? null : json["screen"],
      );

  Map<String, dynamic> toJson() => {
        "paramOne": paramOne == null ? null : paramOne,
        "paramTwo": paramTwo,
        "screen": screen == null ? null : screen,
      };
}

class Exercise {
  Exercise({
    required this.type,
    required this.steps,
    required this.times,
  });

  dynamic type;
  List<dynamic>? steps;
  dynamic times;

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        type: json["type"],
        steps: json["steps"] == null
            ? null
            : List<dynamic>.from(json["steps"].map((x) => x)),
        times: json["times"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "steps":
            steps == null ? null : List<dynamic>.from(steps!.map((x) => x)),
        "times": times,
      };
}

class Fetch {
  Fetch({
    required this.path,
    required this.query,
    required this.variables,
  });

  String path;
  String query;
  String variables;

  factory Fetch.fromJson(Map<String, dynamic> json) => Fetch(
        path: json["path"] == null ? null : json["path"],
        query: json["query"] == null ? null : json["query"],
        variables: json["variables"] == null ? null : json["variables"],
      );

  Map<String, dynamic> toJson() => {
        "path": path == null ? null : path,
        "query": query == null ? null : query,
        "variables": variables == null ? null : variables,
      };
}

class ContentTopic {
  ContentTopic({
    required this.next,
    required this.text,
    required this.progress,
  });

  dynamic next;
  String text;
  dynamic progress;

  factory ContentTopic.fromJson(Map<String, dynamic> json) => ContentTopic(
        next: json["next"],
        text: json["text"] == null ? null : json["text"],
        progress: json["progress"],
      );

  Map<String, dynamic> toJson() => {
        "next": next,
        "text": text == null ? null : text,
        "progress": progress,
      };
}

class Share {
  Share({
    required this.title,
    required this.text,
    required this.image,
    required this.url,
  });

  String title;
  String text;
  String image;
  String url;

  factory Share.fromJson(Map<String, dynamic> json) => Share(
        title: json["title"] == null ? null : json["title"],
        text: json["text"] == null ? null : json["text"],
        image: json["image"] == null ? null : json["image"],
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "text": text == null ? null : text,
        "image": image == null ? null : image,
        "url": url == null ? null : url,
      };
}

class Statistics {
  Statistics({
    required this.streams,
    required this.time,
  });

  String streams;
  String time;

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
        streams: json["streams"] == null ? null : json["streams"],
        time: json["time"] == null ? null : json["time"],
      );

  Map<String, dynamic> toJson() => {
        "streams": streams == null ? null : streams,
        "time": time == null ? null : time,
      };
}

class TopicElement {
  TopicElement({
    required this.topic,
    required this.done,
  });

  String topic;
  bool done;

  factory TopicElement.fromJson(Map<String, dynamic> json) => TopicElement(
        topic: json["topic"] == null ? null : json["topic"],
        done: json["done"] == null ? null : json["done"],
      );

  Map<String, dynamic> toJson() => {
        "topic": topic == null ? null : topic,
        "done": done == null ? null : done,
      };
}
