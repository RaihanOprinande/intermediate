import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intermediate/Screen%20Page/RumahSakit_Page.dart';

import '../model/kabupaten_Model.dart';
import '../model/provinsi.dart' as prov;

class KabupatenPage extends StatefulWidget {
  final String idProv;
  const KabupatenPage({super.key, required this.idProv});

  @override
  State<KabupatenPage> createState() => _KabupatenPageState();
}

class _KabupatenPageState extends State<KabupatenPage> {
  bool isLoading = false;
  List<Datum> listKabupaten = [];
  List<Datum> filteredKabupaten = [];

  @override
  void initState() {
    super.initState();
    getKabupaten();
  }

  Future<void> getKabupaten() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse("http://192.168.1.8/intermediate/Rumah_Sakit/kabupaten.php"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          Kabupaten modelKabupaten = Kabupaten.fromJson(data);
          listKabupaten = modelKabupaten.data.where((datum) => datum.idProvinsi == widget.idProv).toList();
          filteredKabupaten = List.from(listKabupaten);
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
          "Kabupaten"
        )
      ),
      body: ListView.builder(
        itemCount: filteredKabupaten.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(5),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              // elevation: 5,
              child: ListTile(
                // leading: Image.asset('gambar/rs2.jpg', width: 40),
                title: Row(
                  children: [
                    Icon(Icons.place,color: Colors.indigo,),
                    SizedBox(width: 10,),
                    Text(
                      filteredKabupaten[index].kabupaten,
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
                      builder: (context) => RumahsakitPage(kabupatenId: filteredKabupaten[index].id),
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
