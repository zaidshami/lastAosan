import 'package:flutter/material.dart';
import '../../../../data/datasource/remote/dio/dio_client.dart';
import '../../../../data/datasource/remote/exception/api_error_handler.dart';
import '../../../../data/model/response/base/api_response.dart';
import '../../../../utill/app_constants.dart';

class BannerRepo {
  final DioClient dioClient;
  BannerRepo({@required this.dioClient});

  Future<ApiResponse> getBannerList(int id) async {
    try {
      final response = await dioClient.get(AppConstants.MAIN_BANNER_URI+id.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> getFooterBannerList(int id) async {
    try {
      final response = await dioClient.get(AppConstants.FOOTER_BANNER_URI+id.toString());

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> getMainSectionBannerList(int id) async {
    try {
      final response = await dioClient.get(AppConstants.MAIN_SECTION_BANNER_URI+id.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> getSecondSectionBannerList(int id) async {
    try {
      final response = await dioClient.get(AppConstants.SECOND_SECTION_BANNER_URI+id.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> getProductDetails(String productID) async {
    try {
      final response = await dioClient.get('${AppConstants.PRODUCT_DETAILS_URI}$productID');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}