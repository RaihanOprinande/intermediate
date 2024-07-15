import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intermediate/Screen%20Page/Delete%20Mahasiswa/detail.dart';
import 'package:intermediate/model/sekolah_model/list_sekolah.dart';

class ListSekolah extends StatefulWidget {
  const ListSekolah({super.key});

  @override
  State<ListSekolah> createState() => _ListSekolahState();
}

class _ListSekolahState extends State<ListSekolah> {
  List<Datum>? filterSekolah;
  List<Datum>? listSekolah;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    listSekolah = await getSekolah();
    filterSekolah = listSekolah;
    setState(() {
      isLoading = false;
    });
  }

  Future<List<Datum>?> getSekolah() async {
    try {
      http.Response response = await http.get(Uri.parse("http://192.168.137.1/intermediate/delete/list.php"));
      return sekolahFromJson(response.body).data;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> deleteData(int id) async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.137.1/intermediate/delete/delete.php"),
        body: {'id': id.toString()},
      );

      final responseData = json.decode(response.body);
      if (responseData['isSuccess']) {
        // Pegawai berhasil dihapus
        print('Pegawai berhasil dihapus');

        // Tampilkan dialog berhasil dihapus
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sukses'),
              content: Text('Pegawai berhasil dihapus'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    fetchData(); // Fetch updated data
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Pegawai gagal dihapus
        print('Pegawai gagal dihapus');
      }
    } catch (error) {
      print('Error: $error');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("List siswa"),
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(
          color: Colors.orange,
        ),
      )
          : listSekolah == null || listSekolah!.isEmpty
          ? const Center(
        child: Text('No data available'),
      ) : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.all(10),
          child: MaterialButton(
            onPressed: () {

            },
            child: Text(
              "Tambah"
            ),
            color: Colors.blue,
          ),
          ),
          Expanded(child:ListView.builder(
            itemCount: filterSekolah!.length,
            itemBuilder: (context, index) {
              Datum? data = filterSekolah?[index];
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailSekolah(data: data),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: 10),
                            Text("Nama : ${data?.namaSiswa}"),
                            Text("Nama Sekolah : ${data?.namaSekolah}"),
                            Text("Email : ${data?.email}"),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                deleteData(int.parse(data!.id));
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),)
        ],
      )

    );
  }
}
