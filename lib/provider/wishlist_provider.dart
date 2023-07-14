import 'package:flutter/material.dart';
import '../../../../data/model/response/base/api_response.dart';
import '../../../../data/model/response/product_model.dart';
import '../../../../data/model/response/wishlist_model.dart';
import '../../../../data/repository/product_details_repo.dart';
import '../../../../data/repository/wishlist_repo.dart';
import '../../../../helper/api_checker.dart';

class WishListProvider extends ChangeNotifier {
  final WishListRepo wishListRepo;
  final ProductDetailsRepo productDetailsRepo;

  WishListProvider(
      {@required this.wishListRepo, @required this.productDetailsRepo});

  bool _wish = false;
  String _searchText = "";
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool get isWish => _wish;


  String get searchText => _searchText;

  clearSearchText() {
    _searchText = '';
    notifyListeners();
  }

  List<Product> _wishList;
  List<Product> _allWishList;

  List<Product> get wishList => _wishList;

  List<Product> get allWishList => _allWishList;

  void searchWishList(String query) async {
    _wishList = [];
    _searchText = query;

    if (query.isNotEmpty) {
      List<Product> products = _allWishList.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
      _wishList.addAll(products);
    } else {
      _wishList.addAll(_allWishList);
    }
    notifyListeners();
  }

  void addWishList(Product product, {Function feedbackMessage}) async {
    ApiResponse apiResponse = await wishListRepo.addWishList(product.id);
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      Map map = apiResponse.response.data;
      String message = map['message'];
      feedbackMessage(message);
      _wish = true;
      _wishList.add(product);
      _allWishList.add(product);
      notifyListeners();
    } else {
      _wish = false;
      feedbackMessage('${apiResponse.error.toString()}');
    }
    notifyListeners();
  }

  void removeWishList(Product product,
      {Function feedbackMessage}) async {
    ApiResponse apiResponse = await wishListRepo.removeWishList(product.id);
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      Map map = apiResponse.response.data;
      String message = map['message'];
      feedbackMessage(message);
      _wishList.remove(product);
      _allWishList.remove(product);
      notifyListeners();
    } else {
      feedbackMessage('${apiResponse.error.toString()}');
    }
    notifyListeners();
  }

  Future<void> initWishList(BuildContext context, String languageCode) async {
    _isLoading = true;
    ApiResponse apiResponse = await wishListRepo.getWishList();
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      _wishList = [];
      _allWishList = [];
      for (int i = 0; i < apiResponse.response.data.length; i++) {
        ApiResponse productResponse = await productDetailsRepo.getProduct(
          WishListModel
              .fromJson(apiResponse.response.data[i])
              .product
              .slug
              .toString(), languageCode,
        );
        if (productResponse.response != null &&
            productResponse.response.statusCode == 200) {
          Product _product = Product.fromJson(productResponse.response.data);
          _wishList.add(_product);
          _allWishList.add(_product);
          notifyListeners();
        } else {
          ApiChecker.checkApi(context, productResponse);
        }
      }
      if (apiResponse.response.data.length > 0) {
        notifyListeners();
      }
    } else {
      notifyListeners();
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
    _isLoading = false;
  }


  bool checkWishList(int productId) {
    return _allWishList != null ?
    _allWishList
        .where((element) => element.id == productId)
        .isNotEmpty : false;
  }
}



