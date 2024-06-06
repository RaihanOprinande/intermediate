import 'package:flutter/material.dart';
import 'package:intermediate/Screen%20Page/PNP_Maps.dart';
import 'package:intermediate/model/detail_model.dart';

class DetailPage extends StatelessWidget {
  final Datum? data;
  const DetailPage({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Politeknik Negeri Padang"),
      ),
      body:
      ListView(
        children: [
          Container(
            width: 306,
            height: 290,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/gambar/politeknikNegeriPadang.jpg'), fit: BoxFit.cover
              ),
            ),
          ),
          SizedBox(height: 20,),
          Container(
            width: 320,
            height: 111,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Warna bayangan
                    spreadRadius: 2, // Radius penyebaran bayangan
                    blurRadius: 5, // Radius blur bayangan
                    offset: Offset(0, 3), // Posisi bayangan (x, y)
                  )
                ]
            ),
            child: Padding(padding: EdgeInsets.all(18),
                child: ListTile(
                  title: Text("Address"),
                  subtitle: Text(
                    data?.lokasiKampus ?? ""
                  ),
                ),
            ),
          ),
          SizedBox(height: 20,),
          Container(
            width: 320,
            height: 111,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Warna bayangan
                    spreadRadius: 2, // Radius penyebaran bayangan
                    blurRadius: 5, // Radius blur bayangan
                    offset: Offset(0, 3), // Posisi bayangan (x, y)
                  )
                ]
            ),
            child: Padding(padding: EdgeInsets.all(18),
              child: ListTile(
                title: Text("Profile"),
                subtitle: Text(
                    data?.profileKampus ?? ""
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          Text("Lokasi"),
          GestureDetector(onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => pnp()));
          },
          child: Container(
            width: 320,
            height: 269,
            decoration: BoxDecoration(
              image: DecorationImage(
              image:AssetImage('assets/gambar/sample.jpg'), fit:BoxFit.cover
              ),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Warna bayangan
                    spreadRadius: 2, // Radius penyebaran bayangan
                    blurRadius: 5, // Radius blur bayangan
                    offset: Offset(0, 3), // Posisi bayangan (x, y)
                  )
                ]
            ),
          ),
          )
        ],

      )
    );
  }
}
