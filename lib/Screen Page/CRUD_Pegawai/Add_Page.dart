
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intermediate/Screen%20Page/CRUD_Pegawai/List_Page.dart';
import 'package:intermediate/model/add_pegawai.dart';

class AddPagePegawai extends StatefulWidget {
  const AddPagePegawai({super.key});

  @override
  State<AddPagePegawai> createState() => _AddPagePegawaiState();
}

class _AddPagePegawaiState extends State<AddPagePegawai> {

  TextEditingController txtfirstname = TextEditingController();
  TextEditingController txtlastname = TextEditingController();
  TextEditingController txtphone = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtNohp = TextEditingController();

  GlobalKey<FormState> keyForm= GlobalKey<FormState>();

  //proses untuk hit api
  bool isLoading = false;
  Future<Addpegawai?> addpegawai() async{
    //handle error
    try{
      setState(() {
        isLoading = true;
      });

      http.Response response = await http.post(Uri.parse('http://192.168.1.8/intermediate/pegawai/add_Pegawai.php'),
          body: {
            "firstname": txtfirstname.text,
            "lastname": txtlastname.text,
            "phone": txtphone.text,
            "email": txtEmail.text,

          }
      );
      Addpegawai data = addpegawaiFromJson(response.body);
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
          => ListPagePegawai()
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
        title: Text('Form  Add Pegawai'),
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
                  validator: (val){
                    return val!.isEmpty ? "tidak boleh kosong " : null;
                  },
                  controller: txtlastname,
                  decoration: InputDecoration(
                      hintText: 'Input Full Name',
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
                  validator: (val){
                    return val!.isEmpty ? "tidak boleh kosong " : null;
                  },
                  controller: txtphone,
                  //biar password nya gak keliatan
                  decoration: InputDecoration(
                      hintText: 'Input nohp',
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
                      addpegawai();
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
