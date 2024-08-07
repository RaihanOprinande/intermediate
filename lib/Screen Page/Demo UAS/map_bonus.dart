import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../model/wisata model/List_wisata.dart';

class MapsAllPage extends StatefulWidget {
  @override
  _MapsAllPageState createState() => _MapsAllPageState();
}

class _MapsAllPageState extends State<MapsAllPage> {
  late GoogleMapController mapController;
  Future<Wisata>? _kampusFuture;

  @override
  void initState() {
    super.initState();
    _kampusFuture = fetchKampus();
  }

  Future<Wisata> fetchKampus() async {
    final response = await http.get(Uri.parse('http://192.168.43.18/intermediate/wisata/list.php'));

    if (response.statusCode == 200) {
      return wisataFromJson(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Maps'),
      ),
      body: FutureBuilder<Wisata>(
        future: _kampusFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            Set<Marker> markers = snapshot.data!.data.map((kampus) {
              double? lat;
              double? lng;
              try {
                lat = double.parse(kampus.latWisata);
                lng = double.parse(kampus.longWisata);
              } catch (e) {
                print('Error parsing lat/lng for kampus: ${kampus.namaWisata}, lat: ${kampus.latWisata}, lng: ${kampus.longWisata}');
                return null; // Return null for invalid data points
              }

              return Marker(
                markerId: MarkerId(kampus.namaWisata),
                position: LatLng(lat!, lng!),
                infoWindow: InfoWindow(
                  title: kampus.namaWisata,
                ),
              );
            }).where((marker) => marker != null).cast<Marker>().toSet();

            return GoogleMap(
              onMapCreated: (controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(-0.9145, 100.4607), // Koordinat pusat peta
                zoom: 10,
              ),
              markers: markers,
            );
          }
        },
      ),
    );
  }
}