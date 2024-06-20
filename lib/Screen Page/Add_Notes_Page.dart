import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intermediate/Screen%20Page/Notes_Page.dart';

import '../model/Add_Notes_Model.dart';

class AddNotesPage extends StatefulWidget {
  const AddNotesPage({super.key});

  @override
  State<AddNotesPage> createState() => _AddNotesPageState();
}

class _AddNotesPageState extends State<AddNotesPage> {
  TextEditingController txtJudul = TextEditingController();
  TextEditingController txtCatatan = TextEditingController();

  GlobalKey<FormState> keyForm= GlobalKey<FormState>();

  bool isLoading = false;
  Future<Addnotes?> addnotes() async{
    //handle error
    try{
      setState(() {
        isLoading = true;
      });

      http.Response response = await http.post(Uri.parse('http://192.168.1.8/intermediate/notes/add_Notes.php'),
          body: {
            "judul": txtJudul.text,
            "catatan": txtCatatan.text,

          }
      );

      Addnotes data = addnotesFromJson(response.body);
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
          => NotesPage()
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Add Notes'),
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
                  controller: txtJudul,
                  decoration: InputDecoration(
                      hintText: 'Input Judul',
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
                  controller: txtCatatan,
                  decoration: InputDecoration(
                      hintText: 'Input Catatan',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
                SizedBox(height: 8,),


                SizedBox(height: 15,),
                Center( child: isLoading ? Center(
                  child: CircularProgressIndicator(),
                ) : MaterialButton(onPressed: (){

                  //cek validasi form ada kosong atau tidak
                  if(keyForm.currentState?.validate() == true){
                    setState(() {
                      addnotes();
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
