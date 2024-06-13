import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/Video_Model.dart';

class DetailVideo extends StatefulWidget {
  final Datum? data;
  const DetailVideo({super.key, this.data});

  @override
  State<DetailVideo> createState() => _DetailVideoState();
}

class _DetailVideoState extends State<DetailVideo> {
  VideoPlayerController? _controller;
  bool _isLoading = true;
  String? videoUrl;
  List<Datum>? listvideo;

  @override
  void initState() {
    super.initState();
    fetchVideoUrl();
  }

  Future<void> fetchVideoUrl() async {
    // Gantilah URL ini dengan URL endpoint API Anda
    final response = await http.get(Uri.parse('http://192.168.1.8/intermediate/video/video.php'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('API response: $data');  // Tambahkan log untuk melihat data respons
      setState(() {
        videoUrl = "http://localhost/intermediate/video/video/${widget.data?.video}"; // Sesuaikan dengan struktur data Anda
        print('Video URL: $videoUrl');  // Tambahkan log untuk melihat URL video
        _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl!))
          ..initialize().then((_) {
            setState(() {
              _isLoading = false;
            });
          });
      });
    } else {
      // Tangani kesalahan pengambilan data
      print('Failed to load video URL');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Sample Video',
              style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: _controller!.value.isInitialized
                  ? AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(_controller!),
              )
                  : Container(
                child: const Text('Loading Video...'),
              ),
            ),
          ],
        ),
        floatingActionButton: _isLoading
            ? null
            : FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller!.value.isPlaying
                  ? _controller!.pause()
                  : _controller!.play();
            });
          },
          child: Icon(
            _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }
}
