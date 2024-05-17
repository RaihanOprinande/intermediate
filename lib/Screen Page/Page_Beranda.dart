import 'package:flutter/material.dart';
import 'package:intermediate/Screen%20Page/Camera.dart';
import 'package:intermediate/Screen%20Page/Mao.dart';

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
            ],
          ),
        ),
      ),
    );
  }
}
