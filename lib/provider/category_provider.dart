

import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../data/model/response/base/api_response.dart';
import '../../../../data/model/response/category.dart';
import '../../../../data/repository/category_repo.dart';
import '../../../../helper/api_checker.dart';
import '../data/model/SearchListModels/CategorySeachListModel.dart';


class CategoryProvider extends ChangeNotifier {
  final CategoryRepo categoryRepo;

  CategoryProvider({@required this.categoryRepo});

  List<Category> _categoryList = [];
  int _categorySelectedIndexhome=0;
  int _categorySubSelectedIndex=0;
  List<Category> get categoryList =>_categoryList;
  int _categorySelectedIndexcategory=0;
  List<CatageorySearch> get searchcategoryList {
    List<CatageorySearch> newlist=[];
    _categoryList.forEach((element) {
      newlist.add(CatageorySearch(element));
    });
    return newlist;
  }
  // List<int> _fetchedCatSelectedIndices;
  // List<int> _fetchedSubSelectedIndices;

  int get categorySelectedIndex => _categorySelectedIndexhome;
  int get categorySelectedIndexcategory => _categorySelectedIndexcategory;
  int get categorySubSelectedIndex => _categorySubSelectedIndex;

  //List<SubSubCategory> get allsubSubCategory=>widget.subSubCategory;
  List<SubSubCategory>  temp=[];
  List<SubCategory>  temp2=[];
  Future<void> getCategoryList(bool reload, BuildContext context) async {
    if (_categoryList.length == 0 || reload) {
      ApiResponse apiResponse = await categoryRepo.getCategoryList();
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        _categoryList.clear();
        apiResponse.response.data.forEach((category) => _categoryList.add(Category.fromJson(category)));

        _categorySelectedIndexhome = 0;
        addSubCategoryToCategory(228, 176);
        addSubCategoryToCategory(229, 177);
        addSubCategoryToCategory(266, 177);
        addSubCategoryToCategory(230, 176);
        addSubCategoryToCategory(293, 176);
        addSubCategoryToCategory(230, 177);
        addSubCategoryToCategory(265, 176);
        // addSubCategoryToCategory(228, 177);
        // addSubCategoryToCategory(228, 177);

        //  sl<SearchProvider>()..set_search_list(_categoryList);
      } else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }
  }

  void addSubCategoryToCategory(int subCategoryId, int categoryId) {

    Category targetCategory = _categoryList.firstWhere((cat) => cat.id == categoryId, orElse: () => null);

    // Assuming the subcategory with ID 228 might be within another category
    SubCategory subCategoryToAdd;
    for (Category category in _categoryList) {
      for (SubCategory subCat in category.subCategories) {
        if (subCat.id == subCategoryId) {
          subCategoryToAdd = subCat;
          break;
        }
      }
    }

    if (targetCategory != null && subCategoryToAdd != null) {
      targetCategory.addSubCategory(subCategoryToAdd);
      notifyListeners();
    } else {
      print("Category or SubCategory not found!");
    }
  }
//

  int getCatId(){
    return _categoryList[_categorySelectedIndexhome].id;
  }
  void changeSelectedIndex(int selectedIndex) {
    print("sssss $selectedIndex");
    _categorySelectedIndexhome = selectedIndex;

    notifyListeners();
  }
  void changeSelectedIndex1(int selectedIndex) {

    _categorySelectedIndexcategory = selectedIndex;
    notifyListeners();
  }
  void changeSubSelectedIndex(int selectedIndex) {
    _categorySubSelectedIndex = selectedIndex;
    notifyListeners();
  }









  Map<int, List<int>> _fetchedCatSelectedIndices = {};
  Map<int, List<int>> _fetchedSubSelectedIndices = {};

  Future<void> fetchIndices(int categorySelectedIndex) async {
    ApiResponse apiResponse = await categoryRepo.getCategorySection(categorySelectedIndex);
    if (apiResponse.response == null) {
      print("Received null response");
      return;
    }

    if (apiResponse.response.statusCode == 200) {
    print('qqqqqq'  );
    var rawData = apiResponse.response.data;
    List<Map> data = rawData.where((e) => e is Map).cast<Map>().toList();

    List<int> catSelectedIndices = [];
      List<int> subSelectedIndices = [];

      data.forEach((item) {
        if (item['type'] == 1) {
          catSelectedIndices.add(item['target']);
        } else if (item['type'] == 2) {
          subSelectedIndices.add(item['target2']);
        }
      });
      print("catSelectedIndices: $catSelectedIndices");
      print("subSelectedIndices: $subSelectedIndices");


      _fetchedCatSelectedIndices[categorySelectedIndex] = catSelectedIndices;
      _fetchedSubSelectedIndices[categorySelectedIndex] = subSelectedIndices;
      notifyListeners();
    }
  }

  List<int> getCatSelectedIndices() {
    if (_fetchedCatSelectedIndices.containsKey(categorySelectedIndex)) {
      return _fetchedCatSelectedIndices[categorySelectedIndex];
    }
/*    if (categorySelectedIndex == 0) {
      return [3,4,2,1 ];
    }
    else if (categorySelectedIndex == 1) {
      return [1];
    }
    else if (categorySelectedIndex == 2) {
      return [0,1];
    }
    else if (categorySelectedIndex == 3) {
      return [];
    }
    else if (categorySelectedIndex == 4) {
      return [];
    }
    else {
      return [];
    }*/
  }
  List<int> getSubSelectedIndices() {

    if (_fetchedSubSelectedIndices.containsKey(categorySelectedIndex)) {
      return _fetchedSubSelectedIndices[categorySelectedIndex];
    }

/*    if (categorySelectedIndex == 0) {
      return [0, 2, 3,1,6,10];
    }
    else if (categorySelectedIndex == 1) {
      return [8,5,7,4,10,11];
    }
    else if (categorySelectedIndex == 2) {
      return [0,1,2,3,4,5,6,7,8];
    }
    else if (categorySelectedIndex == 3) {
      return [0,1,2,3,4,5];
    }
    else if (categorySelectedIndex == 4) {
      return [0,1,2,3,4];
    }
    else {
      return [0];
    }*/
  }

  int getCatSelectedIndex() {
    if (categorySelectedIndex == 0) {
      return 4;
    }
    else if (categorySelectedIndex == 1) {
      return 3;
    }    else if (categorySelectedIndex == 2) {
      return 2;
    }    else if (categorySelectedIndex == 3) {
      return 1;
    }    else if (categorySelectedIndex == 4) {
      return 0;
    }

    else {
      return 0;
    }
  }
}