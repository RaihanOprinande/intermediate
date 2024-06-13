import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intermediate/Screen%20Page/Detail_Video.dart';

import '../model/Video_Model.dart';

class VideoPlaylistPage extends StatefulWidget {
  const VideoPlaylistPage({super.key});

  @override
  State<VideoPlaylistPage> createState() => _VideoPlaylistPageState();
}

class _VideoPlaylistPageState extends State<VideoPlaylistPage> {
  List<Datum>? filterVideo;
  List<Datum>? listVideo;
  bool isLoading = false;

  void initState() {
    super.initState();
  }

  Future<List<Datum>?> getVideo() async {
    try {
      http.Response response = await http
          .get(Uri.parse("http://192.168.1.8/intermediate/video/video.php"));
      return videoFromJson(response.body).data;
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
        title: Text("Video Playlist"),
      ),
      body: FutureBuilder(
        future: getVideo(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Datum>?> snapshot) {
          if (snapshot.hasData) {
            listVideo = snapshot.data;
            if (filterVideo == null) {
              filterVideo = listVideo;
            }
            return ListView.builder(
                itemCount: filterVideo!.length,
                itemBuilder: (context, index) {
                  Datum? data = filterVideo?[index];
                  return Padding(
                      padding: const EdgeInsets.all(10),
                      child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) => DetailVideo(data: data)));
                              },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    "http://192.168.1.8/intermediate/video/thumbnail/${data?.thumbnail}",
                                    height: 50,
                                    width: 50,
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text(
                                    "${data?.nama}"
                                ),
                                // Expanded(child: PlayerWidget(url: "http://localhost/intermediate/audio/${data?.audio}", fileName: data!.lagu)
                                //   ,)

                              ],
                            ),
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
    );
  }
}
