import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/model/response/base/api_response.dart';
import '../../../../data/model/response/product_model.dart';
import '../../../../data/repository/product_repo.dart';
import '../../../../helper/api_checker.dart';
import '../../../../helper/product_type.dart';
import '../data/model/body/HomeListModel.dart';
import 'category_provider.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepo productRepo;

  ProductProvider({@required this.productRepo});

  // Latest products
  List<Product> _latestProductList = [];

  HomeListModel _n_lastestProductList = new HomeListModel("new_arrival");
  HomeListModel _topsaleProductList = new HomeListModel("top_product");
  HomeListModel _bestproductsProductList = new HomeListModel("best_selling");
  HomeListModel _offerProductList =  new HomeListModel("discounted_product");
  int selectedSub ;
  bool _isFiltring = false;
var _ourList ;

  set ourList(value) {
    _ourList = value;

  }
  void clearOurList() {
    _ourList = null;
    // _iscOLoading= true;
    notifyListeners();

  }
  get ourList => _ourList;

  set isFiltring(bool value) {
    _isFiltring = value;

  }

  bool get isFiltring => _isFiltring;
  List<Product> _lProductList = [];

  List<Product> get lProductList => _lProductList;
  List<Product> _featuredProductList = [];


  ProductType _productType = ProductType.NEW_ARRIVAL;
  String _title = 'xyz';

  bool _filterIsLoading = false;
  bool _filterFirstLoading = true;

  bool _isLoading = false;
  bool _iscOLoading = false;

  bool _isWish;
  bool _isFeaturedLoading = false;

  bool get isFeaturedLoading => _isFeaturedLoading;
  bool _firstFeaturedLoading = true;
  bool _firstLoading = true;
  int _latestPageSize;
  int _categPageSize;
  int _lOffset = 1;
  int   _cOffset = 1;

  int _sellerOffset = 1;
  int _lPageSize;
  int selectImageIndex = 0;
  int _qty  =1 ;

  int get lPageSize => _lPageSize;
  int get qty => _qty;
  int _featuredPageSize;
  set qty(int value) {
    _qty = value;
notifyListeners();
  }
  set qty1(int value) {
    _qty = value;

  }
  ProductType get productType => _productType;

  String get title => _title;

  bool get isWish => _isWish;

  int get lOffset => _lOffset;
  int get cOffset => _cOffset;

  int get sellerOffset => _sellerOffset;

  List<int> _offsetList = [];
  List<String> _lOffsetList = [];

  List<String> get lOffsetList => _lOffsetList;
  List<String> _featuredOffsetList = [];

  List<Product> get latestProductList => _latestProductList;

  List<Product> get featuredProductList => _featuredProductList;

  Product _recommendedProduct;

  Product get recommendedProduct => _recommendedProduct;

  bool get filterIsLoading => _filterIsLoading;

  bool get filterFirstLoading => _filterFirstLoading;

  bool get isLoading => _isLoading;
  bool get iscOLoading => _iscOLoading;

  bool get firstFeaturedLoading => _firstFeaturedLoading;

  bool get firstLoading => _firstLoading;

  int get latestPageSize => _latestPageSize;
  int get categPageSize => _categPageSize;

  int get featuredPageSize => _featuredPageSize;



