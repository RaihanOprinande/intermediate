import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intermediate/Screen%20Page/Demo%20UAS/Detail_wisata.dart';
import 'package:intermediate/Screen%20Page/Demo%20UAS/Update_wisata.dart';
import 'package:intermediate/Screen%20Page/Demo%20UAS/add_wisata.dart';
import 'package:intermediate/Screen%20Page/Demo%20UAS/map_bonus.dart';
import 'package:intermediate/model/wisata%20model/List_wisata.dart';

class ListWisata extends StatefulWidget {
  const ListWisata({super.key});

  @override
  State<ListWisata> createState() => _ListWisataState();
}

class _ListWisataState extends State<ListWisata> {
  List<Datum>? filterWisata;
  List<Datum>? listWisata;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getWisata().then((notes) {
      setState(() {
        listWisata = notes;
        filterWisata = notes;
      });
    });
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    listWisata = await getWisata();
    filterWisata = listWisata;
    setState(() {
      isLoading = false;
    });
  }

  Future<List<Datum>?> getWisata() async {
    try {
      http.Response response = await http.get(
        Uri.parse("http://192.168.43.18/intermediate/wisata/list.php"),
      );
      return wisataFromJson(response.body).data;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  Future<void> deleteWisata(int id) async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.43.18/intermediate/wisata/delete.php"),
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
        title: Text("List Wisata"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddPageWisata(),
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
                SizedBox(width: 10,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapsAllPage(),
                      ),
                    );
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(color: Colors.indigo),
                    child: Icon(
                      Icons.comment,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ),
          Expanded(
            child: FutureBuilder(
              future: getWisata(),
              builder: (BuildContext context, AsyncSnapshot<List<Datum>?> snapshot) {
                if (snapshot.hasData) {
                  listWisata = snapshot.data;
                  if (filterWisata == null) {
                    filterWisata = listWisata;
                  }
                  return ListView.builder(
                    itemCount: filterWisata!.length,
                    itemBuilder: (context, index) {
                      Datum? data = filterWisata?[index];
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailWisata(data: data),
                              ),
                            );
                          },
                          child:Card(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRect(
                                        child: Image.network(
                                            "http://localhost/intermediate/wisata/gambar/${data?.gambarWisata}"
                                        ),
                                      ),
                                      Text("Nama Wisata : ${data?.namaWisata}"),
                                      SizedBox(height: 10),
                                      Text("Lokasi Wisata : ${data?.lokasiWisata}"),
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
                                                        builder: (context) => UpdateWisata(data: data),
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
                                                    deleteWisata(
                                                        int.parse(data!.id));
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
                        )

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
