
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../../../../data/datasource/remote/dio/dio_client.dart';
import '../../../../data/datasource/remote/exception/api_error_handler.dart';
import '../../../../data/model/response/base/api_response.dart';
import '../../../../utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/response/cart_model.dart';
import '../model/response/filter_category_1.dart';


List<Map<String, dynamic>> test(List<Selected> atts){
  List<Map<String, dynamic>> _temp = [];
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
    List<Selected> atts,
    int offset,
    int sort,
  }) async {
    print("cczzzz ${test(atts)}");
    try {
      // We're taking all the Selected objects from atts and converting them to JSON.
      // List jsonList = atts.map((item) => item.tojson()).toList();
// We're taking all the Slec
      final Map<String, dynamic> queryParameters = {
        'name': jsonEncode(name??''),
        'filter':  jsonEncode(test(atts)),
        'offset': offset ?? 1,
        'limit': 10,
        'sort':sort??1,
      };


      logger.d('zxxx: $queryParameters');
      //[{"id":"1","selected":["176","179"]},{"id":"3","selected":["9"]},{"id":"81","selected":["XL"]},{"id":"0","selected":["Olive"]}]
      //[{"id":"77","selected":[]},{"id":"78","selected":[]},{"id":"80","selected":[]},{"id":"81","selected":[]},{"id":"83","selected":[]},{"id":"85","selected":[]},{"id":"86","selected":[]},{"id":"0","selected":[]},{"id":"1","selected":["177"]},{"id":"2","selected":[]},{"id":"3","selected":[]},{"id":"4","selected":[]}]
      final response = await dioClient.post(
          AppConstants.SEARCH_URI,
          // queryParameters: queryParameters,
        data: queryParameters,
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
  Future<ApiResponse> getCategoryFilterListCategoryAgain1({
    String name,

    List<Selected> atts,

  }) async {
    print("cczzzz ${test(atts)}");
    try {


      final Map<String, dynamic> queryParameters = {
        'name': jsonEncode(name??''),
        'filter':  jsonEncode(test(atts)),

      };
      logger.d('zxxx: $queryParameters');

      //[{"id":"1","selected":["176","179"]},{"id":"3","selected":["9"]},{"id":"81","selected":["XL"]},{"id":"0","selected":["Olive"]}]
      //[{"id":"77","selected":[]},{"id":"78","selected":[]},{"id":"80","selected":[]},{"id":"81","selected":[]},{"id":"83","selected":[]},{"id":"85","selected":[]},{"id":"86","selected":[]},{"id":"0","selected":[]},{"id":"1","selected":["177"]},{"id":"2","selected":[]},{"id":"3","selected":[]},{"id":"4","selected":[]}]
      final response = await dioClient.get(
        AppConstants.ATTRBUITES_CATEGORIES_URI_WITH_SEARCH,
        queryParameters: queryParameters,
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



  Future<ApiResponse> addToCartListData1(CartModel cart) async {
    Map<String, dynamic> _choice = Map();
    //   for(int index=0; index<choiceOptions.length; index++){
    // //    _choice.addAll({choiceOptions[index].name: choiceOptions[index].options[variationIndexes[index]]});
    //   }
    Map<String, dynamic> _data =cart.variationModel.toJson(cart.id.toString(), cart.quantity.toString());



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

  Future<bool> removeSearchAddress(String searchAddress) async {
    try {
      List<String> searchKeywordList = sharedPreferences.getStringList(AppConstants.SEARCH_ADDRESS);
      if (searchKeywordList.contains(searchAddress)) {
        searchKeywordList.remove(searchAddress);
        await sharedPreferences.setStringList(AppConstants.SEARCH_ADDRESS, searchKeywordList);
        return true; // Indicate that the item was removed successfully
      }
      return false; // Indicate that the item was not found in the list
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