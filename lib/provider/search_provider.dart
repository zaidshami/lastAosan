import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/model/response/base/api_response.dart';
import '../../../../data/model/response/product_model.dart';
import '../../../../data/repository/search_repo.dart';
import '../../../../helper/api_checker.dart';
import '../data/model/SearchListModels/BrandSearchListModel.dart';
import '../data/model/SearchListModels/CategorySeachListModel.dart';
import '../data/model/SearchListModels/OptionsSearchListModel.dart';
import '../data/model/SearchListModels/SearchListModel.dart';
import '../data/model/response/category.dart';
import '../utill/app_constants.dart';
import '../view/screen/search/widget/OptionsItemWidget.dart';
import 'brand_provider.dart';
import 'category_provider.dart';

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

  Map<String, List<String>> _OptionsList = {};
  List<OptionsSearchListModel<OptionsSearch>> OptionsList = [];

  int get _selected_brand =>
      brand_search_list.where((element) => element.is_selected).first.id;
  int get _selected_category =>
      category_search_list.where((element) => element.is_selected).first.id;
  List<int> _selectedOptions = [];

  void init_lists(
      List<CatageorySearch> cat_list, List<BrandSearch> brand_list) {
    add_to_search_list(CategorySearchListModel<CatageorySearch>(),
        _category_search_list, cat_list);
    add_to_search_list(
        BrandSearchListModel<BrandSearch>(), _brand_search_list, brand_list);
  }

  void insert_catagory_list(List<CatageorySearch> list) {}

  void insert_brand_list(List<BrandSearch> list) {}

  void add_to_search_list(MainSearchModel mainSearchModel,
      List<MainSearchModel> search_list, List<SearchRequerments> typelist) {
    if (mainSearchModel.insert_to_list(typelist, search_list)) {
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

      // case OptionsSearchListModel:
      //   return OptionsList;
      //   break;

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
  List<String> _searchOptions = [];
  List<String> _searchCategories = [];
  List<String> _searchBrands = [];
  List<double> _searchPriceRange = [];
  List<String> _searchSizes = [];
  List<String> _searchColors = [];
  List<double> _searchDiscount = [];
  List<Product> get searchProductList => _searchProductList;
  List<Product> get filterProductList => _filterProductList;
  bool get isClear => _isClear;
  String get searchText => _searchText;
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

  //todo: add a var in the declartion of this function to  make the _searchProductList = null only at the first time
  void searchProduct(String query, BuildContext context,
      {Function onNoMoreProducts, bool reload = true}) async {
    _isLoading = true;
    notifyListeners();
    _searchText = query;
    _isClear = false;

    // Do not reset the _searchProductList here
    reload ? _searchProductList = [] : null;
    reload ? _filterProductList = [] : null;
    reload ? offset = 1 : null;

    notifyListeners();

    ApiResponse apiResponse = await searchRepo.getSearchProductList(
        name: _searchText,
        option: _searchOptions,
        category: _searchCategories,
        brand: _searchBrands,
        price: _searchPriceRange,
        size: _searchSizes,
        color: _searchColors,
        discount: _searchDiscount,
        offset: offset);

    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      // Extract the new products from the response
      List<Product> newProducts =
          ProductModel.fromJson(apiResponse.response.data).products;
      foundSize = ProductModel.fromJson(apiResponse.response.data).totalSize;

      // Check if the query is not empty before adding new products
      if (!query.isEmpty) {
        if (newProducts.isEmpty && onNoMoreProducts != null) {
          onNoMoreProducts();
        } else {
          _searchProductList.addAll(newProducts);
          _filterProductList.addAll(newProducts);

          // After new data is added, sort the product list based on the current filter index.
          sortSearchList(0, 0,
              isPrice: false); // Consider changing the parameters as needed.
        }
        //       else {
        //         _searchProductList.addAll(newProducts);
        //         try {
        // _filterProductList.addAll(newProducts);
        //         } catch (e, s) {
        //
        //
        //         }
        //       }
      }
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    _isLoading = false;

    notifyListeners();
  }

  void newSearchProduct(
      String query,
      List<String> selectedOptions,
      List<String> selectedCategories,
      List<String> selectedBrands,
      List<double> selectedPrices,
      List<String> selectedSizes,
      List<String> selectedColors,
      List<double> selectedDiscounts,
      BuildContext context,
      {Function onNoMoreProducts,
      bool reload = true}) async {
    _isLoading = true;
    notifyListeners();
    _searchText = query;
    _isClear = false;

    // Do not reset the _searchProductList here
    reload ? _searchProductList = [] : null;
    reload ? _filterProductList = [] : null;
    reload ? offset = 1 : null;

    notifyListeners();

    ApiResponse apiResponse = await searchRepo.getSearchProductList(
        name: _searchText,
        option: selectedOptions,
        category: selectedCategories,
        brand: selectedBrands,
        price: selectedPrices,
        size: selectedSizes,
        color: selectedColors,
        discount: selectedDiscounts,
        offset: offset);

    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      // Extract the new products from the response
      List<Product> newProducts =
          ProductModel.fromJson(apiResponse.response.data).products;
      foundSize = ProductModel.fromJson(apiResponse.response.data).totalSize;

      // Check if the query is not empty before adding new products
      if (!query.isEmpty) {
        if (newProducts.isEmpty && onNoMoreProducts != null) {
          onNoMoreProducts();
        } else {
          _searchProductList.addAll(newProducts);
          _filterProductList.addAll(newProducts);

          // After new data is added, sort the product list based on the current filter index.
          sortSearchList(0, 0,
              isPrice: false); // Consider changing the parameters as needed.
        }
      }
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    _isLoading = false;

    notifyListeners();
  }
  Map<String, List<String>> _selectedAttributes = {};

  Map<String, List<String>> get selectedAttributes => _selectedAttributes;

  void selectAttribute(String category, String attribute) {
    _selectedAttributes[category] = _selectedAttributes[category] ?? [];
    if (!_selectedAttributes[category].contains(attribute)) {
      _selectedAttributes[category].add(attribute);
    }
    notifyListeners();
  }

  void deselectAttribute(String category, String attribute) {
    _selectedAttributes[category]?.remove(attribute);
    notifyListeners();
  }

/*
  void searchProduct(String query, BuildContext context) async {
    _searchText = query;
    _isClear = false;
    _searchProductList = null;
    _filterProductList = null;
    notifyListeners();

    ApiResponse apiResponse = await searchRepo.getSearchProductList(name:query,option: _searchOptions,category: _searchCategories,
        brand: _searchBrands,price: _searchPriceRange,size: _searchSizes,color: _searchColors,discount: _searchDiscount,offset: offset);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {

      if (query.isEmpty) {
        _searchProductList = [];
      } else {
        List<Product> productsList=[];
        List<Product> _tempList=ProductModel.fromJson(apiResponse.response.data).products;
        if(_selected_category!=0||_selected_brand!=0){
          if(_selected_category!=0) {
            productsList = _tempList.where((element) {
              bool is_found=false;
              element.categoryIds.forEach((element2) {
                if(element2.id==_selected_category) {
                  is_found = true;
                }
              });
              return is_found;
            }).toList();
          }else{
            productsList = _tempList;
          }

          if(_selected_brand!=0) {
            productsList = productsList.where((element) {
              bool is_found=false;
              if(element.brand_id==_selected_brand){is_found = true;}
              return is_found;
            }).toList();
          }
        }else{
          productsList = _tempList;

        }


        _searchProductList = [];
        _searchProductList.addAll(productsList);
        _filterProductList = [];
        _filterProductList.addAll(productsList);
        _OptionsList=list_without_deplucate(_filterProductList);
        List<OptionsSearchListModel> list=[];
        int firstId=1;


        _OptionsList.forEach((key, value) {
          List<OptionsSearchListModel> tempList=[];
          tempList.add(OptionsSearchListModel(is_selected: true,name: "الكل",id:0 ));
          int secondId=1;


          value.forEach((element) {

            tempList.add(OptionsSearchListModel(is_selected: false,name: element,id:secondId ));
            secondId++;

          });
          list.add(OptionsSearchListModel(name:key,item:OptionsSearch(tempList,key,firstId),id: firstId ));
          firstId++;
        });
        list.length>OptionsList.length?OptionsList=list:"";

      }
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }*/
  void fetchMore(BuildContext context, {Function onNoMoreProducts}) async {
    offset += 1;
    searchProduct(_searchText, context,
        onNoMoreProducts: onNoMoreProducts, reload: false);
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
