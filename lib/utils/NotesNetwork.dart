import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:notes/objects/NetworkRequests.dart';
import 'package:notes/objects/NetworkResult.dart';
import 'package:notes/objects/Note.dart';

abstract class NotesNetwork {



  static Future<NetworkResult> getAllNotes() async {
    List<Note> noteList = [];
    var result = await NetworkRequests.getResult('notes/');
    
    if(result.statusCode == 200) {
      var notesJSON = json.decode(result.body);
      for(var noteJSON in notesJSON) {
        noteList.add(Note.fromJson(noteJSON));
      }
    }
    return new NetworkResult(noteList, null, result.statusCode);
  }


  static Future<void> updateNote(Note note) async {
    await NetworkRequests.postResult('updateNote/id=${note.getID().toString()}/', note.toJson());
  }


  
}