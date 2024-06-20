import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intermediate/Screen%20Page/Add_Notes_Page.dart';
import 'package:intermediate/Screen%20Page/Detail_Notes.dart';
import 'package:intermediate/Screen%20Page/edit_notes_Page.dart';

import '../model/Notes_Model.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<Datum>? filterNotes;
  List<Datum>? listNotes;

  @override
  void initState() {
    super.initState();
    getNotes().then((notes) {
      setState(() {
        listNotes = notes;
        filterNotes = notes;
      });
    });
  }

  Future<List<Datum>?> getNotes() async {
    try {
      http.Response response = await http.get(
        Uri.parse("http://192.168.1.8/intermediate/notes/notes.php"),
      );
      return notesFromJson(response.body).data;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  Future<void> deleteData(String id) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.8/intermediate/notes/delete.php'),
        body: {'id': id},
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['success']) {
          setState(() {
            filterNotes = filterNotes?.where((note) => note.id != id).toList();
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Gagal menghapus data: ${jsonResponse['error']}'),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menghubungi server'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Notes"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddNotesPage(),
                  ),
                );
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: Colors.indigo),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getNotes(),
              builder: (BuildContext context, AsyncSnapshot<List<Datum>?> snapshot) {
                if (snapshot.hasData) {
                  listNotes = snapshot.data;
                  if (filterNotes == null) {
                    filterNotes = listNotes;
                  }
                  return ListView.builder(
                    itemCount: filterNotes!.length,
                    itemBuilder: (context, index) {
                      Datum? data = filterNotes?[index];
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${data?.judul}"),
                                    SizedBox(height: 10),
                                    Text("${data?.catatan}"),
                                    SizedBox(height: 10),
                                    Text(
                                        "___________________________________________________________________________"
                                    ),
                                    SizedBox(height: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context) => DetailNotes(data: data,)
                                                      )
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.remove_red_eye,
                                                  color: Colors.indigo,
                                                ),
                                              ),
                                              SizedBox(width: 20),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => EditNotesPage(data: data),
                                                    ),
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.edit,
                                                  color: Colors.indigo,
                                                ),
                                              ),
                                              SizedBox(width: 20),
                                              GestureDetector(
                                                onTap: () {
                                                  if (data?.id != null) {
                                                      deleteData(data!.id.toString());
                                                  } else {
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content: Text('ID tidak valid'),
                                                      ),
                                                    );
                                                  }
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.indigo,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
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
          ),
        ],
      ),
    );
  }
}
