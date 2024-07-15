// To parse this JSON data, do
//
//     final editpegawai = editpegawaiFromJson(jsonString);

import 'dart:convert';

Editpegawai editpegawaiFromJson(String str) => Editpegawai.fromJson(json.decode(str));

String editpegawaiToJson(Editpegawai data) => json.encode(data.toJson());

class Editpegawai {
  bool isSuccess;
  int value;
  String message;
  String firstname;
  String lastname;
  String phone;
  String email;
  String idPegawai;

  Editpegawai({
    required this.isSuccess,
    required this.value,
    required this.message,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.email,
    required this.idPegawai,
  });

  factory Editpegawai.fromJson(Map<String, dynamic> json) => Editpegawai(
    isSuccess: json["is_success"],
    value: json["value"],
    message: json["message"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    phone: json["phone"],
    email: json["email"],
    idPegawai: json["id_pegawai"],
  );

  Map<String, dynamic> toJson() => {
    "is_success": isSuccess,
    "value": value,
    "message": message,
    "firstname": firstname,
    "lastname": lastname,
    "phone": phone,
    "email": email,
    "id_pegawai": idPegawai,
  };
}
