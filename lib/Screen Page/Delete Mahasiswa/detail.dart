import 'package:flutter/material.dart';
import 'package:intermediate/model/sekolah_model/list_sekolah.dart';

class DetailSekolah extends StatelessWidget {
  final Datum? data;
  const DetailSekolah({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          "Detail Siswa"
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
              "Nama : ${data?.namaSiswa}"
          ),
          Text(
              "Nama Sekolah : ${data?.namaSekolah}"
          ),
          Text(
              "Email : ${data?.email}"
          ),
          // IconButton(
          //   icon: Icon(Icons.delete),
          //   onPressed: () {
          //     showDeleteConfirmationDialog(
          //         int.parse(data!.id));
          //   },
          // ),
        ],
      ),
    );
  }


}

