import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/Notes_Model.dart';

class EditNotesPage extends StatefulWidget {
  final Datum? data;

  EditNotesPage({required this.data});

  @override
  _EditNotesPageState createState() => _EditNotesPageState();
}

class _EditNotesPageState extends State<EditNotesPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _judulController;
  late TextEditingController _catatanController;

  @override
  void initState() {
    super.initState();
    _judulController = TextEditingController(text: widget.data?.judul);
    _catatanController = TextEditingController(text: widget.data?.catatan);
  }

  Future<void> updateData(String id) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.8/intermediate/notes/update.php'),
        body: {
          'id': id,
          'judul': _judulController.text,
          'catatan': _catatanController.text,
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['success']) {
          Navigator.pop(context, true); // Return to previous page with success flag
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Gagal mengedit data: ${jsonResponse['error']}'),
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
        title: Text('Edit Note'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _judulController,
                decoration: InputDecoration(labelText: 'Judul'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _catatanController,
                decoration: InputDecoration(labelText: 'Catatan'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a note';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    updateData(widget.data!.id.toString());
                  }
                },
                child: Text('Edit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
