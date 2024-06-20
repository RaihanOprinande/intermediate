// To parse this JSON data, do
//
//     final notes = notesFromJson(jsonString);

import 'dart:convert';

Notes notesFromJson(String str) => Notes.fromJson(json.decode(str));

String notesToJson(Notes data) => json.encode(data.toJson());

class Notes {
  bool isSuccess;
  String message;
  List<Datum> data;

  Notes({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
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
  String judul;
  String catatan;

  Datum({
    required this.id,
    required this.judul,
    required this.catatan,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    judul: json["judul"],
    catatan: json["catatan"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "judul": judul,
    "catatan": catatan,
  };
}
