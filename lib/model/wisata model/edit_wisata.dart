// To parse this JSON data, do
//
//     final editwisata = editwisataFromJson(jsonString);

import 'dart:convert';

Editwisata editwisataFromJson(String str) => Editwisata.fromJson(json.decode(str));

String editwisataToJson(Editwisata data) => json.encode(data.toJson());

class Editwisata {
  bool isSuccess;
  int value;
  String message;
  String namaWisata;
  String lokasiWisata;
  String deskripsiWisata;
  String id;

  Editwisata({
    required this.isSuccess,
    required this.value,
    required this.message,
    required this.namaWisata,
    required this.lokasiWisata,
    required this.deskripsiWisata,
    required this.id,
  });

  factory Editwisata.fromJson(Map<String, dynamic> json) => Editwisata(
    isSuccess: json["is_success"],
    value: json["value"],
    message: json["message"],
    namaWisata: json["nama_wisata"],
    lokasiWisata: json["lokasi_wisata"],
    deskripsiWisata: json["deskripsi_wisata"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "is_success": isSuccess,
    "value": value,
    "message": message,
    "nama_wisata": namaWisata,
    "lokasi_wisata": lokasiWisata,
    "deskripsi_wisata": deskripsiWisata,
    "id": id,
  };
}
