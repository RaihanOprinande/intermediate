import 'package:flutter/material.dart';
import 'package:intermediate/model/Soccer_Model.dart';

class DetailSoccer extends StatelessWidget {
  final Event? data;
  const DetailSoccer({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 16.0), // Adjust the height as needed
            ClipRect(
              child: Image.network(
                '${data?.strPoster}',
                width: 200,
              ),
            ),
            SizedBox(height: 10,),
            Text("Event : ${data?.strEvent}"),
            SizedBox(height: 10,),
            Text("Date Event : ${data?.dateEvent}"),
            SizedBox(height: 10,),
            Text("Time : ${data?.strTime}"),
            SizedBox(height: 10,),
            Text("Season : ${data?.strSeason}")
          ],
        ),
      ),
    );
  }
}
