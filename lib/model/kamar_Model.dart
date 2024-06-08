// To parse this JSON data, do
//
//     final kamar = kamarFromJson(jsonString);

import 'dart:convert';

Kamar kamarFromJson(String str) => Kamar.fromJson(json.decode(str));

String kamarToJson(Kamar data) => json.encode(data.toJson());

class Kamar {
  bool isSuccess;
  String message;
  List<Datum> data;

  Kamar({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory Kamar.fromJson(Map<String, dynamic> json) => Kamar(
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
  String nama;
  String tersedia;
  String kosong;
  String antrian;
  String rumahSakitId;

  Datum({
    required this.id,
    required this.nama,
    required this.tersedia,
    required this.kosong,
    required this.antrian,
    required this.rumahSakitId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    nama: json["nama"],
    tersedia: json["tersedia"],
    kosong: json["kosong"],
    antrian: json["antrian"],
    rumahSakitId: json["rumah_sakit_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama": nama,
    "tersedia": tersedia,
    "kosong": kosong,
    "antrian": antrian,
    "rumah_sakit_id": rumahSakitId,
  };
}
