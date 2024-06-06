import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intermediate/model/Player_Widget.dart';
import '../model/Audio_Model.dart';

class AudioPage extends StatefulWidget {
  const AudioPage({super.key});

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {

  void initState() {
    super.initState();
  }

  Future<List<Datum>?> getAudio() async {
    try {
      http.Response response = await http
          .get(Uri.parse("http://192.168.1.11/intermediate/audio.php"));
      return audioFromJson(response.body).data;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  List<Datum>? filterDevice;
  List<Datum>? listDevice;
  TextEditingController cari = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String urlExample = "http://localhost/intermediate/audio/JVKE%20-%20this%20is%20what%20autumn%20feels%20like.mp3";
    final String nameExample = "this is what autumn feels like";

    return Scaffold(
      appBar: AppBar(

      ),
      body: Column(
        children: [
          // TextFormField(
          //   controller: cari,
          //   onChanged: (value) {
          //     setState(() {
          //       filterDevice = listDevice
          //           ?.where((element) =>
          //       element.lagu!
          //           .toLowerCase()
          //           .contains(value.toLowerCase()) ||
          //           element.audio!
          //               .toLowerCase()
          //               .contains(value.toLowerCase()))
          //           .toList();
          //     });
          //   },
          //   decoration: InputDecoration(
          //     hintText: "Search",
          //     prefixIcon: Icon(Icons.search),
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.all(8.8),
          ),
          Expanded(
            child: FutureBuilder(
              future: getAudio(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Datum>?> snapshot) {
                if (snapshot.hasData) {
                  listDevice = snapshot.data;
                  if (filterDevice == null) {
                    filterDevice = listDevice;
                  }
                  return ListView.builder(
                      itemCount: filterDevice!.length,
                      itemBuilder: (context, index) {
                        Datum? data = filterDevice?[index];
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            // onTap: () {
                            //   //   //ini untuk ke detail
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (_) => DetailEdukasi(data)));
                            // },
                            child: Container(
                              child: Text(
                                "${data?.lagu}"
                              ),
                            )
                          ),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.orange,
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //         Padding(padding: EdgeInsets.all(10.0),
        //         child: Row(
        //           children: [
        //             Container(
        //               width: 130,
        //               height: 130,
        //               decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(10),
        //                 color: Colors.black
        //               ),
        //             ),
        //             SizedBox(width: 20,),
        //             Container(
        //               width: 130,
        //               height: 130,
        //               decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(10),
        //                   color: Colors.black
        //               ),
        //             ),
        //             SizedBox(width: 20,),
        //             Container(
        //               width: 130,
        //               height: 130,
        //               decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(10),
        //                   color: Colors.black
        //               ),
        //             ),
        //           ],
        //         ),
        //         ),
        //     SizedBox(height: 40,),
        //     Text("For you"),
        //     Padding(padding: EdgeInsets.all(10),
        //     )
        //   ],
        // ),
      );
  }
}


