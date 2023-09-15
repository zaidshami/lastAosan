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
  // List<String> get getAllChildIds{
  //   List<String> _temp=[];
  //   childes.forEach((element) {
  //
  //     print("phase 1 ${element.name}");
  //     if(element.id!=null)
  //       _temp.add(element.id);
  //
  //     element.childes.forEach((element2) {
  //       print("phase 2 ${element2.name}");
  //
  //       if(element2.id!=null)
  //         _temp.add(element2.id);
  //
  //       element2.getAllChildIds.forEach((element3) {
  //
  //         if(element3=null)
  //           _temp.add(element3);
  //       });
  //
  //
  //     });
  //
  //     // if(element.id!=null)
  //     //   _temp.add(element.id);
  //   });
  //   return _temp;
  // }

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

  List<String>  get getAllChildIds{
    List<String> _temp=[];
    // _temp.add(id);

    childes.forEach((element) {

      if(element.id!=null)
        _temp.add(element.id);

      print("vvvv parent ${element.name}");
      print("vvvv parentid  ${element.id}");
      // print("vvvv parentattr  ${attid}");

     // if(attid==element.id||attid==""){
        print("my length ${_temp.length}");
        // print("my lengthj ${element.getAllChildIds('').length}");
        print("my parent ${element.name}");
        // if(_temp.firstWhere((elements) => elements==element.id).isEmpty){
        //   _temp.add(element.id);
        //
        // }
        // if(element.childes.isNotEmpty){
          print("ccc ${element.name}");
          // element.childes.forEach((elementk) {
          //   print("ccc2 ${elementk.id}");
          //   print("ccc2 ${elementk.name}");
            print("ccc2 ${element.id}");
            print("ccc2 ${element.name}");
            // elementk.childes.forEach((element) {
            //
            // });


        Child _tempo=element;
        // _tempo.childes.forEach((element) {
        //   _temp.add(element.id);
        //
        // });
        _tempo.getAllChildIds.forEach((elementk) {
          print("ccdd $elementk");

          if(elementk!=null)
                _temp.add(elementk);
            });
          // });


          //
          // element.childes.forEach((element2) {
          //   getAllChildIds.forEach((element) {
          //
          //     if(element!=null)
          //       _temp.add(element);
          //   });
          // });
        // }
    //  }
//       if(element.childes.isNotEmpty){
// print("ccc ${element.name}");
//
//         element.getAllChildIds(element.id).forEach((element) {
//           if(element!=null)
//             _temp.add(element);
//         });
//
//         //
//         // element.childes.forEach((element2) {
//         //   getAllChildIds.forEach((element) {
//         //
//         //     if(element!=null)
//         //       _temp.add(element);
//         //   });
//         // });
//       }



    });
    return _temp;
  }
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


