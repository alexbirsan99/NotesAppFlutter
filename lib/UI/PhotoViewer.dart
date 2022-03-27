import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewer extends StatelessWidget {

  late ImageProvider _image;

  PhotoViewer(ImageProvider image) {
    _image = image;
  }

  @override
  Widget build(BuildContext context) {
    return(
      Container(
        child: PhotoView(
          imageProvider: _image
        ),
      )
    );
  }

}