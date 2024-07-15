import 'package:flutter/material.dart';
import 'package:intermediate/Screen%20Page/Demo%20UAS/Map_Wisata.dart';
import 'package:intermediate/model/wisata%20model/List_wisata.dart';


class DetailWisata extends StatelessWidget {
  final Datum? data;
  const DetailWisata({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          "Detail Wisata"
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(10),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRect(
                child: Image.asset(
                  "assets/gambar/${data?.gambarWisata}",width: 300,height: 300,
                ),
              ),
              SizedBox(height: 20,),
              Text("Profile Wisata ${data?.profileWisata}"),
              Text("Nama Wisata ${data?.namaWisata}"),
              Text("Lokasi Wisata ${data?.lokasiWisata}"),
              Text("Deskripsi Wisata ${data?.deskripsiWisata}"),
              SizedBox(height: 20,),
              MaterialButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapWisata(data: data),
                  ),

                );
              },child: Text("map"),color: Colors.indigo,textColor: Colors.white,)
            ],
          ),
        ),
      )

    );
  }
}
