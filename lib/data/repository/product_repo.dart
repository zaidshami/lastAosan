import 'package:flutter/material.dart';
import '../../../../data/datasource/remote/dio/dio_client.dart';
import '../../../../data/datasource/remote/exception/api_error_handler.dart';
import '../../../../data/model/response/base/api_response.dart';
import '../../../../helper/product_type.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/app_constants.dart';

class ProductRepo {
  final DioClient dioClient;
  ProductRepo({@required this.dioClient});
///the orginal getllatest prducts  of 6 vally
//
  Future<ApiResponse> getLatestProductListO(BuildContext context, String offset, ProductType productType, String title) async {
    String endUrl;

    if(productType == ProductType.BEST_SELLING){
      endUrl = AppConstants.BEST_SELLING_PRODUCTS_URI;
      title = getTranslated('best_selling', context);
    }
    else if(productType == ProductType.NEW_ARRIVAL){
      endUrl = AppConstants.NEW_ARRIVAL_PRODUCTS_URI;
      title = getTranslated('new_arrival',context);
    }
    else if(productType == ProductType.TOP_PRODUCT){
      endUrl = AppConstants.TOP_PRODUCTS_URI;
      title = getTranslated('top_product', context);
    }else if(productType == ProductType.DISCOUNTED_PRODUCT){
      endUrl = AppConstants.DISCOUNTED_PRODUCTS_URI;
      title = getTranslated('discounted_product', context);
    }

    try {
      final response = await dioClient.get(
          endUrl+offset);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  Future<ApiResponse> getLatestProductList(int id,BuildContext context, String offset, ProductType productType, String title) async {
    String endUrl;
    Map<String,dynamic> test={'limit':10,'offset':offset,'category_id':id};
    if(productType == ProductType.BEST_SELLING){
      endUrl = AppConstants.BEST_SELLING_PRODUCTS_URI;
       test={'limit':null,'offset':null , 'category_id':id};
      title = getTranslated('best_selling', context);
    }
    else if(productType == ProductType.NEW_ARRIVAL){
      endUrl = AppConstants.NEW_ARRIVAL_PRODUCTS_URI;
      title = getTranslated('new_arrival',context);
    test={'limit':'10','offset':offset, 'category_id': id};
    }
    else if(productType == ProductType.TOP_PRODUCT){
      endUrl = AppConstants.TOP_PRODUCTS_URI;
      title = getTranslated('top_product', context);
      test={'limit':'10','offset':offset, 'category_id': id};

    }else if(productType == ProductType.DISCOUNTED_PRODUCT){
      endUrl = AppConstants.DISCOUNTED_PRODUCTS_URI;
      title = getTranslated('discounted_product', context);
     // test={'limit':null,'offset':null, 'category_id': id};

    }

    try {
      final response = await dioClient.get(
          endUrl,queryParameters: test);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getLatestProductList1(int id,BuildContext context, int offset, ProductType productType, String title) async {
    String endUrl;
    Map<String,dynamic> test={'limit':10,'offset':offset,'category_id':id};
    if(productType == ProductType.BEST_SELLING){
      endUrl = AppConstants.BEST_SELLING_PRODUCTS_URI;
      test={'limit':'10','offset':1,'category_id': id};
      title = getTranslated('best_selling', context);
    }
    else if(productType == ProductType.NEW_ARRIVAL){
      endUrl = AppConstants.NEW_ARRIVAL_PRODUCTS_URI;
      title = getTranslated('new_arrival',context);

    }
    else if(productType == ProductType.TOP_PRODUCT){
      endUrl = AppConstants.TOP_PRODUCTS_URI;
      test={'limit':'10','offset':1,'category_id': id};
      title = getTranslated('top_product', context);
    }else if(productType == ProductType.DISCOUNTED_PRODUCT){
      endUrl = AppConstants.DISCOUNTED_PRODUCTS_URI;
      title = getTranslated('discounted_product', context);
     // test={'limit':null,'offset':null, 'category_id': id};

    }

    try {
      final response = await dioClient.get(
          endUrl,queryParameters: test);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  //Seller Products
  Future<ApiResponse> getSellerProductList(String sellerId, String offset) async {
    try {
      final response = await dioClient.get(
          AppConstants.SELLER_PRODUCT_URI+sellerId+'/products?limit=10&&offset='+offset);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getBrandOrCategoryProductList(bool isBrand, String id,int offset  ) async {
    try {
      String uri;
      Map<String,dynamic> test= { "id": id , "limit":12,"offset":offset};
      if(isBrand){
        uri = '${AppConstants.BRAND_PRODUCT_URI}$id';
      }else {
        uri = '${AppConstants.CATEGORY_PRODUCT_URI}$id';

      }
      final response = await dioClient.get(uri, queryParameters: test
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }




  Future<ApiResponse> getCategoryProductList(String id) async {
    try {
      String uri;


        uri = '${AppConstants.CATEGORY_PRODUCT_URI}$id';

      final response = await dioClient.get(uri
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> getRelatedProductList(String id) async {
    try {
      final response = await dioClient.get(
          AppConstants.RELATED_PRODUCT_URI+id);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  //todo : here is the problem of the limit of the featured products
  Future<ApiResponse> getFeaturedProductList(int id,String offset) async {
    try {
      final response = await dioClient.get(
          AppConstants.FEATURED_PRODUCTS_URI,queryParameters: {
        'limit':10,
        'offset':offset,
        'category_id':id
      });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> getLProductList(int id,String offset) async {
    try {
      final response = await dioClient.get(
          AppConstants.LATEST_PRODUCTS_URI,queryParameters: {
        'limit':10,
        'offset':offset,
        'category_id':id
      });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getRecommendedProduct() async {
    try {
      final response = await dioClient.get(AppConstants.DEAL_OF_THE_DAY_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}