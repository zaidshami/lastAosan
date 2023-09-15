import 'dart:ffi';

import 'package:flutter/material.dart';
import '../../../../data/model/response/base/api_response.dart';
import '../../../../data/model/response/product_model.dart';
import '../../../../data/repository/search_repo.dart';
import '../../../../helper/api_checker.dart';
import '../data/model/SearchListModels/BrandSearchListModel.dart';
import '../data/model/SearchListModels/CategorySeachListModel.dart';
import '../data/model/SearchListModels/OptionsSearchListModel.dart';
import '../data/model/SearchListModels/SearchListModel.dart';
import '../data/model/response/filter_category_1.dart';

class SearchProvider with ChangeNotifier {
  final SearchRepo searchRepo;
  SearchProvider({@required this.searchRepo});
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _filterIndex = 0;
  List<String> _historyList = [];

  int get filterIndex => _filterIndex;

  set filterIndex(int value) {
    _filterIndex = value;
  }

  List<String> get historyList => _historyList;



  List<CategorySearchListModel> _category_search_list = [];
  List<CategorySearchListModel> get category_search_list =>
      _category_search_list;

  List<BrandSearchListModel> _brand_search_list = [];
  List<BrandSearchListModel> get brand_search_list => _brand_search_list;

  List<OptionsSearchListModel<OptionsSearch>> OptionsList = [];



  List<MainSearchModel> getlist_type(MainSearchModel mainSearchModel) {
    switch (mainSearchModel.runtimeType) {
      case CategorySearchListModel:
        return _category_search_list;
        break;

      case BrandSearchListModel:
        return _brand_search_list;
        break;

      default:
        return [];
    }
  }

  void setFilterIndex(int index) {
    _filterIndex = index;
    notifyListeners();
  }



  List<Product> _searchProductList;
  List<Product> _filterProductList = [];
  bool _isClear = true;
  int offset = 1;
  String _searchText = '';
  List<Product> get searchProductList => _searchProductList;
  bool get isClear => _isClear;
  String get searchText => _searchText;

  set searchText(String value) {
    _searchText = value;
  }

  int foundSize = 0;


  void cleanSearchProduct() {
    _searchProductList = [];
    _filterProductList = [];
    _isClear = true;
    _searchText = '';
    notifyListeners();
  }


  List<Selected> filterEncode() {
    List<Selected> _temp = [];
    selectedAttributes.forEach((key, value) {
      if (value.isNotEmpty) {
        _temp.add(Selected(id: key, selected: value));
      } else {
        _temp.add(Selected(id: key, selected: [])); // Add empty list for attributes with no selected values
      }
    });
    return _temp;
  }

  void newSearchProduct(
      String query,

      BuildContext context,
      {Function onNoMoreProducts,
        bool reload = true}) async {
    _isLoading = true;
    notifyListeners();
    _searchText = query;
    _isClear = false;


    reload ? _searchProductList = [] : null;
    reload ? _filterProductList = [] : null;
    reload ? offset = 1 : null;

    notifyListeners();
    List<Selected> filteredAttributes = filterEncode().where((attribute) => attribute.selected.isNotEmpty).toList();

    ApiResponse apiResponse = await searchRepo.getSearchProductList(
        name: _searchText,
        atts: filteredAttributes,
        offset: offset,
    sort: _filterIndex);


    print("sssss"+apiResponse.response.toString());
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {

      // Extract the new products from the response
      List<Product> newProducts =
          ProductModel.fromJson(apiResponse.response.data).products;
      foundSize = ProductModel.fromJson(apiResponse.response.data).totalSize;
      _searchProductList.addAll(newProducts);

      // Check if the query is not empty before adding new products
      // if (!query.isEmpty) {
      //   if (newProducts.isEmpty && onNoMoreProducts != null) {
      //     onNoMoreProducts();
      //   } else {
      //     _searchProductList.addAll(newProducts);
      //     _filterProductList.addAll(newProducts);
      //
      //     // After new data is added, sort the product list based on the current filter index.
      //     // sortSearchList(0, 0,
      //     //     isPrice: false); // Consider changing the parameters as needed.
      //   }
      // }

    } else {
    try{ApiChecker.checkApi(context, apiResponse);}catch(e){}
    }
    _isLoading = false;

    notifyListeners();
  }



