import 'package:flutter/material.dart';
import '../../../../data/datasource/remote/dio/dio_client.dart';
import '../../../../data/datasource/remote/exception/api_error_handler.dart';
import '../../../../data/model/response/base/api_response.dart';
import '../../../../utill/app_constants.dart';

class CategorySection {
  int index;
  int target;
  int target2;
  List<int> catGroup;
  int type;
  int numb;

  CategorySection(
      {this.index,
        this.target,
        this.target2,
        this.catGroup,
        this.type,
        this.numb});

  CategorySection.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    target = json['target'];
    target2 = json['target2'];
    catGroup = json['cat_group'].cast<int>();
    type = json['type'];
    numb = json['Numb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = this.index;
    data['target'] = this.target;
    data['target2'] = this.target2;
    data['cat_group'] = this.catGroup;
    data['type'] = this.type;
    data['Numb'] = this.numb;
    return data;
  }
}




