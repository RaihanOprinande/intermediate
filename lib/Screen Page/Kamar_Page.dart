import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../model/kamar_Model.dart' as kamarmodel;
import '../model/RS.dart' as rsmodel;

class KamarPage extends StatefulWidget {
  final rsmodel.Datum rs;
  final String rsID;
  const KamarPage({super.key, required this.rs, required this.rsID,});

  @override
  State<KamarPage> createState() => _KamarPageState();
}

class _KamarPageState extends State<KamarPage> {
  bool isLoading = false;
  List<kamarmodel.Datum> listkamar = [];
  List<kamarmodel.Datum> filteredkamar = [];

  @override
  void initState() {
    super.initState();
    getkamar();
  }

  Future<void> getkamar() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse("http://192.168.1.8/intermediate/Rumah_Sakit/kamar.php"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          kamarmodel.Kamar modelkamar = kamarmodel.Kamar.fromJson(data);
          listkamar = modelkamar.data.where((datum) => datum.rumahSakitId == widget.rsID).toList();
          filteredkamar = modelkamar.data;
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
      body:  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(double.parse(widget.rs.latitude), double.parse(widget.rs.longitude)),
                  zoom: 15,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId(widget.rs.id),
                    position: LatLng(double.parse(widget.rs.latitude), double.parse(widget.rs.longitude)),
                    infoWindow: InfoWindow(
                      title: widget.rs.nama,
                      snippet: widget.rs.alamat,
                    ),
                  ),
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: listkamar.length,
                    itemBuilder: (context, index) {
                      final kamar = listkamar[index];
                      return Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           // Image.network(
                           //   'http://192.168.43.109/edukasi/gambar_berita/${widget.rs.gambar}',width: 50, height: 50,
                           // ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 5,
                              child: ListTile(
                                leading: Icon(Icons.local_hospital_outlined, color: Colors.indigo),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('nama Kamar    : ${(kamar.nama) ?? ""}'),
                                    Text('Kamar Tersedia: ${int.tryParse(kamar.tersedia) ?? 0}'),
                                    Text('Kamar Kosong  : ${int.tryParse(kamar.kosong) ?? 0}'),
                                    Text('Jumlah Antrian: ${int.tryParse(kamar.antrian) ?? 0}'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )


                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
