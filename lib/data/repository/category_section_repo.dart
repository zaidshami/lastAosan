import 'package:flutter/material.dart';
import '../../../../data/datasource/remote/dio/dio_client.dart';
import '../../../../data/datasource/remote/exception/api_error_handler.dart';
import '../../../../data/model/response/base/api_response.dart';
import '../../../../utill/app_constants.dart';

class CategorySectionRepo {
  final DioClient dioClient;
  CategorySectionRepo({@required this.dioClient});
  Future<ApiResponse> getCategorySection(int id) async {

    try {
      final response = await dioClient.get(AppConstants.CATEGORIES_SECTION+id.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
// ,