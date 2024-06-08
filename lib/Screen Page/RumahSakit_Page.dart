import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intermediate/Screen%20Page/Kamar_Page.dart';
import '../model/RS.dart';

class RumahsakitPage extends StatefulWidget {
  final String kabupatenId;
  const RumahsakitPage({super.key, required this.kabupatenId});

  @override
  State<RumahsakitPage> createState() => _RumahsakitPageState();
}

class _RumahsakitPageState extends State<RumahsakitPage> {
  bool isLoading = false;
  List<Datum> listRS = [];
  List<Datum> filteredRS = [];

  @override
  void initState() {
    super.initState();
    getRumahSakit();
  }

  Future<void> getRumahSakit() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse("http://192.168.1.8/intermediate/Rumah_Sakit/rumahsakit.php"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          Rumahsakit modelrumahsakit = Rumahsakit.fromJson(data);
          listRS = modelrumahsakit.data.where((datum) => datum.kabupatenId == widget.kabupatenId).toList();
          filteredRS = List.from(listRS);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          "List Rumah Sakit"
        ),
      ),
      body:ListView.builder(
        itemCount: filteredRS.length,
        itemBuilder: (context, index) {
          final rumahSakit = filteredRS[index];
          return Padding(
            padding: EdgeInsets.all(10),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: ListTile(
                // leading: Image.network('http://192.168.43.124/rumahsakitDB/gambar/${rumahSakit.gambar}', width: 100, height: 80,),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.place_outlined, color: Colors.indigo,),
                    SizedBox(width: 10,),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Nama    : ${rumahSakit.nama ?? ""}"),
                        Text('Alamat  : ${rumahSakit.alamat ?? "N/A"}'),
                        Text('No Telp : ${rumahSakit.telp ?? 'N/A'}'),
                      ],
                    ))

                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KamarPage(rs: rumahSakit, rsID: filteredRS[index].id,)
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
