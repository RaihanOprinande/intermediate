// To parse this JSON data, do
//
//     final addpegawai = addpegawaiFromJson(jsonString);

import 'dart:convert';

Addpegawai addpegawaiFromJson(String str) => Addpegawai.fromJson(json.decode(str));

String addpegawaiToJson(Addpegawai data) => json.encode(data.toJson());

class Addpegawai {
  int value;
  String firstname;
  String lastname;
  String phone;
  String email;
  String message;

  Addpegawai({
    required this.value,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.email,
    required this.message,
  });

  factory Addpegawai.fromJson(Map<String, dynamic> json) => Addpegawai(
    value: json["value"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    phone: json["phone"],
    email: json["email"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "firstname": firstname,
    "lastname": lastname,
    "phone": phone,
    "email": email,
    "message": message,
  };
}
