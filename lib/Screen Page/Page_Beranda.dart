import 'package:flutter/material.dart';
import 'package:intermediate/Screen%20Page/Audio_Page.dart';
import 'package:intermediate/Screen%20Page/Audio_Player.dart';
import 'package:intermediate/Screen%20Page/Camera.dart';
import 'package:intermediate/Screen%20Page/Mao.dart';
import 'package:intermediate/Screen%20Page/Notes_Page.dart';
import 'package:intermediate/Screen%20Page/Provinsi_Page.dart';
import 'package:intermediate/Screen%20Page/Soccer_Page/List_Page.dart';
import 'package:intermediate/Screen%20Page/Video_Player.dart';
import 'package:intermediate/Screen%20Page/Video_Playlist_Page.dart';
import 'package:intermediate/model/Player_Widget.dart';
import 'package:video_player/video_player.dart';

class PageBeranda extends StatelessWidget {
  const PageBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AksesKamera()));
                },
                color: Colors.green,
                textColor: Colors.white,
                child: const Text(
                  'Camera',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              SizedBox(height: 10,),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MapsFlutter()));
                },
                color: Colors.green,
                textColor: Colors.white,
                child: const Text(
                  'Maps',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              SizedBox(height: 10,),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const VideoApp()));
                },
                color: Colors.green,
                textColor: Colors.white,
                child: const Text(
                  'Video',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              SizedBox(height: 10,),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AudioPlayerPage() ));
                },
                color: Colors.green,
                textColor: Colors.white,
                child: const Text(
                  'Al-Fatihah',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              SizedBox(height: 10,),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AudioPage() ));
                },
                color: Colors.green,
                textColor: Colors.white,
                child: const Text(
                  'Audio',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              SizedBox(height: 10,),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProvinsiPage() ));
                },
                color: Colors.green,
                textColor: Colors.white,
                child: const Text(
                  'Rumah Sakit',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              SizedBox(height: 10,),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const VideoPlaylistPage() ));
                },
                color: Colors.green,
                textColor: Colors.white,
                child: const Text(
                  'Video Playlist',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              SizedBox(height: 10,),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotesPage() ));
                },
                color: Colors.green,
                textColor: Colors.white,
                child: const Text(
                  'Notes',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              SizedBox(height: 10,),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListSoccerPage() ));
                },
                color: Colors.green,
                textColor: Colors.white,
                child: const Text(
                  'Soccer',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
