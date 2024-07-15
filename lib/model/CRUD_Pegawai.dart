// To parse this JSON data, do
//
//     final pegawai = pegawaiFromJson(jsonString);

import 'dart:convert';

Pegawai pegawaiFromJson(String str) => Pegawai.fromJson(json.decode(str));

String pegawaiToJson(Pegawai data) => json.encode(data.toJson());

class Pegawai {
  bool isSuccess;
  String message;
  List<Datum> data;

  Pegawai({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory Pegawai.fromJson(Map<String, dynamic> json) => Pegawai(
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
  String idPegawai;
  String firstname;
  String lastname;
  String phone;
  String email;

  Datum({
    required this.idPegawai,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.email,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idPegawai: json["id_pegawai"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    phone: json["phone"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id_pegawai": idPegawai,
    "firstname": firstname,
    "lastname": lastname,
    "phone": phone,
    "email": email,
  };
}
