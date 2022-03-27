import 'dart:io';

import 'package:flutter/material.dart';
import 'package:notes/UI/NoteUI.dart';

import '../objects/NetworkResult.dart';
import '../objects/Note.dart';

class GridNoteUI extends StatelessWidget {
  NetworkResult? _noteNetworkResult;

  List<Note>? _notes;

  GridNoteUI(NetworkResult? noteNetworkResult) {
    _noteNetworkResult = noteNetworkResult;
    if(_noteNetworkResult != null) {
      _notes = _noteNetworkResult!.getObjects() as List<Note>;
    }
  }

  @override
  Widget build(BuildContext context) {
    if(_noteNetworkResult != null && _noteNetworkResult!.getNetworkResult() == 200) {
      return GridView.builder(
          itemCount: _notes!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8
          ), 
          itemBuilder: (BuildContext context, int index) {
            return NoteUI(Note.copyNote(_notes![index]));
          }
      );
    } else {
      return CircularProgressIndicator();
    }
  }
}