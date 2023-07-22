import 'package:flutter/material.dart';

import '../data/model/response/base/api_response.dart';
import '../data/model/response/filter_category_1.dart';
import '../data/repository/attribute_repo.dart';

import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/utill/app_constants.dart';

import '../data/model/SearchListModels/CategorySeachListModel.dart';
import '../data/model/response/base/api_response.dart';
import '../data/model/response/filter_category_1.dart';
import '../data/repository/attribute_repo.dart';

class AttributeProvider extends ChangeNotifier {
  final AttributeRepo attributeRepo;
  List<Attribute> attributes = [];
  bool loading = false;
  String errorMessage = '';
  int _selectedParentIndex = 1;

  AttributeProvider({@required this.attributeRepo});

  int get selectedParentIndex => _selectedParentIndex;

  List<Child> getCatChilds(List<CategorySearchListModel> category_search_list){
    List<Child> _temp=[];
    category_search_list.forEach((element) {
      _temp.add(Child(id: element.id.toString(),name: element.name,code: ""));
    });
    return _temp;
  }
  Future<void> fetchCategoryFilterList(List<CategorySearchListModel> category_search_list) async {
    if(attributes.isNotEmpty){
      return;
    }
    loading = true;
    notifyListeners();

    ApiResponse response = await attributeRepo.getCategoryFilterList();

    if (response.response != null) {
      List<dynamic> list = response.response.data;
      attributes.clear();
      // attributes.where((element) => element.id.toString()==AppConstants.categoryId).isEmpty?
      // attributes.add(Attribute(id: 1,name: "الاقسام",childes: getCatChilds(category_search_list))):"";

      list.map((item) => attributes.add(Attribute.fromJson(item))).toList();
      attributes.toSet();

    } else {
      errorMessage = 'Failed to fetch attributes: ${response.error.toString()}';
      print(errorMessage);
    }

    loading = false;
    // Don't call notifyListeners() here
  }

  void selectParent(int index) {
    _selectedParentIndex = index;
    notifyListeners();
  }
}


