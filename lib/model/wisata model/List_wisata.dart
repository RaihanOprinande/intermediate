// To parse this JSON data, do
//
//     final wisata = wisataFromJson(jsonString);

import 'dart:convert';

Wisata wisataFromJson(String str) => Wisata.fromJson(json.decode(str));

String wisataToJson(Wisata data) => json.encode(data.toJson());

class Wisata {
  bool isSuccess;
  String message;
  List<Datum> data;

  Wisata({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory Wisata.fromJson(Map<String, dynamic> json) => Wisata(
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
  String namaWisata;
  String lokasiWisata;
  String deskripsiWisata;
  String latWisata;
  String longWisata;
  String profileWisata;
  String gambarWisata;

  Datum({
    required this.id,
    required this.namaWisata,
    required this.lokasiWisata,
    required this.deskripsiWisata,
    required this.latWisata,
    required this.longWisata,
    required this.profileWisata,
    required this.gambarWisata,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    namaWisata: json["nama_wisata"],
    lokasiWisata: json["lokasi_wisata"],
    deskripsiWisata: json["deskripsi_wisata"],
    latWisata: json["lat_wisata"],
    longWisata: json["long_wisata"],
    profileWisata: json["profile_wisata"],
    gambarWisata: json["gambar_wisata"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_wisata": namaWisata,
    "lokasi_wisata": lokasiWisata,
    "deskripsi_wisata": deskripsiWisata,
    "lat_wisata": latWisata,
    "long_wisata": longWisata,
    "profile_wisata": profileWisata,
    "gambar_wisata": gambarWisata,
  };
}