  Map<String, List<String>> _selectedAttributes = {};

  Map<String, List<String>> get selectedAttributes => _selectedAttributes;

  void selectAttribute1(String category, String attribute) {
    if (_selectedAttributes[category].contains(attribute)) {
      // If the attribute is already selected, deselect it
      _selectedAttributes[category].remove(attribute);
    } else {
      // If the attribute is not selected, select it and deselect its parent
      _selectedAttributes[category] = [attribute];
      // You can add logic here to deselect the parent if necessary
    }
    notifyListeners();
  }

  void selectAttribute(String category, String attribute,List<Attribute> list) {

    if(_selectedAttributes[category].where((element) => element==attribute).isEmpty){
      _selectedAttributes[category].add(attribute);

    }
    list.where((element) => element.id.toString()==category).forEach((element) {

      element.childes.forEach((elementm) {

        elementm.getAllChildIds.forEach((elementsd) {

          if(elementm.id==attribute){
            _selectedAttributes[category].add(elementsd);

          }

          if(attribute==elementsd){

            elementm.childes.where((element) => element.id==elementsd).forEach((elements) {
              elements.getAllChildIds.forEach((element) {
                _selectedAttributes[category].add(element);

              });
            });
          }
        });
      });


    });
    notifyListeners();



  }
  // void selectAttribute(String category, String attribute,List<Attribute> list) {
  //
  //   if(_selectedAttributes[category].where((element) => element==attribute).isEmpty){
  //     _selectedAttributes[category].add(attribute);
  //
  //   }
  //   list.where((element) => element.id.toString()==category).forEach((element) {
  //
  //       element.childes.forEach((elementm) {
  //
  //         elementm.getAllChildIds.forEach((elementsd) {
  //
  //           if(elementm.id==attribute){
  //             _selectedAttributes[category].add(elementsd);
  //
  //           }
  //
  //           if(attribute==elementsd){
  //
  //             elementm.childes.where((element) => element.id==elementsd).forEach((elements) {
  //               elements.getAllChildIds.forEach((element) {
  //                 _selectedAttributes[category].add(element);
  //
  //               });
  //             });
  //           }
  //         });
  //       });
  //
  //
  //   });
  //   notifyListeners();
  //
  //
  //
  // }


//   void selectAttribute(String category, String attribute,List<Attribute> list) {
//
//     if(_selectedAttributes[category].where((element) => element==attribute).isEmpty){
//       _selectedAttributes[category].add(attribute);
//
//     }
// list.where((element) => element.id.toString()==category).forEach((element) {
//
//   if(element.id.toString()==category){
//     // print("namooo "+element.childes.firstWhere((element) => element.id==attribute).name);
//     // print("zzzzzk ${attribute}");
//     // element.childes.forEach((element) {print('childid ${element.id}  child name ${element.name}');});
//     element.childes.forEach((elementm) {
//       // print("zzzzzk2 ${elementm.id}");
//
//       elementm.getAllChildIds.forEach((elementsd) {
//        if(attribute==elementsd){
//          // print("zzzzzk3 $elementsd");
//          // print("zzzzzk3 ${elementsd.name}");
//          // _selectedAttributes[category].add(elementsd);
//
//          elementm.childes.where((element) => element.id==elementsd).forEach((elements) {
//            // print("zzzzzk4 ${elements.id}");
//            // print("zzzzzk5 ${elements.name}");
//
//            elements.getAllChildIds.forEach((element) {
//
//              _selectedAttributes[category].add(element);
//
//            });
//          });
//
//        }
//
//       });
//     });
//
//   }
//
// });
//     notifyListeners();
//
//
//
//   }

  // void selectAttribute(String category, String attribute) {
  //
  //   if(_selectedAttributes[category].where((element) => element==attribute).isEmpty){
  //     _selectedAttributes[category].add(attribute);
  //     notifyListeners();
  //
  //
  //   }
  //
  //
  //
  // }


