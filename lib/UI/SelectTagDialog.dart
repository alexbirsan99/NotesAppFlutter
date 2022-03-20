import 'package:flutter/material.dart';
import 'package:notes/utils/ColorsNetwork.dart';
import 'package:notes/utils/TagsNetwork.dart';

import '../objects/Note.dart';
import '../objects/Tag.dart';
import '../objects/Color.dart';

class SelectTagDialog extends StatefulWidget {
  Note? _currentNote;

  SelectTagDialog(Note currentNote) {
    _currentNote = currentNote;
  }

  @override
  State<StatefulWidget> createState() => _SelectTagDialog(_currentNote);
}

class _SelectTagDialog extends State<SelectTagDialog> {
  List<Tag> _allTags = [];

  List<_TagColorComponent> colorComponents = [];

  Tag? _selectedTag;

  List<ColorApp> colors = [];

  Note? _currentNote;

  _SelectTagDialog(Note? currentNote) {
    _currentNote = currentNote;
  }

  @override
  void initState() {
    super.initState();
    ColorsNetwork.getColors().then((value) => setState(() => colors = value,));
    TagsNetwork.getAllTags().then((value) => setState(() {
      _allTags = value;
      for(Tag tag in _allTags) {
        if(tag.getTagID() == _currentNote!.getTagID()) {
          _selectedTag = tag;
        }
      }
    }));
  }

  onTagSelected(var selectedTag) {
    _selectedTag = selectedTag;
    print(_selectedTag!.getTagID());
    for (_TagColorComponent colorComponent in colorComponents) {
      _TagColorComponentState _colorComponentState = colorComponent._colorComponentState;
      _colorComponentState.setState(() {
        _colorComponentState._selectedTag = _selectedTag;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.transparent,
        child: Container(
            padding: EdgeInsets.all(24),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Text(
                      'Select tag',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                      child: ListView.separated(
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: _allTags.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            Tag _currentTag = _allTags[index];
                            _TagColorComponent _colorComponent = _TagColorComponent(_currentTag, onTagSelected, _selectedTag);
                            colorComponents.add(_colorComponent);
                            return _colorComponent;
                          }),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel')),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                _currentNote!
                                    .setTagID(_selectedTag != null? _selectedTag!.getTagID()! : '');
                              },
                              child: Text('Confirm'))
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )));
  }
}

class _TagColorComponent extends StatefulWidget {
  Tag? _tag, _selectedTag;
  var _callBack;
  var _colorComponentState;
  _TagColorComponent(Tag tag, var callBack, Tag? selectedTag) {
    _tag = tag;
    _callBack = callBack;
    _selectedTag = selectedTag;
  }

  @override
  State<StatefulWidget> createState() {
    _colorComponentState = _TagColorComponentState(_tag, _callBack, _selectedTag);
    return _colorComponentState;
  }
}

class _TagColorComponentState extends State {
  Tag? _tag, _selectedTag;
  var _callBack;

  _TagColorComponentState(Tag? tag, var callBack, Tag? selectedTag) {
    _tag = tag;
    _callBack = callBack;
    _selectedTag = selectedTag;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _callBack != null
          ? () {
              _callBack(_tag);
            }
          : null,
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color:
                      ColorsNetwork.getColor(_tag!.getTagColorID().toString())
                          .getColor(),
                  shape: BoxShape.circle,
                ),
              )),
          Expanded(
              flex: 7,
              child: Container(
                child: Text(
                  _tag!.getTagName(),
                  style: TextStyle(fontSize: 24),
                ),
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              )),
          Expanded(
              flex: 1,
              child: Container(
                child: _selectedTag == null ? null : _selectedTag!.getTagID() == _tag!.getTagID() ? Icon(Icons.done) : null,
              ))
        ],
      ),
    );
  }
}
