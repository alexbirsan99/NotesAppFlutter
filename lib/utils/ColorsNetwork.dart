import 'dart:convert';

import 'package:notes/objects/Color.dart';
import 'package:notes/objects/NetworkRequests.dart';

import '../objects/Color.dart';

abstract class ColorsNetwork {

  static List<ColorApp> _colors = [];

  static Future<List<ColorApp>> getColors() async {
    if(_colors.isEmpty) {
      var result = await NetworkRequests.getResult('colors/');
      if(result.statusCode == 200) {
        var colors = json.decode(result.body);
        for(var color in colors) {
          _colors.add(ColorApp.fromJson(color));
        }
      }
    }
    return _colors;
  }

  static ColorApp getColor(String id) {
    for(ColorApp color in _colors) {
      if(color.getID() == id) {
        return color;
      }
    }
    return _colors[0];
  }

}