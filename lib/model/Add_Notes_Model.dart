// To parse this JSON data, do
//
//     final addnotes = addnotesFromJson(jsonString);

import 'dart:convert';

Addnotes addnotesFromJson(String str) => Addnotes.fromJson(json.decode(str));

String addnotesToJson(Addnotes data) => json.encode(data.toJson());

class Addnotes {
  int value;
  String judul;
  String catatan;
  String message;

  Addnotes({
    required this.value,
    required this.judul,
    required this.catatan,
    required this.message,
  });

  factory Addnotes.fromJson(Map<String, dynamic> json) => Addnotes(
    value: json["value"],
    judul: json["judul"],
    catatan: json["catatan"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "judul": judul,
    "catatan": catatan,
    "message": message,
  };
}
