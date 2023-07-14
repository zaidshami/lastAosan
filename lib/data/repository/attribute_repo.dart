import 'package:flutter/material.dart';

import '../../utill/app_constants.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/response/base/api_response.dart';

class AttributeRepo {
  final DioClient dioClient;

  AttributeRepo({@required this.dioClient});

  Future<ApiResponse> getCategoryFilterList() async {
    try {
      final response = await dioClient.get(AppConstants.ATTRBUITES_CATEGORIES_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
