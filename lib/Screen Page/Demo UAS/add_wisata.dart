
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intermediate/Screen%20Page/CRUD_Pegawai/List_Page.dart';
import 'package:intermediate/Screen%20Page/Demo%20UAS/List_wisata.dart';
import 'package:intermediate/model/add_pegawai.dart';
import 'package:intermediate/model/wisata%20model/add_wisata.dart';

class AddPageWisata extends StatefulWidget {
  const AddPageWisata({super.key});

  @override
  State<AddPageWisata> createState() => _AddPageWisataState();
}

class _AddPageWisataState extends State<AddPageWisata> {

  TextEditingController txtnamawisata = TextEditingController();
  TextEditingController txtlokasiwisata = TextEditingController();
  TextEditingController txtdeskripsiwisata = TextEditingController();
  TextEditingController txtlatwisata = TextEditingController();
  TextEditingController txtlongwisata = TextEditingController();
  TextEditingController txtprofilewisata = TextEditingController();
  TextEditingController txtgambarwisata = TextEditingController();

  GlobalKey<FormState> keyForm= GlobalKey<FormState>();

  //proses untuk hit api
  bool isLoading = false;
  Future<Addwisata?> addwisata() async{
    //handle error
    try{
      setState(() {
        isLoading = true;
      });

      http.Response response = await http.post(Uri.parse('http://192.168.43.18/intermediate/wisata/add_wisata.php'),
          body: {
            "nama_wisata": txtnamawisata.text,
            "lokasi_wisata": txtlokasiwisata.text,
            "deskripsi_wisata": txtdeskripsiwisata.text,
            "lat_wisata": txtlatwisata.text,
            "long_wisata": txtlongwisata.text,
            "profile_wisata": txtprofilewisata.text,
            "gambar_wisata": txtgambarwisata.text,

          }
      );
      Addwisata data = addwisataFromJson(response.body);
      //cek kondisi
      if(data.value == 1){
        //kondisi ketika berhasil register
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${data.message}'))
          );

          //pindah ke page login
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)
          => ListWisata()
          ), (route) => false);
        });
      }else if(data.value == 2){
        //kondisi akun sudah ada
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${data.message}'))
          );
        });
      }else{
        //gagal
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${data.message}'))
          );
        });
      }

    }catch (e){
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString()))
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('Form Wisata'),
      ),

      body: Form(
        key: keyForm,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),
                TextFormField(
                  //validasi kosong
                  validator: (val){
                    return val!.isEmpty ? "tidak boleh kosong " : null;
                  },
                  controller: txtnamawisata,
                  decoration: InputDecoration(
                      hintText: 'Input nama wisata',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
                SizedBox(height: 8,),
                TextFormField(
                  //validasi kosong
                  validator: (val){
                    return val!.isEmpty ? "tidak boleh kosong " : null;
                  },
                  controller: txtlokasiwisata,
                  decoration: InputDecoration(
                      hintText: 'Input Lokasi',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
                SizedBox(height: 8,),
                TextFormField(
                  //validasi kosong
                  validator: (val){
                    return val!.isEmpty ? "tidak boleh kosong " : null;
                  },
                  controller: txtlatwisata,
                  decoration: InputDecoration(
                      hintText: 'Input Latitude',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
                SizedBox(height: 8,),
                TextFormField(
                  validator: (val){
                    return val!.isEmpty ? "tidak boleh kosong " : null;
                  },
                  controller: txtlongwisata,
                  //biar password nya gak keliatan
                  decoration: InputDecoration(
                      hintText: 'Input longitude',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
                SizedBox(height: 8,),
                TextFormField(
                  validator: (val){
                    return val!.isEmpty ? "tidak boleh kosong " : null;
                  },
                  controller: txtprofilewisata,
                  //biar password nya gak keliatan
                  decoration: InputDecoration(
                      hintText: 'Input Profile',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
                SizedBox(height: 8,),
                TextFormField(
                  validator: (val){
                    return val!.isEmpty ? "tidak boleh kosong " : null;
                  },
                  controller: txtgambarwisata,
                  //biar password nya gak keliatan
                  decoration: InputDecoration(
                      hintText: 'Input gambar',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),

                SizedBox(height: 15,),
                Center( child: isLoading ? Center(
                  child: CircularProgressIndicator(),
                ) : MaterialButton(onPressed: (){

                  //cek validasi form ada kosong atau tidak
                  if(keyForm.currentState?.validate() == true){
                    setState(() {
                      addwisata();
                    });
                  }

                },
                  child: Text('Add'),
                  color: Colors.green,
                  textColor: Colors.white,
                )
                )],
            ),
          ),
        ),
      ),
    );
  }
}
