import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FacebookLoginProvider with ChangeNotifier {
  Map userData;
  LoginResult result;

  Future<void> login() async {

    result = await FacebookAuth.instance.login();
    // by default we request the email and the public profile
    if (result.status == LoginStatus.success) {
      userData = await FacebookAuth.instance.getUserData();

    } else {
      print(result.status);
      print(result.message);
    }
    notifyListeners();
  }

  logOut() async {
    final prefs = await SharedPreferences.getInstance();
     await prefs.remove('medium');
    await FacebookAuth.instance.logOut();
    userData = null;
    notifyListeners();
  }
}
