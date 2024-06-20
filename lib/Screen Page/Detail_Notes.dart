import 'package:flutter/material.dart';

import '../model/Notes_Model.dart';

class DetailNotes extends StatelessWidget {
  final Datum? data;
  const DetailNotes({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          "Detail Notes"
        ),
      ),
      body: Padding(padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("${data?.judul}"),
          SizedBox(height: 20,),
          Text("${data?.catatan}")
        ],
      )
      ),
    );
  }
}
