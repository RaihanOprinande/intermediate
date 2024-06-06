// To parse this JSON data, do
//
//     final audio = audioFromJson(jsonString);

import 'dart:convert';

Audio audioFromJson(String str) => Audio.fromJson(json.decode(str));

String audioToJson(Audio data) => json.encode(data.toJson());

class Audio {
  bool isSuccess;
  String message;
  List<Datum> data;

  Audio({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
    isSuccess: json["isSuccess"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String lagu;
  String audio;
  String photo;

  Datum({
    required this.id,
    required this.lagu,
    required this.audio,
    required this.photo,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    lagu: json["lagu"],
    audio: json["audio"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "lagu": lagu,
    "audio": audio,
    "photo": photo,
  };
}
