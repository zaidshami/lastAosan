import 'dart:convert';

import 'package:flutter/material.dart';

import '../data/model/response/base/api_response.dart';
import '../data/model/response/filter_category_1.dart';
import '../data/repository/attribute_repo.dart';
import '../data/model/SearchListModels/CategorySeachListModel.dart';
import '../utill/app_constants.dart';

class AttributeProvider extends ChangeNotifier {
  final AttributeRepo attributeRepo;

  AttributeProvider({@required this.attributeRepo});
  List<Attribute> _attributes = [];
  int currentAttributeIndex = 0;

  MainAttribute _mainAttribute ;
  List<Attribute> get attributes => _attributes;
  MainAttribute get  mainAttribute=> _mainAttribute;

  set attributes(List<Attribute> value) {
    _attributes = value;
  }

  bool _loading = false;

  set loading(bool value) {
    _loading = value;
  }

  bool get loading => _loading;
  String errorMessage = '';
  int _selectedParentIndex = 1;
  bool _isCategoryFilter = false;
int _selectedCount = 0;

  set selectedCount(int value) {
    _selectedCount = value;
    notifyListeners();
  }

  void selectedCountIncrement(int value) {
    _selectedCount = value;
    notifyListeners();
  }

  void selectedCountDecrement(int value) {
    _selectedCount -= value;
    notifyListeners();
  }
  int get selectedCount => _selectedCount;

  bool get isCategoryFilter => _isCategoryFilter;

  set isCategoryFilter(bool value) {
    _isCategoryFilter = value;
  }


  bool initialized = false;

  int get selectedParentIndex => _selectedParentIndex;

  Future<void>  initializeData(String searchText,String catId) async {
    if (!initialized) {

      await fetchCategoryFilterListCatNew(searchText,catId);
      initialized = true;
    }
  }



  Future<void> fetchCategoryFilterListCatNew(String searchText, String catId) async {
    setLoading(true);

    ApiResponse response = _isCategoryFilter ? await attributeRepo.getCategoryFilterListCategory(catId) : await attributeRepo.getCategoryFilterList(searchText);

    if (response.response != null) {
      print('zzzzz ${response.response.data}');

      MainAttribute tdata =MainAttribute.fromJson(response.response.data) ;
      _mainAttribute=tdata;
      print('zzzzz2 ${tdata.toJson()}');
      print('JSON Data: ${response.response.data}');


      List<Attribute> list = tdata.data;

      selectedCount = tdata.count;
      // _selectedCount = tdata.count;
      _attributes.clear();
      try{
        _attributes.addAll(list);
        // list.map((item) => _attributes.add(Attribute.fromJson(item))).toList();

      }catch(e){}
      _attributes.toSet();
    } else {
      errorMessage = 'Failed to fetch attributes: ${response.error.toString()}';
      print(errorMessage);
    }
    print("Dddd ${_attributes.length}");

    setLoading(false);
    notifyListeners();
  }
/*  // Handles the loading state and notifies listeners
  Future<void> fetchCategoryFilterListCatNew(String searchText, String catId) async {
    setLoading(true);

    ApiResponse response = _isCategoryFilter ? await attributeRepo.getCategoryFilterListCategory(catId) : await attributeRepo.getCategoryFilterList(searchText);

    if (response.response != null) {

      List<dynamic> list = response.response.data;
      _attributes.clear();
    try{
      list.map((item) => _attributes.add(Attribute.fromJson(item))).toList();

    }catch(e){}
      _attributes.toSet();
    } else {
      errorMessage = 'Failed to fetch attributes: ${response.error.toString()}';
      print(errorMessage);
    }

    setLoading(false);
     notifyListeners();
  }*/

   Future<void> fetchCategoryFilterListCatAgain(String searchText,List<Selected> atts) async {
     List<Selected> filteredAttributes = atts.where((attribute) => attribute.selected.isNotEmpty).toList();
    setLoading(true);
    ApiResponse response = await attributeRepo.getCategoryFilterListCategoryAgain1( name: searchText,atts: filteredAttributes);
   // print('JSON Data: ${jsonEncode(atts)}');

    if (response.response != null) {
      // print('JSON Data: ${response.response.data}');

      List<dynamic> list = response.response.data['data'];
      _attributes.clear();
    try{
      list.map((item) => _attributes.add(Attribute.fromJson(item))).toList();

    }catch(e){}
      _attributes.toSet();
    } else {

      errorMessage = 'Failed to fetch attributes: ${response.error.toString()}';
      print(errorMessage);
    }

    setLoading(false);
 notifyListeners();
  }


  void setLoading(bool value) {
    loading = value;
  }

  void selectParent(int index) {
    _selectedParentIndex = index;

  }
}