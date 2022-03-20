class Tag {
  String? _id, _colorID;
  String _name = '';
  Tag({id, required name, colorID}) {
    _id = id;
    _name = name;
    _colorID = colorID;
  }

  String? getTagID() {
    return _id;
  }

  String getTagName() {
    return _name;
  }

  String? getTagColorID() {
    return _colorID;
  }

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id']?? '', 
      name: json['name'],
      colorID: json['colorID']?? ''
    );
  }
}
