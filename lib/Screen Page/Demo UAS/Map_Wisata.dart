import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intermediate/model/wisata%20model/List_wisata.dart';

class MapWisata extends StatefulWidget {
  final Datum? data;
  const MapWisata({super.key, this.data});

  @override
  State<MapWisata> createState() => _MapWisataState();
}

class _MapWisataState extends State<MapWisata> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(double.parse(widget.data!.latWisata),
              double.parse(widget.data!.longWisata)),
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: MarkerId(widget.data!.id),
            position: LatLng(double.parse(widget.data!.latWisata),
                double.parse(widget.data!.longWisata)),
            infoWindow: InfoWindow(
              title: widget.data!.namaWisata,
              snippet: widget.data!.lokasiWisata,
            ),
          ),
        },
      ),
    );
  }
}
