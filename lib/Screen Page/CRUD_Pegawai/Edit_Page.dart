import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intermediate/Screen%20Page/CRUD_Pegawai/List_Page.dart';
// import 'package:intermediate/model/add_pegawai.dart';
import 'package:intermediate/model/edit_pegawai.dart';

import '../../model/CRUD_Pegawai.dart';

class EditPagePegawai extends StatefulWidget {
  final Datum? data;

  const EditPagePegawai({super.key, required this.data});

  @override
  State<EditPagePegawai> createState() => _EditPagePegawaiState();
}

class _EditPagePegawaiState extends State<EditPagePegawai> {

  TextEditingController txtfirstname = TextEditingController();
  TextEditingController txtlastname = TextEditingController();
  TextEditingController txtphone = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtNohp = TextEditingController();

  GlobalKey<FormState> keyForm= GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    txtfirstname.text = widget.data!.firstname;
    txtlastname.text = widget.data!.lastname;
    txtphone.text = widget.data!.phone;
    txtEmail.text = widget.data!.email;
  }

  //proses untuk hit api
  bool isLoading = false;
  Future<Editpegawai?> editpegawai() async {
    try {
      setState(() {
        isLoading = true;
      });

      http.Response response = await http.post(
          Uri.parse('http://192.168.1.8/intermediate/pegawai/edit_Pegawai.php'),
          body: {
            "id_pegawai": widget.data!.idPegawai.toString(),
            "firstname": txtfirstname.text,
            "lastname": txtlastname.text,
            "phone": txtphone.text,
            "email": txtEmail.text,
          }
      );

      // Debugging: Print the response body
      print('Response Body: ${response.body}');

      // Check if the response status code is 200
      if (response.statusCode == 200) {
        Editpegawai data = editpegawaiFromJson(response.body);

        // Check the value of data
        if (data.value == 1) {
          setState(() {
            isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${data.message}'))
            );
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => ListPagePegawai()),
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
                  controller: txtfirstname,
                  decoration: InputDecoration(
                      hintText: 'Input firstname',
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
                  controller: txtlastname,
                  decoration: InputDecoration(
                      hintText: 'Input lastname',
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
                  controller: txtEmail,
                  decoration: InputDecoration(
                      hintText: 'Input Email',
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
                  controller: txtphone,
                  //biar password nya gak keliatan
                  decoration: InputDecoration(
                      hintText: 'Input phone',
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
                      editpegawai();
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
