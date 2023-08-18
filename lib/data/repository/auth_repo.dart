import 'dart:convert';
import 'dart:io';


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../data/datasource/remote/dio/dio_client.dart';
import '../../../../data/datasource/remote/exception/api_error_handler.dart';
import '../../../../data/model/body/login_model.dart';
import '../../../../data/model/body/register_model.dart';
import '../../../../data/model/response/base/api_response.dart';
import '../../../../data/model/response/social_login_model.dart';
import '../../../../utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({@required this.dioClient, @required this.sharedPreferences});


  Future<ApiResponse> socialLogin(SocialLoginModel socialLogin) async {
    try {
      Response response = await dioClient.post(
        AppConstants.SOCIAL_LOGIN_URI,
        data: socialLogin.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> socialLoginApple(SocialLoginModelApple socialLogin) async {
    try {
      Response response = await dioClient.post(
        AppConstants.SOCIAL_LOGIN_APPLE_URI,
        data: socialLogin.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  Future<ApiResponse> registration(RegisterModel register) async {
    try {
      Response response = await dioClient.post(
        AppConstants.REGISTRATION_URI,
        data: register.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {

      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> login(LoginModel loginBody) async {
    try {
      Response response = await dioClient.post(
        AppConstants.LOGIN_URI,
        data: loginBody.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> updateToken() async {
    try {
      String _deviceToken = await _getDeviceToken();
      FirebaseMessaging.instance.subscribeToTopic(AppConstants.TOPIC);
      Response response = await dioClient.post(
        AppConstants.TOKEN_URI,
        data: {"_method": "put", "cm_firebase_token": _deviceToken},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<String> _getDeviceToken3() async {
    String _deviceToken;
    if (Platform.isIOS) {
      // Check if the user has granted permission to receive push notifications
      final settings = await FirebaseMessaging.instance.requestPermission();
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        // User has granted permission, retrieve the APNS device token
        _deviceToken = await FirebaseMessaging.instance.getToken();

        print('APNS device token: $_deviceToken');
      } else {
        print('User has not granted permission to receive push notifications');
      }
    } else {
      // Retrieve the FCM token on Android
      _deviceToken = await FirebaseMessaging.instance.getToken();

      print('FCM device token: $_deviceToken');
    }

    if (_deviceToken != null) {
      FirebaseMessaging.instance.subscribeToTopic(AppConstants.TOPIC);
      // Retrieve the FCM token using the APNS device token
      final headers = {
        'apns-topic': '<com.aosan1.online>',
      };
      final endpoint = 'https://iid.googleapis.com/iid/v1/$_deviceToken/rel/topics/<Jwaher>';
      final request = {
        'application': '<6446410425>',
        'sandbox': false,
        'apns_tokens': [_deviceToken],
      };
      final response = await http.post(
        endpoint as Uri,
        headers: headers,
        body: jsonEncode(request),
      );
      final jsonResponse = jsonDecode(response.body);
      final fcmToken = jsonResponse['results'][0]['registration_token'];
      print('FCM token: $fcmToken');
    } else {
      print('APNS device token is null');
    }

    return _deviceToken;
  }


  ///new new
  Future<String> _getDeviceToken2() async {
    String _deviceToken;
    if (Platform.isIOS) {
      // Check if the user has granted permission to receive push notifications
      final settings = await FirebaseMessaging.instance.requestPermission();
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        // User has granted permission, retrieve the APNS device token
        _deviceToken = await FirebaseMessaging.instance.getAPNSToken();
        print('APNS device token: $_deviceToken');
      } else {
        print('User has not granted permission to receive push notifications');
      }
    } else {
      // Retrieve the FCM token on Android
      _deviceToken = await FirebaseMessaging.instance.getToken();
      print('APNS device token: $_deviceToken');
    }

    if (_deviceToken != null) {
      // Retrieve the FCM token using the APNS device token
      final fcmToken = await FirebaseMessaging.instance.getToken(
        vapidKey: '<YOUR_VAPID_KEY>',
        // Add this line to include the APNS token
      );
      print('FCM token: $fcmToken');
    } else {
      print('APNS device token is null'); // Add this line to indicate when APNS token is null
    }

    return _deviceToken;
  }

  ///new from chatgpt
  Future<String> _getDeviceToken1() async {
    String _deviceToken;
    if(Platform.isIOS) {
      // Check if the user has granted permission to receive push notifications
      final settings = await FirebaseMessaging.instance.requestPermission();
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        // User has granted permission, retrieve the APNS device token
        _deviceToken = await FirebaseMessaging.instance.getAPNSToken();

        print('APNS device token: $_deviceToken');
      } else {
        print('User has not granted permission to receive push notifications');
      }
    } else {
      // Retrieve the FCM token on Android
      _deviceToken = await FirebaseMessaging.instance.getToken();
      print('APNS device token: $_deviceToken');
    }

    if (_deviceToken != null) {
      // Retrieve the FCM token using the APNS device token
      final fcmToken = await FirebaseMessaging.instance.getToken(
        vapidKey: '<YOUR_VAPID_KEY>',
        //apnsToken: _deviceToken,
      );
      print('FCM token: $fcmToken');
    }
    return _deviceToken;
  }

  //orginal that works in android
  Future<String> _getDeviceToken() async {


    String _deviceToken;
    if(Platform.isIOS) {
       _deviceToken = await FirebaseMessaging.instance.getToken();
       print('--------APNs Token---------- '+_deviceToken);
    }else {
       _deviceToken = await FirebaseMessaging.instance.getToken();
       print('--------ANDR Token---------- '+_deviceToken);
    }

    if (_deviceToken != null) {
      // Retrieve the FCM token using the APNS device token
/*      final fcmToken = await FirebaseMessaging.instance.getToken(
        vapidKey: '<YOUR_VAPID_KEY>',
        //apnsToken: _deviceToken,
      );
      print('FCM token: $fcmToken');*/
       print('--------Device Token---------- '+_deviceToken);
    }
    return _deviceToken;
  }

  // for  user token
  Future<void> saveUserToken(String token) async {
    dioClient.updateHeader(token, null);

    try {
      await sharedPreferences.setString(AppConstants.TOKEN, token);
    } catch (e) {
      throw e;
    }
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

  //auth token
  // for  user token
  Future<void> saveAuthToken(String token) async {
    dioClient.token = token;
    dioClient.dio.options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    try {
      await sharedPreferences.setString(AppConstants.TOKEN, token);
    } catch (e) {
      throw e;
    }
  }

  String getAuthToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }


  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<bool> clearSharedData() async {
    //sharedPreferences.remove(AppConstants.CART_LIST);
    sharedPreferences.remove(AppConstants.CURRENCY);
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.USER);

    FirebaseMessaging.instance.unsubscribeFromTopic(AppConstants.TOPIC);
    return true;
  }

  // for verify Email
  Future<ApiResponse> checkEmail(String email, String temporaryToken) async {
    try {
      Response response = await dioClient.post(AppConstants.CHECK_EMAIL_URI, data: {"email": email, "temporary_token" : temporaryToken});
        return ApiResponse.withSuccess(response);
    } catch (e) {
      print(e);
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> verifyEmail(String email, String token, String tempToken) async {
    try {
      Response response = await dioClient.post(AppConstants.VERIFY_EMAIL_URI, data: {"email": email, "token": token, 'temporary_token': tempToken});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  //verify phone number

  Future<ApiResponse> checkPhone(String phone, String temporaryToken) async {
    try {
      Response response = await dioClient.post(
          AppConstants.CHECK_PHONE_URI, data: {"phone": phone, "temporary_token" :temporaryToken});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> verifyPhone(String phone, String token,String otp) async {
    try {
      Response response = await dioClient.post(
          AppConstants.VERIFY_PHONE_URI, data: {"phone": phone.trim(), "temporary_token": token,"otp": otp});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> verifyOtp(String identity, String otp) async {
    try {
      Response response = await dioClient.post(
          AppConstants.VERIFY_OTP_URI, data: {"identity": identity.trim(), "otp": otp});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> resetPassword(String identity, String otp ,String password, String confirmPassword) async {
    // print('======Password====>$password');
    try {
      Response response = await dioClient.post(
          AppConstants.RESET_PASSWORD_URI, data: {"_method" : "put", "identity": identity.trim(), "otp": otp,"password": password, "confirm_password":confirmPassword});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  // for  Remember Email
  Future<void> saveUserEmailAndPassword(String email, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.USER_PASSWORD, password);
      await sharedPreferences.setString(AppConstants.USER_EMAIL, email);
    } catch (e) {
      throw e;
    }
  }

  String getUserEmail() {
    return sharedPreferences.getString(AppConstants.USER_EMAIL) ?? "";
  }

  String getUserPassword() {
    return sharedPreferences.getString(AppConstants.USER_PASSWORD) ?? "";
  }

  Future<bool> clearUserEmailAndPassword() async {
    await sharedPreferences.remove(AppConstants.USER_PASSWORD);
    return await sharedPreferences.remove(AppConstants.USER_EMAIL);
  }

  Future<ApiResponse> forgetPassword(String identity) async {
    try {
      Response response = await dioClient.post(AppConstants.FORGET_PASSWORD_URI, data: {"identity": identity});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}
