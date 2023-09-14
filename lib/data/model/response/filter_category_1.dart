import 'package:flutter/material.dart';

import '../../../utill/app_constants.dart';


class   MainAttribute {
  List<Attribute> data;
  int count;

  MainAttribute({this.data, this.count});

  MainAttribute.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Attribute>[];
      json['data'].forEach((v) {
        data.add(new Attribute.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

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
    if(id.toString()==AppConstants.ocasionsId){
      _temp=6;
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
    List<Child> childesList = [];
    if (json['childes'] != null) {
      childesList = (json['childes'] as List)?.map((i) => Child.fromJson(i))?.toList() ?? [];
    }

    return Attribute(
        id: json['id'],
        name: json['name'],
        childes: childesList,
        count: json['count']
    );
  }

}

class Child {
  String id;
  String name;
  String code;
  String icon ;
  int count ;
  List<Child> childes = [];

  Child({@required this.id, @required this.name, this.code, this.childes, this.count, this.icon});

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      id: json['id'].toString(),
      name: json['name'],
      code: json['code'],
      count: json['count'],
      icon: json['icon'],
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


