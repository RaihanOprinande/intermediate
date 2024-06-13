// To parse this JSON data, do
//
//     final video = videoFromJson(jsonString);

import 'dart:convert';

Video videoFromJson(String str) => Video.fromJson(json.decode(str));

String videoToJson(Video data) => json.encode(data.toJson());

class Video {
  bool isSuccess;
  String message;
  List<Datum> data;

  Video({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
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
  String video;
  String nama;
  String thumbnail;

  Datum({
    required this.id,
    required this.video,
    required this.nama,
    required this.thumbnail,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    video: json["video"],
    nama: json["nama"],
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "video": video,
    "nama": nama,
    "thumbnail": thumbnail,
  };
}
