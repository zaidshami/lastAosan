///firebase_auth
// import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utill/app_constants.dart';

class GoogleSignInProvider with ChangeNotifier {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount googleAccount;
  GoogleSignInAuthentication auth;
  Future<void> login() async {
    this.googleAccount = await _googleSignIn.signIn();
    auth = await googleAccount.authentication;

    print("auth.idToken"+auth.idToken);
    print("auth.accessToken"+auth.accessToken);
    print("googleAccount.email"+googleAccount.email);
    print("googleAccount.id"+googleAccount.id);
    notifyListeners();
  }

  logout() async {
    this.googleAccount = await _googleSignIn.signOut();
    notifyListeners();
/*
    Future<void> deleteAccount(String email) async {
      final String url = 'http://s955305333.onlinehome.us/api/v1/auth/delete_account';
      final Dio dio = Dio();

      final Map<String, dynamic> data = {
        'email': email,
      };

      try {
        final response = await dio.post(
          url,
          data: data,
          options: Options(
            contentType: Headers.jsonContentType,
          ),
        );

        if (response.statusCode == 200) {
          print('Account deleted successfully');
        } else {
          print('Failed to delete account');
        }
      } catch (e) {
        print('Error: $e');
      }
    }*/
  }
  Future<void> deleteAccount(String email) async {
    final String url = '${AppConstants.BASE_URL}${AppConstants.DELETE_ACCOUNT}';
    final Dio dio = Dio();

    final Map<String, dynamic> data = {
      'email': email,
    };

    try {
      final response = await dio.post(
        url,
        data: data,
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );

      if (response.statusCode == 200) {
        print('Account deleted successfully');
      } else {
        print('Failed to delete account');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

}




///firebase auth
// class AuthService1{
//
//   handleAuthState() {
//     return StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (BuildContext context, snapshot) {
//           if (snapshot.hasData) {
//             return HomePage();
//           } else {
//             return  AuthScreen();
//           }
//         });
//   }
//   GoogleSignInAccount googleUser;
//   signInWithGoogle() async {
//     // Trigger the authentication flow
//     final GoogleSignInAccount googleUser = await GoogleSignIn(
//         scopes: <String>["email"]).signIn();
//
//     // Obtain the auth details from the request
//     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
//     // Create a new credential
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );
//
//     // Once signed in, return the UserCredential
//
//     // print(FirebaseAuth.instance.currentUser.email);
//
//     print(googleUser.email);
//     print(googleUser.displayName);
//
//     return await FirebaseAuth.instance.signInWithCredential(credential);
//   }
//
// }