import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class pnp extends StatefulWidget {
  const pnp({Key? key}) : super(key: key);
  @override
  State<pnp> createState() => _pnp();
}
class _pnp extends State<pnp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lokasi'),
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
        },
      ),
    );
  }
}