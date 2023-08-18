import 'package:flutter/material.dart';

import '../data/model/response/base/api_response.dart';
import '../data/model/response/filter_category_1.dart';
import '../data/repository/attribute_repo.dart';
import '../data/model/SearchListModels/CategorySeachListModel.dart';
import '../utill/app_constants.dart';

class AttributeProvider extends ChangeNotifier {
  final AttributeRepo attributeRepo;
  List<Attribute> _attributes = [];

  List<Attribute> get attributes => _attributes;

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
  }

  void selectedCountIncrement(int value) {
    _selectedCount += value;
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
  void toggleCategoryFilter() {
    _isCategoryFilter = !_isCategoryFilter;
    notifyListeners(); // Notify listeners after the value is updated
  }

  AttributeProvider({@required this.attributeRepo});
  bool initialized = false;

  int get selectedParentIndex => _selectedParentIndex;
  List<Child> getCatChilds(List<CategorySearchListModel> category_search_list){
    List<Child> _temp=[];

    category_search_list.forEach((element) {

      _temp.add(Child(id: element.id.toString(),name: element.name,code: ""));

    });

    return _temp;

  }
  Future<void>  initializeData(String searchText,String catId) async {
    if (!initialized) {

      await fetchCategoryFilterListCatNew(searchText,catId);
      initialized = true;
    }
  }




  // Handles the loading state and notifies listeners
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
  }

   Future<void> fetchCategoryFilterListCatAgain(String searchText,List<Selected> atts) async {
    setLoading(true);

    ApiResponse response = await attributeRepo.getCategoryFilterListCategoryAgain1( name: searchText,atts: atts);

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
  }


  void setLoading(bool value) {
    loading = value;


  }
//this coin has blow hy mind
  void selectParent(int index) {
    _selectedParentIndex = index;
    notifyListeners();
  }
}

