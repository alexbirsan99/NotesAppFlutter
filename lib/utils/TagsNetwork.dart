import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notes/objects/NetworkRequests.dart';
import 'package:notes/objects/Note.dart';
import 'package:notes/objects/Tag.dart';


abstract class TagsNetwork {

  static List<Tag> _allTags = [];

  static Future<Tag?> getTag(String id) async {
    var result = await NetworkRequests.getResult('tags=id' + id + '/');
    Tag? tag;
    if(result.statusCode == 200) {
      var tagJSON = jsonDecode(result.body);
      tag = Tag.fromJson(tagJSON);
    }
    return tag;
  }

  static Tag getTagFromList(String id) {
    for(Tag tag in _allTags) {
      if(id == tag.getTagID()) {
        return tag;
      }
    }
    return null as Tag;
  }

  static Future<List<Tag>> getAllTags() async {
    _allTags.isEmpty? await _setAllTags() : null;
    return _allTags;
  }

  static Future<void> _setAllTags() async {
    var result = await NetworkRequests.getResult('tags/');
    if(result.statusCode == 200) {
      var tags = json.decode(result.body);
      for(var tag in tags) {
        _allTags.add(Tag.fromJson(tag));
      }
    }
  }
}