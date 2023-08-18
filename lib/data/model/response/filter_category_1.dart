import 'package:flutter/material.dart';

import '../../../utill/app_constants.dart';

class Attribute {
  int id;
  String name;
  List<Child> childes;
  int count ;

  List<String> get getChildIds{
    List<String> _temp=[];
    childes.forEach((element) {
      if(element.id!=null)
        _temp.add(element.id);
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
    if(name=='الألوان'){
      _temp=4;
    }
    if(name=='المقاسات'){
      _temp=5;
    }
    return _temp;
  }

  Attribute({@required this.id, @required this.name, @required this.childes,this.count});

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
      count: json['count']
    );
  }
}

class Child {
  String id;
  String name;
  String code;
  int count ;
  List<Child> childes = [];

  Child({@required this.id, @required this.name, this.code, this.childes, this.count});

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      id: json['id'].toString(),
      name: json['name'],
      code: json['code'],
      count: json['count'],
      childes: (json['childes'] as List)?.map((i) => Child.fromJson(i))?.toList() ?? [],
    );
  }
}



class Selected {
  String  id;
  List<String> selected;

  Selected({@required this.id, @required this.selected,});

  factory Selected.fromJson(Map<String, dynamic> json) {
    return Selected(
      id: json['id'].toString(),
      selected: json['selected'],
    );
  }

  Map<String,dynamic> tojson(){
    return {
      "id":id,
      "selected":selected??[]



    };
  }


}


