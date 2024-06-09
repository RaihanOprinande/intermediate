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
          .get(Uri.parse("http://192.168.1.23/intermediate/audio.php"));
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
  List<Datum>? urlExample;
  TextEditingController cari = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          "Songs"
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child:
            Text("Album"),
          ),
          Padding(padding: EdgeInsets.all(40.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                    'assets/gambar/LinkinPark.jpg',
                    )
                ),
              ),
              SizedBox(width: 40,),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      'assets/gambar/Autumn.jpg',
                    )
                ),
              )
            ],
          ),
          ),

          Padding(
            padding: EdgeInsets.all(4.8),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        "http://192.168.1.23/intermediate/gambar/${data?.photo}",
                                        height: 50,
                                        width: 50,
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Text(
                                        "${data?.audio}"
                                    ),
                                    Expanded(child: PlayerWidget(url: "http://localhost/intermediate/audio/${data?.audio}", fileName: data!.lagu),
                                    )

                                  ],
                                )
                              ],
                            )
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
      );
  }
}


