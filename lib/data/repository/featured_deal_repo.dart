import 'package:flutter/material.dart';
import '../../../../data/datasource/remote/dio/dio_client.dart';
import '../../../../data/datasource/remote/exception/api_error_handler.dart';
import '../../../../data/model/response/base/api_response.dart';
import '../../../../utill/app_constants.dart';

class FeaturedDealRepo {
  final DioClient dioClient;
  FeaturedDealRepo({@required this.dioClient});

  Future<ApiResponse> getFeaturedDeal(int id) async {
    try {

      final response = await dioClient.get(AppConstants.FEATURED_DEAL_URI+id.toString()
      );

      // print(response.realUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}