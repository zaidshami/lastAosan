import 'dart:io';

import 'package:flutter/material.dart';
import '../../../../data/model/body/review_body.dart';
import '../../../../data/model/response/base/api_response.dart';
import '../../../../data/model/response/product_model.dart';
import '../../../../data/model/response/response_model.dart';
import '../../../../data/model/response/review_model.dart';
import '../../../../data/repository/product_details_repo.dart';
import '../../../../helper/api_checker.dart';
import '../../../../provider/banner_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../data/model/response/cart_model.dart';

class ProductDetailsProvider extends ChangeNotifier {
  final ProductDetailsRepo productDetailsRepo;
  ProductDetailsProvider({@required this.productDetailsRepo});

  String _radioValue = "initial value";
  bool  _isRadioSelected ;

  bool get isRadioSelected => _radioValue == "radio value";
  Size dropdownValue;
  Size dropdownValue1;
  List<ReviewModel> _reviewList;
  int _imageSliderIndex;
  bool _wish = false;
  int _quantity = 0;
  int variantIndex;
  List<int> _variationIndex;
  int _rating = 0;
  bool _isLoading = false;
  int _orderCount;
  int _wishCount;
  String _sharableLink;
  String _errorText;
  bool _hasConnection = true;
  String selectedSizeCode;
  List<ReviewModel> get reviewList => _reviewList;
  int get imageSliderIndex => _imageSliderIndex;
  bool get isWished => _wish;
  int get quantity => _quantity;
 // int get variantIndex => _variantIndex;
  List<int> get variationIndex => _variationIndex;
  int get rating => _rating;
  bool get isLoading => _isLoading;
  int get orderCount => _orderCount;
  int get wishCount => _wishCount;
  String get sharableLink => _sharableLink;
  String get radioValue => _radioValue;
  String get errorText => _errorText;
  bool get hasConnection => _hasConnection;
  // String get selectedSizeCode=>_selectedSizeCode;


     int get stock=> stock ;
  set radioValue(String newValue) {

      _radioValue = newValue;
   notifyListeners();
  }
  set isRadioSelected(bool value) {
    _isRadioSelected = value;
    notifyListeners(); // Notify listeners to rebuild UI with the updated value
  }


  VariationModel  variationModel(Product product,Size size){

    VariationModel _temp=VariationModel(product_color: "",product_size: "");
    if(product.productType==ProductVarType.productWithColor){

      _temp=VariationModel(product_color:  product.productColorsList[variantIndex].code,product_size: "");
    }
    if(product.productType==ProductVarType.productWithColorSize){
      print("from Provider "+ size.code);

  print("from Provider "+ size.code);
  _temp=VariationModel(product_color:product.productsizelist[variantIndex].code, product_size:  size.id);



    }
    return _temp;
  }


  List<String> imagesList(Product product){
    List<String> _temp=[];
    if(product.productType==ProductVarType.productNormal){


      product.images.forEach((element) {
        // element.forEach((element) {
          _temp.add(element);
          // print("zzz $element");
        // });
      });
    }

    if(product.productType==ProductVarType.productWithColor){
      product.productColorsList[variantIndex].images.forEach((element) {
        _temp.add(element);
      });

    }

    if(product.productType==ProductVarType.productWithColorSize){
      product.productsizelist[variantIndex].images.forEach((element) {
        _temp.add(element);
      });

    }
    return _temp;

  }
  int  sizeStoke(List<Size> size){
    int _tem=1;
    if(selectedSizeCode!=""){
      print("the quann ${size.where((element) => element.code==selectedSizeCode).first.qunt}");
      _tem= int.parse(size.where((element) => element.code==selectedSizeCode).first.qunt);
    }
    return _tem;
  }
  Future<void> initProduct(Product product, BuildContext context) async {
    _hasConnection = true;
    variantIndex = 0;
    _quantity = 1;
    ApiResponse reviewResponse = await productDetailsRepo.getReviews(product.id.toString());
    if (reviewResponse.response != null && reviewResponse.response.statusCode == 200) {
      Provider.of<BannerProvider>(context,listen: false).getProductDetails(context, product.slug.toString());
      _reviewList = [];
      reviewResponse.response.data.forEach((reviewModel) => _reviewList.add(ReviewModel.fromJson(reviewModel)));
      _imageSliderIndex = 0;
      _quantity = 1;
    } else {
      ApiChecker.checkApi(context, reviewResponse);
      if(reviewResponse.error.toString() == 'Connection to API server failed due to internet connection') {
        _hasConnection = false;
      }
    }
    notifyListeners();
  }


  void initData(Product product) {
    //  _variantIndex = 0;
   // _quantity = 1;
    _variationIndex = [];
    selectedSizeCode="";
    product.choiceOptions.forEach((element) => _variationIndex.add(0));

  }

  void removePrevReview() {
    _reviewList = null;
    _sharableLink = null;
  }

  void getCount(String productID, BuildContext context) async {
    ApiResponse apiResponse = await productDetailsRepo.getCount(productID);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _orderCount = apiResponse.response.data['order_count'];
      _wishCount = apiResponse.response.data['wishlist_count'];
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  void getSharableLink(String productID, BuildContext context) async {
    ApiResponse apiResponse = await productDetailsRepo.getSharableLink(productID);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _sharableLink = apiResponse.response.data;
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
  }

  void setErrorText(String error) {
    _errorText = error;
    notifyListeners();
  }

  void removeData() {
    _errorText = null;
    _rating = 0;
    notifyListeners();
  }

  void setsize(String code){
    _quantity = 1;


    selectedSizeCode=code;
/// zaid
     notifyListeners();

  }
  void setImageSliderSelectedIndex(int selectedIndex) {

    _imageSliderIndex = selectedIndex;
    notifyListeners();
  }

 void setImageSliderSelectedIndex1(int selectedIndex) {

    _imageSliderIndex = selectedIndex;

  }
  void setImageSliderSelectedIndexZero() {

    _imageSliderIndex = 0;


  }

  void changeWish() {
    _wish = !_wish;
    notifyListeners();
  }

  void setQuantity(int value) {
    _quantity = value;
    notifyListeners();
  }
int qStock =1 ;
  void setCartVariantIndex(int index,{bool withRefresh=true}) {
    //_selectedSizeCode="";
    // _imageSliderIndex=0;
    qStock = index;
    variantIndex = index;
    _quantity = 1;
    withRefresh?
    notifyListeners():null;
  }

  void setCartVariationIndex(int index, int i) {
    _variationIndex[index] = i;
    _quantity = 1;
    notifyListeners();
  }

  void setRating(int rate) {
    _rating = rate;
    notifyListeners();
  }

  Future<ResponseModel> submitReview(ReviewBody reviewBody, List<File> files, String token) async {
    _isLoading = true;
    notifyListeners();

    http.StreamedResponse response = await productDetailsRepo.submitReview(reviewBody, files, token);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      _rating = 0;
      responseModel = ResponseModel('Review submitted successfully', true);
      _errorText = null;
      notifyListeners();
    } else {
      // print('${response.statusCode} ${response.reasonPhrase}');
      responseModel = ResponseModel('${response.statusCode} ${response.reasonPhrase}', false);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }
}
