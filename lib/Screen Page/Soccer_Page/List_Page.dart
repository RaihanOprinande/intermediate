import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intermediate/model/Soccer_Model.dart';

class ListSoccerPage extends StatefulWidget {
  const ListSoccerPage({super.key});

  @override
  State<ListSoccerPage> createState() => _ListSoccerPageState();
}

class _ListSoccerPageState extends State<ListSoccerPage> {
  List<Event>? filtersoccer;
  List<Event>? listsoccer;
  bool isLoading = false;
  void initState() {
    super.initState();
  }

  Future<List<Event>?> getVideo() async {
    try {
      http.Response response = await http
          .get(Uri.parse("https://www.thesportsdb.com/api/v1/json/3/searchevents.php?e=Arsenal_vs_Chelsea"));
      return soccerFromJson(response.body).event;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          "Premier League"
        ),
      ),
      body: FutureBuilder(
        future: getVideo(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Event>?> snapshot) {
          if (snapshot.hasData) {
            listsoccer = snapshot.data;
            if (filtersoccer == null) {
              filtersoccer = listsoccer;
            }
            return ListView.builder(
                itemCount: filtersoccer!.length,
                itemBuilder: (context, index) {
                  Event? data = filtersoccer?[index];
                  return Padding(
                      padding: const EdgeInsets.all(10),
                      child:
                      Container(
                        child: Column(


                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (_) => DetailVideo(data: data)));
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // ClipRRect(
                                //   borderRadius: BorderRadius.circular(8.0),
                                //   child: Image.network(
                                //     "http://192.168.1.168/intermediate/video/thumbnail/${data?.thumbnail}",
                                //     height: 50,
                                //     width: 50,
                                //   ),
                                // ),
                                SizedBox(width: 10,),
                                Text(
                                    "${data?.strFilename}"
                                ),
                                // Expanded(child: PlayerWidget(url: "http://localhost/intermediate/audio/${data?.audio}", fileName: data!.lagu)
                                //   ,)

                              ],
                            ),
                          )

                        ],
                      )
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
    );
  }
}