  void deselectAttribute(String category, String attribute,List<Attribute> list) {
    if(_selectedAttributes[category].where((element) => element==attribute).isNotEmpty){

      beforeParent(category,attribute);

      _selectedAttributes[category].remove(attribute);
      removeParent(category,attribute);


    }
    list.where((element) => element.id.toString()==category).forEach((element) {


      element.childes.forEach((elementm) {

        elementm.getAllChildIds.forEach((elementsd) {

          if(elementm.id==attribute){
            // _selectedAttributes[category].remove(elementm.parent_id);
            beforeParent(category,elementsd);

            _selectedAttributes[category].remove(elementsd);
            removeParent(category,elementsd);


          }

          if(attribute==elementsd){

            elementm.childes.where((element) => element.id==elementsd).forEach((elements) {
              elements.getAllChildIds.forEach((element) {
                beforeParent(category,element);

                _selectedAttributes[category].remove(element);
                removeParent(category,element);

              });
            });
          }
        });
      });


    });

    notifyListeners();
    //
    // if(_selectedAttributes[category].where((element) => element==attribute).isNotEmpty){
    //   _selectedAttributes[category]?.remove(attribute);
    //   notifyListeners();
    // }

  }
  beforeParent(String category,String childId) {
    _selectedAttributes.forEach((key, value) {
      // print("before  key $key : value $value  count${value.length}");
      // print("value $value");
    });

  }
   removeParent(String category,String childId){
     _selectedAttributes.forEach((key, value) {
       // print("key $key");
       // print("after  key $key : value $value  count${value.length}");

       // print("value $value");
     });
  return ;
    _selectedAttributes.forEach((key, value) {
      print("key $key");
      print("value $value");
      value.forEach((elementd) {
        if(elementd==childId){
          var io= allChildes.firstWhere((element) => element.id==elementd).parent_id;
          _selectedAttributes[category].remove(io);

        }
        // allChildes.forEach((element) {
        //   _selectedAttributes[category].remove(element);
        //
        // });
        // list.forEach((element) {
        //   var io=  element.childes.firstWhere((element) => element.id == elementd).parent_id;
        //
        // }

       // );

      });

    });
  }

  // void deselectAttribute(String category, String attribute) {
  //   if(_selectedAttributes[category].where((element) => element==attribute).isNotEmpty){
  //     _selectedAttributes[category]?.remove(attribute);
  //     notifyListeners();
  //   }
  //
  // }

  void removeAllAttributes() {
    _selectedAttributes.clear();
    notifyListeners();
  }

  void fetchMore(BuildContext context, {Function onNoMoreProducts}) async {
    offset += 1;
    search(context,reload: false);

  }
  final TextEditingController searchController = TextEditingController();

  bool switchStatus=false;






  clearFilters(){
    switchStatus=false;
    searchController.clear();
    offset=1;
    _selectedAttributes.clear();
    notifyListeners();
  }



  void search(BuildContext context,{bool reload = false}) async {

    newSearchProduct(
        searchController.text,
        context,
        reload: reload
    );
  }

  Future<void> removeSearchHistoryIndex(int index) async {
    if (index >= 0 && index < _historyList.length) {
      String searchAddressToRemove = _historyList[index];
      bool removed = await searchRepo.removeSearchAddress(searchAddressToRemove);
      if (removed) {
        _historyList.removeAt(index);
        notifyListeners();
      }
    }
  }

  void initHistoryList() {
    _historyList = [];
    _historyList.addAll(searchRepo.getSearchAddress());
    notifyListeners();
  }

  void deleteFromHistory(int index) {
    _historyList.removeAt(index);
    notifyListeners(); // Notify listeners to rebuild UI
  }

  void saveSearchAddress(String searchAddress) async {
    searchRepo.saveSearchAddress(searchAddress);
    if (!_historyList.contains(searchAddress)) {
      _historyList.add(searchAddress);
    }
    notifyListeners();
  }

  void clearSearchAddress() async {
    searchRepo.clearSearchAddress();
    _historyList.clear();
    notifyListeners();
  }
}

extension UtilListExtension on List {
  groupBy(String key) {
    try {
      List<Map<String, dynamic>> result = [];
      List<String> keys = [];

      this.forEach((f) => keys.add(f[key]));

      [...keys.toSet()].forEach((k) {
        List data = [...this.where((e) => e[key] == k)];
        result.add({k: data});
      });

      return result;
    } catch (e, s) {
      return this;
    }
  }
}