HomeListModel get_list_type(
    ProductType value){

  if (value == ProductType.NEW_ARRIVAL) {

    return _n_lastestProductList;

  } else if (value == ProductType.TOP_PRODUCT) {

      return _topsaleProductList;

  } else if (value == ProductType.BEST_SELLING) {

      return _bestproductsProductList;

  } else if (value == ProductType.DISCOUNTED_PRODUCT) {

      return _offerProductList;

  }else{
    return _n_lastestProductList;

  }

}
  //new home products
  Future<void> getHomeProductList(ProductType productType,
      int id,int offset, BuildContext context,
      {bool reload = false}) async {
    if (reload) {
     _offsetList = [];
      get_list_type(productType).ProductList = [];
    }
    get_list_type(productType).lOffset = offset;
    if (!_offsetList.contains(offset)) {
      _offsetList.add(offset);
      ApiResponse apiResponse = await productRepo.getLatestProductList(
          id,
          context, offset.toString(), productType, get_list_type(productType).title);
      if (apiResponse.response != null &&
          apiResponse.response.statusCode == 200) {
        get_list_type(productType).ProductList.addAll(ProductModel
            .fromJson(apiResponse.response.data)
            .products);
        get_list_type(productType).latestPageSize = ProductModel
            .fromJson(apiResponse.response.data)
            .totalSize;
        get_list_type(productType).filterFirstLoading = false;
        get_list_type(productType).filterIsLoading = false;
      } else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    } else {
      if (get_list_type(productType).filterIsLoading) {
        get_list_type(productType).filterIsLoading = false;
        notifyListeners();
      }
    }
  }

  //latest product
  Future<void> getLatestProductList(int id,int offset, BuildContext context,
      {bool reload = false}) async {
    if (reload) {
      _offsetList = [];
      _latestProductList = [];
    }
    _lOffset = offset;
    if (!_offsetList.contains(offset)) {
      _offsetList.add(offset);
      ApiResponse apiResponse = await productRepo.getLatestProductList1(
        id,
          context, offset, productType, title);
      if (apiResponse.response != null &&
          apiResponse.response.statusCode == 200) {
        _latestProductList.addAll(ProductModel
            .fromJson(apiResponse.response.data)
            .products);
        _latestPageSize = ProductModel
            .fromJson(apiResponse.response.data)
            .totalSize;
        _filterFirstLoading = false;
        _filterIsLoading = false;
      } else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    } else {
      if (_filterIsLoading) {
        _filterIsLoading = false;
        notifyListeners();
      }
    }
  }

  //latest product
  Future<void> getLProductList(int id,String offset, BuildContext context,
      {bool reload = false}) async {
    if (reload) {
      _lOffsetList = [];
      _lProductList = [];
    }
    if (!_lOffsetList.contains(offset)) {
      _lOffsetList.add(offset);
      ApiResponse apiResponse = await productRepo.getLProductList(id,offset);
      if (apiResponse.response != null &&
          apiResponse.response.statusCode == 200) {
        _lProductList.addAll(ProductModel
            .fromJson(apiResponse.response.data)
            .products);
        _lPageSize = ProductModel
            .fromJson(apiResponse.response.data)
            .totalSize;
        _firstLoading = false;
        _isLoading = false;
      } else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    } else {
      if (_isLoading) {
        _isLoading = false;
        notifyListeners();
      }
    }
  }


  Future<int> getLatestOffset(BuildContext context) async {
    ApiResponse apiResponse = await productRepo.getLatestProductList1(

        Provider.of<CategoryProvider>(context).categoryList[Provider.of<CategoryProvider>(context).categorySelectedIndex].id, context, 1, productType, title);
      //  Provider.of<CategoryProvider>(context).categoryList[Provider.of<CategoryProvider>(context).categorySelectedIndex].id, context, '1', productType, title);
    return ProductModel
        .fromJson(apiResponse.response.data)
        .totalSize;
  }

  void changeTypeOfProduct(ProductType type, String title) {
    _productType = type;
    _title = title;
    _latestProductList = null;
    _latestPageSize = 0;
    _filterFirstLoading = true;
    _filterIsLoading = true;
    notifyListeners();
  }
  void HomeshowBottomLoader(ProductType productType) {
    get_list_type(productType).isLoading = true;
    get_list_type(productType).filterIsLoading = true;
    notifyListeners();
  }
  void showBottomLoader() {
    _isLoading = true;
    _filterIsLoading = true;
    notifyListeners();
  }

  void removeFirstLoading() {
    _firstLoading = true;
    notifyListeners();
  }

  // Seller products
  List<Product> _sellerAllProductList = [];
  List<Product> _sellerProductList = [];
  int _sellerPageSize;

  List<Product> get sellerProductList => _sellerProductList;

  int get sellerPageSize => _sellerPageSize;

  void initSellerProductList(String sellerId, int offset, BuildContext context,
      {bool reload = false}) async {
    _firstLoading = true;
    if (reload) {
      _offsetList = [];
      _sellerProductList = [];
    }
    _sellerOffset = offset;

    ApiResponse apiResponse = await productRepo.getSellerProductList(
        sellerId, offset.toString());
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      _sellerProductList = [];
      _sellerProductList.addAll(ProductModel
          .fromJson(apiResponse.response.data)
          .products);
      _sellerAllProductList.addAll(ProductModel
          .fromJson(apiResponse.response.data)
          .products);
      _sellerPageSize = ProductModel
          .fromJson(apiResponse.response.data)
          .totalSize;
      _firstLoading = false;
      _filterIsLoading = false;
      _isLoading = false;
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }
  Product product;
  void filterData(String newText) {
    _sellerProductList.clear();
    if (newText.isNotEmpty) {
      _sellerAllProductList.forEach((product) {
        if (product.name.toLowerCase().contains(newText.toLowerCase())) {
          _sellerProductList.add(product);
        }
      });
    } else {
      _sellerProductList.clear();
      _sellerProductList.addAll(_sellerAllProductList);
    }
    notifyListeners();
  }

  void clearSellerData() {
    _sellerProductList = [];
    //notifyListeners();
  }

  // Brand and category products

  bool _hasData=false;

  List<Product> get brandOrCategoryProductList => _brandOrCategoryProductList;
  List<Product> get brandOrCategoryProductListWith50Disc => _brandOrCategoryProductListWith50Disc;

  bool get hasData => _hasData;
