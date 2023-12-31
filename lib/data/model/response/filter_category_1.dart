import 'package:flutter/material.dart';

import '../../../utill/app_constants.dart';
import '../SearchListModels/SearchListModel.dart';

class Attribute {
  int id;
  String name;
  List<Child> childes;


  List<Selected> get getChildIds{
    List<Selected> _temp=[];
    childes.forEach((element) {
      _temp.add(Selected(element.id,element.name));
    });
    return _temp;
  }


  int get type{
    int _temp=1;
    if(id.toString()==AppConstants.priceId){
      _temp=2;
    }if(id.toString()==AppConstants.colorsId){
      _temp=3;
    }
    return _temp;
  }

  Attribute({@required this.id, @required this.name, @required this.childes});

  factory Attribute.nonAttribute(){
    return Attribute(
      id: 1000,
      name: '',
      childes: [],
    );
  }
  factory Attribute.fromJson(Map<String, dynamic> json) {
    return Attribute(
      id: json['id'],
      name: json['name'],
      childes: (json['childes'] as List).map((i) => Child.fromJson(i)).toList(),
    );
  }
}

class Child {
  String  id;
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
