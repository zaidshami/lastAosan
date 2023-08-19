

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

  int get categorySelectedIndex => _categorySelectedIndexhome;
  int get categorySelectedIndexcategory => _categorySelectedIndexcategory;
  int get categorySubSelectedIndex => _categorySubSelectedIndex;

  //List<SubSubCategory> get allsubSubCategory=>widget.subSubCategory;
  List<SubSubCategory>  temp=[];
  Future<void> getCategoryList(bool reload, BuildContext context) async {
    if (_categoryList.length == 0 || reload) {
      ApiResponse apiResponse = await categoryRepo.getCategoryList();
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        _categoryList.clear();
        apiResponse.response.data.forEach((category) => _categoryList.add(Category.fromJson(category)));

        _categorySelectedIndexhome = 0;
        //  sl<SearchProvider>()..set_search_list(_categoryList);
      } else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }
  }
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
}
