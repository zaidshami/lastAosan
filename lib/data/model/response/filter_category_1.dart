import 'package:flutter/material.dart';

class Attribute {
  int id;
  String name;
  List<Child> childes;

  Attribute({@required this.id, @required this.name, @required this.childes});

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return Attribute(
      id: json['id'],
      name: json['name'],
      childes: (json['childes'] as List).map((i) => Child.fromJson(i)).toList(),
    );
  }
}

class Child {
  String id;
  String name;
  String code;

  Child({@required this.id, @required this.name, this.code});

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      id: json['id'].toString(),
      name: json['name'],
      code: json['code'],
    );
  }
}
