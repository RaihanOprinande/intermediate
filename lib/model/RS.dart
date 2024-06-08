// To parse this JSON data, do
//
//     final rumahsakit = rumahsakitFromJson(jsonString);

import 'dart:convert';

Rumahsakit rumahsakitFromJson(String str) => Rumahsakit.fromJson(json.decode(str));

String rumahsakitToJson(Rumahsakit data) => json.encode(data.toJson());

class Rumahsakit {
  bool isSuccess;
  String message;
  List<Datum> data;

  Rumahsakit({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory Rumahsakit.fromJson(Map<String, dynamic> json) => Rumahsakit(
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
  String telp;
  String alamat;
  String kabupatenId;
  String latitude;
  String longitude;
  String gambar;

  Datum({
    required this.id,
    required this.nama,
    required this.telp,
    required this.alamat,
    required this.kabupatenId,
    required this.latitude,
    required this.longitude,
    required this.gambar,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    nama: json["nama"],
    telp: json["telp"],
    alamat: json["alamat"],
    kabupatenId: json["kabupaten_id"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    gambar: json["gambar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama": nama,
    "telp": telp,
    "alamat": alamat,
    "kabupaten_id": kabupatenId,
    "latitude": latitude,
    "longitude": longitude,
    "gambar": gambar,
  };
}
