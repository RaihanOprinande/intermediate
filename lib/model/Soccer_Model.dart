// To parse this JSON data, do
//
//     final soccer = soccerFromJson(jsonString);

import 'dart:convert';

Soccer soccerFromJson(String str) => Soccer.fromJson(json.decode(str));

String soccerToJson(Soccer data) => json.encode(data.toJson());

class Soccer {
  List<Event> event;

  Soccer({
    required this.event,
  });

  factory Soccer.fromJson(Map<String, dynamic> json) => Soccer(
    event: List<Event>.from(json["event"].map((x) => Event.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "event": List<dynamic>.from(event.map((x) => x.toJson())),
  };
}

class Event {
  String strEvent;
  String strFilename;
  String strLeague;
  String strSeason;
  DateTime dateEvent;
  String strTime;
  String strPoster;

  Event({
    required this.strEvent,
    required this.strFilename,
    required this.strLeague,
    required this.strSeason,
    required this.dateEvent,
    required this.strTime,
    required this.strPoster,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    strEvent: json["strEvent"]?? '',
    strFilename: json["strFilename"]?? '',
    strLeague: json["strLeague"]?? '',
    strSeason: json["strSeason"]?? '',
    dateEvent: DateTime.parse(json["dateEvent"]),
    strTime: json["strTime"]?? '',
    strPoster: json["strPoster "]?? '',
  );

  Map<String, dynamic> toJson() => {
    "strEvent": strEvent,
    "strFilename": strFilename,
    "strLeague": strLeague,
    "strSeason": strSeason,
    "dateEvent": "${dateEvent.year.toString().padLeft(4, '0')}-${dateEvent.month.toString().padLeft(2, '0')}-${dateEvent.day.toString().padLeft(2, '0')}",
    "strTime": strTime,
    "strPoster ": strPoster,
  };
}
