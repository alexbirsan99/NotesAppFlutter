

import 'package:flutter/material.dart';

import 'package:material_color_utilities/material_color_utilities.dart';

class ColorApp {

  String? _id, _name, _hexCode;

  ColorApp({String? id, String? name, String? hexCode}) {
    _id = id;
    _name = name;
    _hexCode = hexCode;
  }


  String? getID() {
    return _id;
  }

  String? getName() {
    return _name;
  }

  Color getColor() {
    return Color(int.parse('0xff' + _hexCode.toString()));
  }


  factory ColorApp.fromJson(Map<String, dynamic> colorJSON) {
    return ColorApp(
      id: colorJSON['id'],
      name: colorJSON['name'],
      hexCode: colorJSON['hexCode']
    );
  }

  toJson() {
    return {
      'id': _id,
      'name': _name,
      'hexCode': _hexCode
    };
  } 

}