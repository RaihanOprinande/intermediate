// To parse this JSON data, do
//
//     final kabupaten = kabupatenFromJson(jsonString);

import 'dart:convert';

Kabupaten kabupatenFromJson(String str) => Kabupaten.fromJson(json.decode(str));

String kabupatenToJson(Kabupaten data) => json.encode(data.toJson());

class Kabupaten {
  bool isSuccess;
  String message;
  List<Datum> data;

  Kabupaten({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory Kabupaten.fromJson(Map<String, dynamic> json) => Kabupaten(
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
  String kabupaten;
  String idProvinsi;

  Datum({
    required this.id,
    required this.kabupaten,
    required this.idProvinsi,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    kabupaten: json["kabupaten"],
    idProvinsi: json["id_provinsi"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "kabupaten": kabupaten,
    "id_provinsi": idProvinsi,
  };
}
