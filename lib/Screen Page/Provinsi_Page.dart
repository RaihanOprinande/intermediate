import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intermediate/Screen%20Page/Kabupaten_Page.dart';
import 'package:intermediate/model/provinsi.dart';

import '../model/provinsi.dart';

class ProvinsiPage extends StatefulWidget {
  const ProvinsiPage({super.key});

  @override
  State<ProvinsiPage> createState() => _ProvinsiPageState();
}

class _ProvinsiPageState extends State<ProvinsiPage> {
  bool isLoading = false;
  List<Datum> listProvinsi = [];
  List<Datum> filteredProvinsi = [];

  @override
  void initState() {
    super.initState();
    getProvinsi();
  }

  Future<void> getProvinsi() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse("http://192.168.1.8/intermediate/Rumah_Sakit/provinsi.php"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          Provinsi modelProvinsi = Provinsi.fromJson(data);
          listProvinsi = modelProvinsi.data;
          filteredProvinsi = List.from(listProvinsi);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Provinsi"),
        backgroundColor: Colors.indigo,
      ),
      body:ListView.builder(
      itemCount: filteredProvinsi.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(5),
          child: Card(
            child: ListTile(
              // leading: Image.asset('gambar/rs1.png', width: 65),
              title: Row(
                children: [
                  Icon(Icons.place, color: Colors.indigo,),
                  SizedBox(width: 10,),
                  Text(
                    filteredProvinsi[index].provinsi,
                    style: TextStyle(
                      // color: Colors.cyan,
                      // fontWeight: FontWeight.bold,
                      // fontSize: 18,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KabupatenPage( idProv: filteredProvinsi[index].id),
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
