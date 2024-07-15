// To parse this JSON data, do
//
//     final deletepegawai = deletepegawaiFromJson(jsonString);

import 'dart:convert';

Deletepegawai deletepegawaiFromJson(String str) => Deletepegawai.fromJson(json.decode(str));

String deletepegawaiToJson(Deletepegawai data) => json.encode(data.toJson());

class Deletepegawai {
  int value;
  String message;

  Deletepegawai({
    required this.value,
    required this.message,
  });

  factory Deletepegawai.fromJson(Map<String, dynamic> json) => Deletepegawai(
    value: json["value"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "message": message,
  };
}
