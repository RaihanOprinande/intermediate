import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class locations extends StatefulWidget {
  const locations({Key? key}) : super(key: key);
  @override
  State<locations> createState() => _locations();
}
class _locations extends State<locations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lokasi kampus-kampus'),
        backgroundColor: Colors.white,
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        initialCameraPosition: const CameraPosition(
            target: LatLng(-0.9143104398097486, 100.466129537154),
            zoom: 16
        ),
        mapType: MapType.normal,
        markers: {
          const Marker(
              markerId: MarkerId("Politeknik Negeri Padang"),
              position: LatLng(-0.9143104398097486,
                  100.466129537154),infoWindow: InfoWindow(
              title: 'Politeknik Negeri Padang', snippet: 'Kampus Politeknik Negeri Padang'
          )),
          const Marker(
              markerId: MarkerId("Kampus UNAND"),
              position: LatLng(-0.9127445850033584, 100.4576326003318),infoWindow: InfoWindow(
              title: 'UNAND', snippet: 'Kampus UNAND'
          )),
          const Marker(
              markerId: MarkerId("Masjid"),
              position: LatLng(-0.9164409376054352, 100.45759522745504),infoWindow: InfoWindow(
              title: 'Masjid', snippet: 'Masjid Unand'
          )),
        },
      ),
    );
  }
}