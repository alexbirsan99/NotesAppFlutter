import 'package:flutter/material.dart';
import 'package:notes/utils/ColorsNetwork.dart';
import 'package:notes/utils/TagsNetwork.dart';

import '../objects/Tag.dart';

class TagChip extends StatefulWidget {
  Tag? _tag;

  late String _tagID;


  TagChip(Tag? tag) {
    _tag = tag;
  }

  TagChip.setFutureTag(String tagID) {
    _tagID = tagID;
  }

  @override
  State<StatefulWidget> createState() {
    return _tag != null? _TagChip(_tag)  : _TagChip.setFutureTag(_tagID);
  }
}

class _TagChip extends State<TagChip> {
  Tag? _tag;

  late Future<Tag?> _futureTag;

  Color? _tagColor;

  _TagChip(Tag? tag) {
    _tag = tag;
  }

  _TagChip.setFutureTag(String tagID) {
    TagsNetwork.getTag(tagID).then((tag) => {setState(() => _tag = tag)});
  }

  @override
  Widget build(BuildContext context) {
    ColorsNetwork.getColor(_tag!.getTagColorID()!).then((value) => {
          setState(() => {_tagColor = value.getColor()})
    });
    return (_tag != null
        ? Chip(
            backgroundColor: _tagColor,
            label: Text(
              _tag!.getTagName(),
              style: TextStyle(color: Colors.white),
            ),
          )
        : Container());
  }
}
