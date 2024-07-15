// To parse this JSON data, do
//
//     final addwisata = addwisataFromJson(jsonString);

import 'dart:convert';

Addwisata addwisataFromJson(String str) => Addwisata.fromJson(json.decode(str));

String addwisataToJson(Addwisata data) => json.encode(data.toJson());

class Addwisata {
  int value;
  String namaWisata;
  String lokasiWisata;
  String deskripsiWisata;
  String latWisata;
  String longWisata;
  String profileWisata;
  String gambarWisata;
  String message;

  Addwisata({
    required this.value,
    required this.namaWisata,
    required this.lokasiWisata,
    required this.deskripsiWisata,
    required this.latWisata,
    required this.longWisata,
    required this.profileWisata,
    required this.gambarWisata,
    required this.message,
  });

  factory Addwisata.fromJson(Map<String, dynamic> json) => Addwisata(
    value: json["value"],
    namaWisata: json["nama_wisata"],
    lokasiWisata: json["lokasi_wisata"],
    deskripsiWisata: json["deskripsi_wisata"],
    latWisata: json["lat_wisata"],
    longWisata: json["long_wisata"],
    profileWisata: json["profile_wisata"],
    gambarWisata: json["gambar_wisata"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "nama_wisata": namaWisata,
    "lokasi_wisata": lokasiWisata,
    "deskripsi_wisata": deskripsiWisata,
    "lat_wisata": latWisata,
    "long_wisata": longWisata,
    "profile_wisata": profileWisata,
    "gambar_wisata": gambarWisata,
    "message": message,
  };
}
