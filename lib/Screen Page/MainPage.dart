import 'package:flutter/material.dart';
import 'package:intermediate/Screen%20Page/Detail_Page.dart';
import 'package:intermediate/Screen%20Page/Locations.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campuss'),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          SizedBox(height: 20,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => DetailPage()));
                },
              child: Container(
                width: 320,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Warna bayangan
                    spreadRadius: 2, // Radius penyebaran bayangan
                    blurRadius: 5, // Radius blur bayangan
                    offset: Offset(0, 3), // Posisi bayangan (x, y)
                  )]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Text(
                    "Politeknik Negeri Padang"
                  ),
                ),
              ),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => locations()));
                },
                child: Container(
                  width: 320,
                  height: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(90.0)),
                      color: Colors.white,
                      boxShadow: [BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Warna bayangan
                        spreadRadius: 2, // Radius penyebaran bayangan
                        blurRadius: 5, // Radius blur bayangan
                        offset: Offset(0, 3), // Posisi bayangan (x, y)
                      )]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Text(
                        "Kampus Lainnya"
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
