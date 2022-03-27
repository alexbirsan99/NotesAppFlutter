import 'package:flutter/material.dart';
import 'package:notes/UI/AddNotePage.dart';
import 'package:notes/UI/TagChip.dart';
import 'package:notes/objects/Note.dart';
import 'package:notes/utils/TagsNetwork.dart';
import 'dart:convert';

import '../objects/Tag.dart';

class NoteUI extends StatefulWidget {
  late Note note;
  NoteUI(this.note);

  @override
  State<StatefulWidget> createState() {
    return _NoteUI(note);
  }
}

class _NoteUI extends State<NoteUI> {
  late Note _note;

  Tag? tag;

  _NoteUI(Note note) {
    _note = note;
  }

  @override
  void initState() {
    super.initState();
    TagsNetwork.getTag(_note!.getTagID() ?? '').then((value) => {tag = value});
  }

  showImage() {
    if (_note?.getImage() != null) {
      String base64Image = _note?.getImage() ?? '';
      UriData? data = Uri.parse(base64Image).data;
      if (data != null) {
        return Expanded(
            flex: 4,
            child: Container(
              child: Image.memory(
                data.contentAsBytes(),
                fit: BoxFit.fitWidth,
              ),
            )
        );
      } else {
        return Container();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: UniqueKey(),
      onTap: () => {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddNotePage(_note, (updatedNote) {
              setState(() {
                _note = updatedNote;
              });
            })))
      },
      child: Container(
        height: 600,
        child: Card(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  showImage(),
                  Expanded(
                    flex: 1,
                    child: Text(_note?.getTitle() ?? ''),
                  ),
                  _note?.getTagID() != null? TagChip.setFutureTag(_note!.getTagID()!) : Container(),
                  Expanded(flex: 3, child: Text(_note?.getDescription() ?? ''))
                ],
              ),
            )),
      ),
    );
  }
}
