import 'package:flutter/material.dart';
import '../../../../data/datasource/remote/dio/dio_client.dart';
import '../../../../data/datasource/remote/exception/api_error_handler.dart';
import '../../../../data/model/response/base/api_response.dart';
import '../../../../utill/app_constants.dart';

// class FilterCategoryRepo {
//   final DioClient dioClient;
//   FilterCategoryRepo({@required this.dioClient});
//
//   Future<ApiResponse> getCategoryFilterList() async {
//     try {
//       final response = await dioClient.get(
//           AppConstants.Filter_CATEGORIES_URI);
//       return ApiResponse.withSuccess(response);
//     } catch (e) {
//       return ApiResponse.withError(ApiErrorHandler.getMessage(e));
//     }
//   }
// }

class FilterCategoryRepo {
  final DioClient dioClient;

  FilterCategoryRepo({@required this.dioClient});

  Future<ApiResponse> getCategoryFilterList() async {
    try {
      final response = await dioClient.get(AppConstants.Filter_CATEGORIES_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
