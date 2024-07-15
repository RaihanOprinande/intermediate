import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intermediate/Screen%20Page/Demo%20UAS/List_wisata.dart';
import 'package:intermediate/model/wisata%20model/List_wisata.dart';
import 'package:intermediate/model/wisata%20model/edit_wisata.dart';


class UpdateWisata extends StatefulWidget {
  final Datum? data;

  const UpdateWisata({super.key, required this.data});

  @override
  State<UpdateWisata> createState() => _UpdateWisataState();
}

class _UpdateWisataState extends State<UpdateWisata> {

  TextEditingController txtnamawisata = TextEditingController();
  TextEditingController txtlokasiwisata = TextEditingController();
  TextEditingController txtdeskripsiwisata = TextEditingController();
  TextEditingController txtlatwisata = TextEditingController();
  TextEditingController txtlongwisata = TextEditingController();
  TextEditingController txtprofilewisata = TextEditingController();
  TextEditingController txtgambarwisata = TextEditingController();

  GlobalKey<FormState> keyForm= GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    txtnamawisata.text = widget.data!.namaWisata;
    txtlokasiwisata.text = widget.data!.lokasiWisata;
    txtdeskripsiwisata.text = widget.data!.deskripsiWisata;
    txtprofilewisata.text = widget.data!.profileWisata;
  }

  //proses untuk hit api

  Future<Editwisata?> editwisata() async {
    try {
      setState(() {
        isLoading = true;
      });

      http.Response response = await http.post(
          Uri.parse('http://192.168.43.18/intermediate/wisata/edit_wisata.php'),
          body: {
            "id": widget.data!.id.toString(),
            "nama_wisata": txtnamawisata.text,
            "lokasi_wisata": txtlokasiwisata.text,
            "deskripsi_wisata": txtdeskripsiwisata.text,
            "profile_wisata": txtprofilewisata.text,
          }
      );

      // Debugging: Print the response body
      print('Response Body: ${response.body}');

      // Check if the response status code is 200
      if (response.statusCode == 200) {
        Editwisata data = editwisataFromJson(response.body);

        // Check the value of data
        if (data.value == 1) {
          setState(() {
            isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${data.message}'))
            );
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => ListWisata()),
                    (route) => false
            );
          });
        } else {
          setState(() {
            isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${data.message}'))
            );
          });
        }
      } else {
        // Handle server errors
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Server error: ${response.statusCode}'))
          );
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e'))
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('Form Edit Pegawai'),
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
                  validator: (val) {
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
                  validator: (val) {
                    return val!.isEmpty ? "tidak boleh kosong " : null;
                  },
                  controller: txtlokasiwisata,
                  decoration: InputDecoration(
                      hintText: 'Input lokasi wisata',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
                SizedBox(height: 8,),
                TextFormField(
                  //validasi kosong
                  validator: (val) {
                    return val!.isEmpty ? "tidak boleh kosong " : null;
                  },
                  controller: txtdeskripsiwisata,
                  decoration: InputDecoration(
                      hintText: 'Input deskripsi',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
                SizedBox(height: 8,),
                TextFormField(
                  validator: (val) {
                    return val!.isEmpty ? "tidak boleh kosong " : null;
                  },
                  controller: txtprofilewisata,
                  //biar password nya gak keliatan
                  decoration: InputDecoration(
                      hintText: 'Input profile',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),

                SizedBox(height: 15,),
                Center(child: isLoading ? Center(
                  child: CircularProgressIndicator(),
                ) : MaterialButton(onPressed: () {

                  //cek validasi form ada kosong atau tidak
                  if (keyForm.currentState?.validate() == true) {
                    setState(() {
                      editwisata();
                    });
                  }
                },
                  child: Text('Edit'),
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
