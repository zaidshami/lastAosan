

import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/data/model/response/filter_category.dart';

import '../../../../data/model/response/base/api_response.dart';
import '../../../../data/model/response/category.dart';
import '../../../../data/repository/category_repo.dart';
import '../../../../helper/api_checker.dart';
import '../data/model/SearchListModels/CategorySeachListModel.dart';
import '../data/repository/filter_category_repo.dart';


/*class FilterCategoryProvider extends ChangeNotifier {
  final FilterCategoryRepo filterCategoryRepo;

  FilterCategoryProvider({@required this.filterCategoryRepo});


  List<CategoryFilter> _attributes = [];

  List<CategoryFilter> get attributes => _attributes;

  Future<void> fetchAttributes(BuildContext context) async {
    ApiResponse apiResponse = await filterCategoryRepo.getCategoryFilterList();
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _attributes.clear();
      apiResponse.response.data.forEach((attribute) => _attributes.add(CategoryFilter.fromJson(attribute)));
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }
}*/

class FilterCategoryProvider extends ChangeNotifier {
  final FilterCategoryRepo filterCategoryRepo;

  FilterCategoryProvider({@required this.filterCategoryRepo});

  List<CategoryFilter> _attributes = [];
  Map<int, List<CategoryFilter>> _children = {};
  int _selectedParentIndex = 0;  // Add selectedParentIndex property
  List<CategoryFilter> _selectedChildren = [];
  List<CategoryFilter> get selectedChildren => _selectedChildren;

  List<CategoryFilter> get attributes => _attributes;
  Map<int, List<CategoryFilter>> get children => _children;
  int get selectedParentIndex => _selectedParentIndex;  // Add getter for selectedParentIndex

  void selectChild(CategoryFilter child) {
    if (!_selectedChildren.contains(child)) {
      _selectedChildren.add(child);
    }
    notifyListeners();
  }
  void deselectChild(CategoryFilter child) {
    _selectedChildren.remove(child);
    notifyListeners();
  }

  void selectParent(int index) {  // Add method to update selectedParentIndex
    _selectedParentIndex = index;
    notifyListeners();
  }

  Future<void> fetchAttributes(BuildContext context) async {
    ApiResponse apiResponse = await filterCategoryRepo.getCategoryFilterList();
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _attributes.clear();
      _children.clear();
      List<CategoryFilter> allAttributes = [];
      apiResponse.response.data.forEach((attribute) {
        allAttributes.add(CategoryFilter.fromJson(attribute));
      });
      allAttributes.forEach((attribute) {
        if (attribute.parentId == null) {
          _attributes.add(attribute);
        } else {
          if (!_children.containsKey(attribute.parentId)) {
            _children[attribute.parentId] = [];
          }
          _children[attribute.parentId].add(attribute);
        }
      });
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }
}
