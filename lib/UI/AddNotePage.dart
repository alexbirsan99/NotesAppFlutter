// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:notes/UI/SelectTagDialog.dart';
import 'package:notes/UI/TagChip.dart';
import 'package:notes/utils/NotesNetwork.dart';

import '../objects/Note.dart';

import 'package:http/http.dart' as http;

import 'package:photo_view/photo_view.dart';

import '../objects/Tag.dart';
import './PhotoViewer.dart';

class AddNotePage extends StatefulWidget {
  late Note _note;
  var _updateNoteCallBack;

  AddNotePage(Note note, var updateNoteCallBack) {
    _note = Note.copyNote(note as Note);
    _updateNoteCallBack = updateNoteCallBack;
  }

  @override
  State<StatefulWidget> createState() {
    return _AddNotePage(_note, _updateNoteCallBack);
  }
}

class _Test extends State<AddNotePage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _AddNotePage extends State<AddNotePage> {
  var _appBarText = 'New Note';

  var _updateNoteCallBack;

  late Note _note;

  ImagePicker _picker = new ImagePicker();
  XFile? image;

  TextEditingController noteTitleController = new TextEditingController();
  TextEditingController noteDescriptionController = new TextEditingController();

  _AddNotePage(Note note, updateNoteCallBack) {
    _updateNoteCallBack = updateNoteCallBack;
    _note = note;
    if (note.getID() != null) {
      _appBarText = 'Edit note';
    } else {
      _appBarText = 'New note';
    }
    noteTitleController.text = _note.getTitle() ?? '';
    noteDescriptionController.text = _note.getDescription() ?? '';
    noteDescriptionController.addListener(() {
      _note.setDescription(noteDescriptionController.text);
    });
    noteTitleController.addListener(() {
      _note.setTitle(noteTitleController.text);
    });
  }

  showImage() {
    if (_note.getImage() != null) {
      String base64Image = _note.getImage() ?? '';
      UriData? data = Uri.parse(base64Image).data;
      if (data != null) {
        return Expanded(
            flex: 7,
            child: Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PhotoViewer(Image.memory(
                                data.contentAsBytes(),
                                fit: BoxFit.fitWidth,
                              ).image)));
                },
                child: Image.memory(
                  data.contentAsBytes(),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ));
      }
    }
    return Container(); 
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      /**
       * key -> the key of the current state
       * i give a unique key to force the widget to be re-rendered after set state
       */

      key: UniqueKey(),



      resizeToAvoidBottomInset:
          false, // this is for avoiding resizing the text fields when the keyboard appears
      appBar: AppBar(
        title: Text(_appBarText),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
        child: FloatingActionButton(
          onPressed: () {
            if (_note.id != null) {
              NotesNetwork.updateNote(_note);
              _updateNoteCallBack(_note);
              Navigator.pop(context);
            }
          },
          child: const Icon(Icons.edit),
        ),
      ),
      body: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          showImage(),
          Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: TextField(
                  controller: noteTitleController,
                  style: TextStyle(fontSize: 32),
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Note title'),
                ),
              )),
          _note.getID() != null ? Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: TagChip.setFutureTag(_note.getTagID()!)
                ),
              )
          ) : Container(),
          Expanded(
            flex: 14,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: TextField(
                  controller: noteDescriptionController,
                  maxLines: 100,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Note content'),
                ),
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Row(
                children: [
                  TextButton(
                      onPressed: () async {
                        image = await _picker.pickImage(
                            source: ImageSource.gallery);
                        if (image != null) {
                          File imageFile = File(image!.path);
                          setState(() {
                            _note.setImage(
                                base64.encode(imageFile.readAsBytesSync()));
                          });
                        }
                      },
                      child: const Icon(Icons.image)),
                  TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SelectTagDialog((Tag tag) {
                                setState(() {
                                  _note.setTagID(tag.getTagID()!);
                                });
                              }, _note.getTagID());
                            });
                      },
                      child: const Icon(Icons.tag))
                ],
              ))
        ],
      ),
    );
  }
}
