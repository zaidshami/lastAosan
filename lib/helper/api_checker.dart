import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../data/model/response/base/api_response.dart';
import '../../../../provider/auth_provider.dart';
import '../../../../provider/profile_provider.dart';
import '../../../../view/screen/auth/auth_screen.dart';
import 'package:provider/provider.dart';

class ApiChecker {
  static void checkApi(BuildContext context, ApiResponse apiResponse) {
    if (apiResponse?.error != null) {
      if (apiResponse.error is! String && apiResponse.error.errors != null && apiResponse.error.errors[0].message == 'Unauthorized.') {
        Provider.of<ProfileProvider>(context,listen: false).clearHomeAddress();
        Provider.of<ProfileProvider>(context,listen: false).clearOfficeAddress();
        Provider.of<AuthProvider>(context,listen: false).clearSharedData();
        Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => AuthScreen()), (route) => false);
      } else {
        String _errorMessage;
        if (apiResponse.error is String) {
          _errorMessage = apiResponse.error.toString();
        } else if (apiResponse.error.errors != null && apiResponse.error.errors.isNotEmpty) {
          _errorMessage = apiResponse.error.errors[0].message;
        } else {
          _errorMessage = "Unknown error";  // add a default message here
        }
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_errorMessage, style: TextStyle(color: Colors.white)), backgroundColor: Colors.red));
      }
    } else {
      print('nulllll');
      // handle the situation when apiResponse.error is null
    }
  }

}