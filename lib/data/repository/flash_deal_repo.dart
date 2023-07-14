import 'package:flutter/material.dart';
import '../../../../data/datasource/remote/dio/dio_client.dart';
import '../../../../data/datasource/remote/exception/api_error_handler.dart';
import '../../../../data/model/response/base/api_response.dart';
import '../../../../utill/app_constants.dart';

class FlashDealRepo {
  final DioClient dioClient;
  FlashDealRepo({@required this.dioClient});

  Future<ApiResponse> getFlashDeal(int id) async {
    try {
      final response = await dioClient.get(AppConstants.FLASH_DEAL_URI+id.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getFlashDealList(String productID) async {
    try {
      final response = await dioClient.get('${AppConstants.FLASH_DEAL_PRODUCT_URI}$productID');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}