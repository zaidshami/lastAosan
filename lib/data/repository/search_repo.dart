
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../../../../data/datasource/remote/dio/dio_client.dart';
import '../../../../data/datasource/remote/exception/api_error_handler.dart';
import '../../../../data/model/response/base/api_response.dart';
import '../../../../utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/response/cart_model.dart';
import '../model/response/filter_category_1.dart';


List<Map<String,dynamic>> test(List<Selected> atts){
  List<Map<String,dynamic>>  _temp=[];
  atts.forEach((element) {
    _temp.add(element.tojson());
  });
  return _temp;

}
class SearchRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  final Logger logger = Logger();

  SearchRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> getSearchProductList({
    String name,
  List<String> option,
    List<Selected> atts,
    // List<String> category,
    // List<String> brand,
    // List<String> price,
    // List<String> size,
    // List<String> color,
    // List<double> discount,
    int offset,
  }) async {
    print("cczzzz ${test(atts)}");
    try {
      List jsonList = [];
      jsonList.add(atts[0].tojson().toString());
      // atts.map((item) => jsonList.add(item.tojson().toString())).toList();

      final Map<String, dynamic> queryParameters = {
        'name': name??'',
        // 'option': jsonEncode(option?? []),
        // 'category': jsonEncode(category ?? []),
        // 'brand': jsonEncode(brand ?? []),
        // 'price': jsonEncode(price ?? []),
        // 'size': jsonEncode(size ?? []),
        // 'color': jsonEncode(color ?? []),
        // 'discount': jsonEncode(discount ?? []),
    // 'filter':jsonEncode(test(atts)),
     'filter':jsonList,

        'offset': offset ?? 1,
        'limit': 10
      };
      logger.d('zxxx: $queryParameters');

      final response = await dioClient.post(
        AppConstants.SEARCH_URI,
        // queryParameters: queryParameters,
        data: queryParameters
      );
      print("search result "+response.statusCode.toString());
      print("search result "+response.data.toString());

      logger.d("zxxxxx: " + response.data.toString());

      return ApiResponse.withSuccess(response);
    } catch (e) {
      print("search result error "+e.toString());
      print("search result error "+ApiResponse.withError(ApiErrorHandler.getMessage(e)).toString());

      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  /* Future<ApiResponse> getSearchProductList(String query,List<String> option,List<String> category,List<String> brand,List<double> price,
      List<String> size,List<String> color,List<double> discount,int offset) async {
    try {
      final response = await dioClient.get(AppConstants.SEARCH_URI ,
      queryParameters:

      {
        'name':   "\"$query\"",
        'option':[],
        'category':[],
        'brand':[],
        'price':[1000,1200],
         // 'limit':10,
        'size': [],
        'color':[],
        'discount':[],

        'offset':1
      });
      print("zzxxxx "+response.data.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
*/
  Future<ApiResponse> addToCartListData1(CartModel cart) async {
    Map<String, dynamic> _choice = Map();
    //   for(int index=0; index<choiceOptions.length; index++){
    // //    _choice.addAll({choiceOptions[index].name: choiceOptions[index].options[variationIndexes[index]]});
    //   }
    Map<String, dynamic> _data =cart.variationModel.toJson(cart.id.toString(), cart.quantity.toString());

    // {'id': cart.id,
    //   /*'variant': cart.variation != null ? cart.variation.type : null,*/
    //   'quantity': cart.quantity};


    //_data.addAll(_choice);
    // if(cart.variant.isNotEmpty) {
    //   _data.addAll({'color': cart.color});
    // }

    try {
      final response = await dioClient.post(
        AppConstants.ADD_TO_CART_URI,
        data: _data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  // for save home address
  Future<void> saveSearchAddress(String searchAddress) async {
    try {
      List<String> searchKeywordList = sharedPreferences.getStringList(AppConstants.SEARCH_ADDRESS);
      if (!searchKeywordList.contains(searchAddress)) {
        searchKeywordList.add(searchAddress);
      }
      await sharedPreferences.setStringList(AppConstants.SEARCH_ADDRESS, searchKeywordList);
    } catch (e) {
      throw e;
    }
  }

  List<String> getSearchAddress() {
    return sharedPreferences.getStringList(AppConstants.SEARCH_ADDRESS) ?? [];
  }

  Future<bool> clearSearchAddress() async {

    return sharedPreferences.setStringList(AppConstants.SEARCH_ADDRESS, []);


  }
}
