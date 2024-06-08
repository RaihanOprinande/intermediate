// To parse this JSON data, do
//
//     final provinsi = provinsiFromJson(jsonString);

import 'dart:convert';

Provinsi provinsiFromJson(String str) => Provinsi.fromJson(json.decode(str));

String provinsiToJson(Provinsi data) => json.encode(data.toJson());

class Provinsi {
  bool isSuccess;
  String message;
  List<Datum> data;

  Provinsi({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory Provinsi.fromJson(Map<String, dynamic> json) => Provinsi(
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
  String provinsi;

  Datum({
    required this.id,
    required this.provinsi,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    provinsi: json["provinsi"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "provinsi": provinsi,
  };
}
