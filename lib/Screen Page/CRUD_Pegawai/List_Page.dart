
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intermediate/Screen%20Page/CRUD_Pegawai/Add_Page.dart';
import 'package:intermediate/Screen%20Page/CRUD_Pegawai/Edit_Page.dart';
import 'dart:convert';

import '../../model/CRUD_Pegawai.dart';


class ListPagePegawai extends StatefulWidget {
  const ListPagePegawai({super.key});

  @override
  State<ListPagePegawai> createState() => _ListPagePegawaiState();
}

class _ListPagePegawaiState extends State<ListPagePegawai> {
  List<Datum>? filterPegawai;
  List<Datum>? listPegawai;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getPegawai().then((notes) {
      setState(() {
        listPegawai = notes;
        filterPegawai = notes;
      });
    });
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    listPegawai = await getPegawai();
    filterPegawai = listPegawai;
    setState(() {
      isLoading = false;
    });
  }

  Future<List<Datum>?> getPegawai() async {
    try {
      http.Response response = await http.get(
        Uri.parse("http://192.168.1.8/intermediate/pegawai/pegawai.php"),
      );
      return pegawaiFromJson(response.body).data;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  Future<void> deletePegawai(int id_pegawai) async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.1.8/intermediate/pegawai/delete_pegawai.php"),
        body: {'id_pegawai': id_pegawai.toString()},
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
        title: Text("Pegawai"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPagePegawai(),
                  ),
                );
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: Colors.indigo),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getPegawai(),
              builder: (BuildContext context, AsyncSnapshot<List<Datum>?> snapshot) {
                if (snapshot.hasData) {
                  listPegawai = snapshot.data;
                  if (filterPegawai == null) {
                    filterPegawai = listPegawai;
                  }
                  return ListView.builder(
                    itemCount: filterPegawai!.length,
                    itemBuilder: (context, index) {
                      Datum? data = filterPegawai?[index];
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Card(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Nama : ${data?.firstname} ${data?.lastname}"),
                                    SizedBox(height: 10),
                                    Text("Email : ${data?.email}"),
                                    SizedBox(height: 10),
                                    Text(
                                        "No Telp : ${data?.phone}"
                                    ),
                                    SizedBox(height: 10),
                                    // SizedBox(height: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 0),
                                          child: Row(
                                            children: [
                                              SizedBox(width: 10),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => EditPagePegawai(data: data),
                                                    ),
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.edit,
                                                  color: Colors.indigo,
                                                ),
                                              ),
                                              SizedBox(width: 20),
                                              GestureDetector(
                                                onTap: () {
                                                  deletePegawai(
                                                  int.parse(data!.idPegawai));
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.indigo,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.orange,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
