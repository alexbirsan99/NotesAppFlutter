

class Note {
  String? id, title, description, createDate, modifyDate, image, tagID;

  Note({this.id, this.title, this.description, this.createDate, this.modifyDate,
    this.image, this.tagID});


  String? getID() {
    return this.id;
  }

  String? getTitle() {
    return this.title;
  }
  
  String? getModifyDate() {
    return this.modifyDate;
  }

  String? getCreateDate() {
    return this.createDate;
  }

  String? getDescription() {
    return this.description;
  }

  String? getTagID() {
    return this.tagID;
  }

  String? getImage() {
    return this.image;
  }

  void setImage(String image) {
    this.image = "data:image/jpeg;base64," + image;
  }

  void setTagID(String tagID) {
    this.tagID = tagID;
  }

  void setDescription(String description) {
    this.description = description;
  }

  
  void setTitle(String title) {
    this.title = title;
  }

  factory Note.copyNote(Note note) {
    return Note(
      id: note.getID(),
      title: note.getTitle(),
      description: note.getDescription(),
      modifyDate: note.getModifyDate(),
      createDate: note.getCreateDate(),
      image: note.getImage(),
      tagID: note.getTagID()
    );
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title']?? '',
      description: json['description'] ?? '',
      modifyDate: json['modifyDate']?? '',
      createDate: json['createDate']?? '',
      image: json['image']?? '',
      tagID: json['tagID']?? ''
    );
  }

  Map<String,String?> toJson() {
    return {
      'id' : id,
      'title' : title,
      'description' : description,
      'modifyDate' : modifyDate,
      'createDate' : createDate,
      'image' : image,
      'tagID' : tagID
    };
  }
}
