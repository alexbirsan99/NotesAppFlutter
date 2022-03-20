import 'package:flutter/material.dart';
import 'package:notes/UI/AddNotePage.dart';
import 'package:notes/objects/NetworkResult.dart';

import '../objects/Note.dart';
import 'GridNoteUI.dart';

class NotesPage extends StatelessWidget {

  NetworkResult? _noteNetworkResult;

  NotesPage(NetworkResult? noteNetworkResult) {
    _noteNetworkResult = noteNetworkResult;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Notes'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: GridNoteUI(_noteNetworkResult),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotePage(null, null)))
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