setcatsloading(){
  _iscOLoading=true;
notifyListeners();
}
  List<Product> _brandOrCategoryProductList = [];
  List<Product> _brandOrCategoryProductListWith50Disc = [];
  // void cleanBrandCategoryProductLIst() {
  //   _brandOrCategoryProductList = [];
  //   notifyListeners();
  // }

  void initBrandOrCategoryProductList(bool isBrand, String id, BuildContext context, int offset, {bool reload = true}) async {
    if (reload) {
      _brandOrCategoryProductList.clear();
      _brandOrCategoryProductListWith50Disc.clear();

    }

    _hasData = true;
    _cOffset = offset;

    ApiResponse apiResponse = await productRepo.getBrandOrCategoryProductList(isBrand, id, cOffset);
    _iscOLoading = false;

    if (/*apiResponse.response != null &&*/ apiResponse.response.statusCode == 200) {
      _brandOrCategoryProductList.addAll(ProductModel.fromJson(apiResponse.response.data).products);

      for (Product product in _brandOrCategoryProductList) {
        if (product.discountType == "percent" && product.discount == 50) {
          _brandOrCategoryProductListWith50Disc.add(product); // Add the product to the discount list
        }
      }

      _hasData = _brandOrCategoryProductList.length > 1;

    } else {
      ApiChecker.checkApi(context, apiResponse);
    }

    notifyListeners();
  }

  // Related products
  List<Product> _relatedProductList;

  List<Product> get relatedProductList => _relatedProductList;

  void initRelatedProductList(String id, BuildContext context) async {
    ApiResponse apiResponse = await productRepo.getRelatedProductList(id);
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      _relatedProductList = [];
      apiResponse.response.data.forEach((product) =>
          _relatedProductList.add(Product.fromJson(product)));
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  void removePrevRelatedProduct() {
    _relatedProductList = null;
  }

  //featured product
  Future<void> getFeaturedProductList(int id,String offset, BuildContext context,
      {bool reload = false}) async {
    if (reload) {
      _featuredOffsetList = [];
      _featuredProductList = [];
    }
    if (!_featuredOffsetList.contains(offset)) {
      _featuredOffsetList.add(offset);
      ApiResponse apiResponse = await productRepo.getFeaturedProductList(id,
          offset);
      if (apiResponse.response != null &&
          apiResponse.response.statusCode == 200) {
        _featuredProductList.addAll(ProductModel
            .fromJson(apiResponse.response.data)
            .products);
        _featuredPageSize = ProductModel
            .fromJson(apiResponse.response.data)
            .totalSize;
        _firstFeaturedLoading = false;
        _isFeaturedLoading = false;
      } else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    } else {
      if (_isFeaturedLoading) {
        _isFeaturedLoading = false;
        notifyListeners();
      }
    }
  }

  void setImageSliderSelectedIndex(int selectedIndex) {
    selectImageIndex = selectedIndex;
    notifyListeners();
  }



  Future<void> getRecommendedProduct(BuildContext context) async {
    ApiResponse apiResponse = await productRepo.getRecommendedProduct();
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      _recommendedProduct = Product.fromJson(apiResponse.response.data);
      // print('=rex===>${recommendedProduct.toJson()}');
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }
}
