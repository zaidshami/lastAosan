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
  List<String> get historyList => _historyList;

  // List<Product> _filterProductList = [];

  List<CategorySearchListModel> _category_search_list = [];
  List<CategorySearchListModel> get category_search_list =>
      _category_search_list;

  List<BrandSearchListModel> _brand_search_list = [];
  List<BrandSearchListModel> get brand_search_list => _brand_search_list;

  List<OptionsSearchListModel<OptionsSearch>> OptionsList = [];

  int get _selected_brand =>
      brand_search_list.where((element) => element.is_selected).first.id;
  int get _selected_category =>
      category_search_list.where((element) => element.is_selected).first.id;
  List<int> _selectedOptions = [];

  void init_lists(
      List<CatageorySearch> catList, List<BrandSearch> brandList) {
    add_to_search_list(CategorySearchListModel<CatageorySearch>(),
        _category_search_list, catList);
    add_to_search_list(
        BrandSearchListModel<BrandSearch>(), _brand_search_list, brandList);
  }

  void insert_catagory_list(List<CatageorySearch> list) {}

  void insert_brand_list(List<BrandSearch> list) {}

  void add_to_search_list(MainSearchModel mainSearchModel,
      List<MainSearchModel> searchList, List<SearchRequerments> typelist) {
    if (mainSearchModel.insert_to_list(typelist, searchList)) {
      notifyListeners();
    }
  }

  change_search_list(MainSearchModel mainSearchModel) {
    mainSearchModel.set_selected(
        getlist_type(mainSearchModel), mainSearchModel.id);

    notifyListeners();
  }

  change_options_search_list(
      int id, OptionsSearchListModel optionsSearchListModel) {
    optionsSearchListModel.set_selected(
        OptionsList.where((element) => element.id == id).first.item.ttlist,
        optionsSearchListModel.id);

    notifyListeners();
  }

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

  void sortSearchList(double startingPrice, double endingPrice,
      {bool isPrice = true}) {
    _searchProductList = [];
    if (isPrice && startingPrice > 0 && endingPrice > startingPrice) {
      _searchProductList.addAll(_filterProductList
          .where((product) =>
      (product.unitPrice) > startingPrice &&
          (product.unitPrice) < endingPrice)
          .toList());
    } else {
      _searchProductList.addAll(_filterProductList);
    }

    if (_filterIndex == 0) {
    } else if (_filterIndex == 1) {
      _searchProductList
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    } else if (_filterIndex == 2) {
      _searchProductList
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      Iterable iterable = _searchProductList.reversed;
      _searchProductList = iterable.toList();
    } else if (_filterIndex == 3) {
      _searchProductList.sort((a, b) => a.unitPrice.compareTo(b.unitPrice));
    } else if (_filterIndex == 4) {
      _searchProductList.sort((a, b) => a.unitPrice.compareTo(b.unitPrice));
      Iterable iterable = _searchProductList.reversed;
      _searchProductList = iterable.toList();
    }

    // List<int> ju=[];
    _selectedOptions.clear();
    OptionsList.forEach((element) {
      element.item.ttlist
          .forEach((element2) => _selectedOptions.add(element2.id));
    });

    //  _selectedOptions=ju;

    if (_selectedOptions.where((element) => element != 0).isNotEmpty) {
      _searchProductList = _searchProductList.where((element) {
        bool ifFound = false;
        element.choiceOptions.forEach((element2) {
          OptionsList.firstWhere(
                  (element) => element.name.trim() == element2.title)
              .item
              .ttlist
              .forEach((chosenelement) {
            if (chosenelement.is_selected) {
              if (chosenelement.id != 0) {
                element2.options.forEach((optionselement) {
                  if (optionselement.trim() == chosenelement.name.trim()) {
                    ifFound = true;
                  }
                });
              } else {
                ifFound = true;
              }
            }
          });
        });

        return ifFound;
      }).toList();
    }

    if (_selected_category != 0) {
      _searchProductList = _searchProductList.where((element) {
        bool ifFound = true;

        element.categoryIds.forEach((element) {
          if (element.id == _selected_category) {
            ifFound = true;
          }
        });
        return ifFound;
      }).toList();
    }
    if (_selected_brand != 0) {
      _searchProductList = _searchProductList.where((element) {
        bool ifFound = true;
        if (element.brand_id == _selected_brand) {
          ifFound = true;
        }
        return ifFound;
      }).toList();
    }

    notifyListeners();
  }

  List<Product> _searchProductList;
  List<Product> _filterProductList = [];
  bool _isClear = true;
  int offset = 1;
  String _searchText = '';
  List<Product> get searchProductList => _searchProductList;
  List<Product> get filterProductList => _filterProductList;
  bool get isClear => _isClear;
  String get searchText => _searchText;

  set searchText(String value) {
    _searchText = value;
  }

  int foundSize = 0;

  void setSearchText(String text) {
    _searchText = text;
    notifyListeners();
  }

  void cleanSearchProduct() {
    _searchProductList = [];
    _filterProductList = [];
    _isClear = true;
    _searchText = '';
    notifyListeners();
  }

  void cleanBroduct() {
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
        offset: offset);


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

  void selectAttribute(String category, String attribute) {


    if(_selectedAttributes[category].where((element) => element==attribute).isEmpty){
      _selectedAttributes[category].add(attribute);
      notifyListeners();

    }

  }

  void deselectAttribute(String category, String attribute) {
    if(_selectedAttributes[category].where((element) => element==attribute).isNotEmpty){
      _selectedAttributes[category]?.remove(attribute);
      notifyListeners();
    }

  }


  void fetchMore(BuildContext context, {Function onNoMoreProducts}) async {
    offset += 1;
    search(context,reload: false);

  }
  final TextEditingController searchController = TextEditingController();

  bool switchStatus=false;
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();


  setSearch(bool value){
    switchStatus=value;
    notifyListeners();
  }
  List<String> getPriceFiler(){
    List<String> _temp=[];
    if(switchStatus){
      _temp=[minPriceController.text.trim(),maxPriceController.text.trim()];
    }
    return _temp;
  }

  clearFilters(){
    switchStatus=false;
    searchController.clear();
    minPriceController.clear();
    maxPriceController.clear();
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
