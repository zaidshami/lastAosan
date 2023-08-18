import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../utill/app_constants.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/response/base/api_response.dart';
import '../model/response/filter_category_1.dart';

class AttributeRepo {
  final DioClient dioClient;
  final Logger logger = Logger();
  AttributeRepo({@required this.dioClient});

  List<Map<String, dynamic>> test(List<Selected> atts){
    List<Map<String, dynamic>> _temp = [];
    atts.forEach((element) {
      _temp.add(element.tojson());
    });
    return _temp;

  }
  /// example
  ///  static const String SEARCH_URI = '/api/v1/products/search?name=';
  /*Future<ApiResponse> getSearchProductList(String query) async {
    try {
      final response = await dioClient.get(AppConstants.SEARCH_URI + base64.encode(utf8.encode(query)));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }*/

  Future<ApiResponse> getCategoryFilterList(String query) async {
    try {
      final response = await dioClient.get(AppConstants.ATTRBUITES_CATEGORIES_URI + jsonEncode(query));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getCategoryFilterListCategory(String catId) async {
    try {
      final response = await dioClient.get(AppConstants.ATTRBUITES_CATEGORIES_URI_CATEGORY+(catId.isNotEmpty?("/$catId"):""));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> getCategoryFilterListCategoryAgain(String catId, List<Selected> atts,) async {
    try {
      final response = await dioClient.get(AppConstants.ATTRBUITES_CATEGORIES_URI_CATEGORY+(catId.isNotEmpty?("/$catId"):""));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getCategoryFilterListCategoryAgain1({
    String name,
    List<Selected> atts,

  }) async {
    print("cczzzz ${test(atts)}");
    try {
      // We're taking all the Selected objects from atts and converting them to JSON.
      // List jsonList = atts.map((item) => item.tojson()).toList();

      final Map<String, dynamic> queryParameters = {
        'name': jsonEncode(name??''),
        'filter':  jsonEncode(test(atts)),


      };
      logger.d('mxxx: $queryParameters');

      //[{"id":"1","selected":["176","179"]},{"id":"3","selected":["9"]},{"id":"81","selected":["XL"]},{"id":"0","selected":["Olive"]}]
      //[{"id":"77","selected":[]},{"id":"78","selected":[]},{"id":"80","selected":[]},{"id":"81","selected":[]},{"id":"83","selected":[]},{"id":"85","selected":[]},{"id":"86","selected":[]},{"id":"0","selected":[]},{"id":"1","selected":["177"]},{"id":"2","selected":[]},{"id":"3","selected":[]},{"id":"4","selected":[]}]
      final response = await dioClient.get(
        AppConstants.ATTRBUITES_CATEGORIES_URI_WITH_SEARCH,
        // queryParameters: queryParameters,
        queryParameters: queryParameters,
      );

      logger.d("mxxxx: " + response.data.toString());

      return ApiResponse.withSuccess(response);
    } catch (e) {
      print("search result error "+e.toString());
      print("search result error "+ApiResponse.withError(ApiErrorHandler.getMessage(e)).toString());

      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}



