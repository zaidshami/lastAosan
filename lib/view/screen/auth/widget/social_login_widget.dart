import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/utill/custom_themes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../../data/model/response/social_login_model.dart';
import '../../../../provider/auth_provider.dart';
import '../../../../provider/facebook_login_provider.dart';
import '../../../../provider/google_sign_in_provider.dart';
import '../../../../provider/profile_provider.dart';
import '../../../../provider/splash_provider.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/images.dart';
import '../../dashboard/dashboard_screen.dart';
import 'mobile_verify_screen.dart';
import 'otp_verification_screen.dart';

class SocialLoginWidget extends StatefulWidget {
  @override
  _SocialLoginWidgetState createState() => _SocialLoginWidgetState();
}

class _SocialLoginWidgetState extends State<SocialLoginWidget> {
  //sleep(Duration(seconds: 5));
  SocialLoginModel socialLogin = SocialLoginModel();
  SocialLoginModelApple socialLoginApple = SocialLoginModelApple();

  route(bool isRoute, String token, String temporaryToken,
      String errorMessage) async {
    if (isRoute) {
      if (token != null) {
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (_) => DashBoardScreen()),
            (route) => false);
      } else if (temporaryToken != null && temporaryToken.isNotEmpty) {
        if (Provider.of<SplashProvider>(context, listen: false)
            .configModel
            .emailVerification) {
          Provider.of<AuthProvider>(context, listen: false)
              .checkEmail(socialLogin.email.toString(), temporaryToken)
              .then((value) async {
            if (value.isSuccess) {
              Provider.of<AuthProvider>(context, listen: false)
                  .updateEmail(socialLogin.email.toString());
              Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(
                      builder: (_) => VerificationScreen(
                          temporaryToken, '', socialLogin.email.toString())),
                  (route) => false);
            }
          });
        }
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(
                builder: (_) => MobileVerificationScreen(temporaryToken)),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage), backgroundColor: Colors.red));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.red));
    }
  }
  routeApple(bool isRoute, String token, String temporaryToken,
      String errorMessage) async {
    if (isRoute) {
      if (token != null) {
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (_) => DashBoardScreen()),
                (route) => false);
      } else if (temporaryToken != null && temporaryToken.isNotEmpty) {
        if (Provider.of<SplashProvider>(context, listen: false)
            .configModel
            .emailVerification) {
          Provider.of<AuthProvider>(context, listen: false)
              .checkEmail(socialLoginApple.email.toString(), temporaryToken)
              .then((value) async {
            if (value.isSuccess) {
              Provider.of<AuthProvider>(context, listen: false)
                  .updateEmail(socialLoginApple.email.toString());
              Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(
                      builder: (_) => VerificationScreen(
                          temporaryToken, '', socialLoginApple.email.toString())),
                      (route) => false);
            }
          });
        }
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(
                builder: (_) => MobileVerificationScreen(temporaryToken)),
                (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage), backgroundColor: Colors.red));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    //sleep(Duration(seconds: 5));
    return Column(
      children: [
        //  Provider.of<SplashProvider>(context,listen: false).configModel.socialLogin[0].status?
        // Provider.of<SplashProvider>(context,listen: false).configModel.socialLogin[1].status?
        //  Center(child: Text(getTranslated('social_login', context)))
        //  :Center(child: Text(getTranslated('social_login', context))):SizedBox(),

        Container(
          color: Provider.of<ThemeProvider>(context).darkTheme
              ? Theme.of(context).canvasColor
              : Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Provider.of<SplashProvider>(context, listen: false)
                      .configModel
                      .socialLogin[0]
                      .status
                  ?

                  // InkWell(
                  //   onTap: () async{
                  //
                  //
                  //   },
                  //   child:
                  //   // Ink(color: Color(0xFF397AF3),
                  //   //   child: Padding(padding: EdgeInsets.all(6),
                  //   //     child: Card(child: Padding(padding: const EdgeInsets.all(8.0),
                  //   //         child: Wrap(crossAxisAlignment: WrapCrossAlignment.center,
                  //   //           children: [Container(
                  //   //               decoration: BoxDecoration(color: Colors.white ,
                  //   //                   borderRadius: BorderRadius.all(Radius.circular(50))),
                  //   //               height: 30,width: 180,
                  //   //               child: Row(
                  //   //                 children: [
                  //   //                   Image.asset(Images.google),
                  //   //                   SizedBox(width: 6,),
                  //   //                   Text(getTranslated("Sign_up_Google", context))
                  //   //                 ],
                  //   //               )), // <-- Use 'Image.asset(...)' here
                  //   //           ],
                  //   //         ),
                  //   //       ),
                  //   //     ),
                  //   //   ),
                  //   // ),
                  // )
                  Container(
                      height:   defaultTargetPlatform == TargetPlatform.android? 70:MediaQuery.of(context).size.height*0.18,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child:

                      /// the conditions and the arrange of the sign of google and apple
                      defaultTargetPlatform == TargetPlatform.android ?
                      RoundedButton(
                              title:
                                  'تسجيل الدخول بإستخدام \n        حساب  الجوجل   ',
                              colour: Colors.white,
                              color: Colors.black,
                              onPressed: () async {
                                final prefs = await SharedPreferences.getInstance();
                                await Provider.of<GoogleSignInProvider>(context, listen: false).login();
                                String id, token, email, medium;
                                if (Provider.of<GoogleSignInProvider>(context, listen: false).googleAccount != null) {
                                  id = Provider.of<GoogleSignInProvider>(context, listen: false).googleAccount.id;
                                  email = Provider.of<GoogleSignInProvider>(context, listen: false).googleAccount.email;
                                  token = Provider.of<GoogleSignInProvider>(context, listen: false).auth.accessToken;
                                  medium = 'google';

                                  socialLogin.email = email;
                                  socialLogin.medium = medium;
                                  socialLogin.token = token;
                                  socialLogin.uniqueId = id;
                                  await prefs.setString('medium', 'google');
                                  Provider.of<ProfileProvider>(context, listen: false).getUsermedium(prefs.getString('medium'));
                                  await Provider.of<AuthProvider>(context, listen: false).socialLogin(socialLogin, route);
                                }
                              },
                              image: Image.asset(
                                Images.google,
                                height: 20,
                                width: 20,
                              ),
                            ) :
                      defaultTargetPlatform == TargetPlatform.iOS ?
                 /// both google and apple
                      Column(
                        children: [
                          RoundedButton(
                            title:
                            'تسجيل الدخول بإستخدام \n        حساب  الجوجل   ',
                            colour: Colors.white,
                            color: Colors.black,
                            onPressed: () async {
                              final prefs = await SharedPreferences.getInstance();
                              await Provider.of<GoogleSignInProvider>(context, listen: false).login();
                              String id, token, email, medium;
                              if (Provider.of<GoogleSignInProvider>(context, listen: false).googleAccount != null) {
                                id = Provider.of<GoogleSignInProvider>(context, listen: false).googleAccount.id;
                                email = Provider.of<GoogleSignInProvider>(context, listen: false).googleAccount.email;
                                token = Provider.of<GoogleSignInProvider>(context, listen: false).auth.accessToken;
                                medium = 'google';

                                socialLogin.email = email;
                                socialLogin.medium = medium;
                                socialLogin.token = token;
                                socialLogin.uniqueId = id;
                                await prefs.setString('medium', 'google');
                                Provider.of<ProfileProvider>(context, listen: false).getUsermedium(prefs.getString('medium'));
                                await Provider.of<AuthProvider>(context, listen: false).socialLogin(socialLogin, route);
                              }
                            },
                            image: Image.asset(
                              Images.google,
                              height: 20,
                              width: 20,
                            ),
                          ),
                          defaultTargetPlatform == TargetPlatform.iOS &&AppConstants.showLoginAppleInside == true ?
                          RoundedButton(
                            title:
                            'تسجيل الدخول بإستخدام \n        حساب  ابل   ',
                            colour: Colors.white,
                            color: Colors.black,
                            onPressed: () async {
                              final prefs = await SharedPreferences.getInstance();



                              final credential = await SignInWithApple.
                              getAppleIDCredential(
                                scopes: [

                                  AppleIDAuthorizationScopes.email,
                                  AppleIDAuthorizationScopes.fullName,
                                ],
                              );

                              socialLoginApple.token = credential.identityToken;
                              socialLoginApple.unique_id = credential.authorizationCode;
                              socialLoginApple.id = credential.userIdentifier;
                              socialLoginApple.email = credential.email;
                              // socialLoginApple.email = "jihada31@gmail.com";
                              socialLoginApple.givenName = credential.givenName;
                              socialLoginApple.familyName = credential.familyName;
                              // socialLoginApple.givenName = "جهاد";
                              // socialLoginApple.familyName = "المطحني";
                              socialLoginApple.medium = "apple";

                              print("identityToken" +credential.identityToken);
                              print("authorizationCode" +credential.authorizationCode);
                              print("id" +credential.userIdentifier);
                              credential.familyName!=null?   print("familyName" +credential.familyName):print("the familyName is null");
                              credential.givenName!= null? print("givenName" +credential.givenName):print ("the givenName is null");
                              credential.email!=null?   print("familyName" +credential.email):print("the email is null");
                              print(credential);

                              await prefs.setString('medium', 'apple');
                              Provider.of<ProfileProvider>(context, listen: false).getUsermedium(prefs.getString('medium'));
                              await Provider.of<AuthProvider>(context, listen: false).socialLoginWithApple(socialLoginApple, routeApple );


                              // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
                              // after they have been validated with Apple (see `Integration` section for more information on how to do this)
                            },



                            image: Image.asset(
                              Images.apple,
                              height: 20,
                              width: 20,
                            ),
                          )
                              : SizedBox(),
                        ],
                      )   : SizedBox()



                  ) : SizedBox(),
              Provider.of<SplashProvider>(context, listen: false)
                      .configModel
                      .socialLogin[1]
                      .status
                  ? Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: RoundedButton(
                        color: Colors.white,
                        title: 'تسجيل الدخول بإستخدام \n    حساب الفيس بوك',
                        colour: Color(0xff3b5998),
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await Provider.of<FacebookLoginProvider>(context,
                                  listen: false)
                              .login();
                          String id, token, email, medium;
                          if (Provider.of<FacebookLoginProvider>(context,
                                      listen: false)
                                  .userData !=
                              null) {
                            id = Provider.of<FacebookLoginProvider>(context,
                                    listen: false)
                                .result
                                .accessToken
                                .userId;
                            email = Provider.of<FacebookLoginProvider>(context,
                                    listen: false)
                                .userData['email'];
                            token = Provider.of<FacebookLoginProvider>(context,
                                    listen: false)
                                .result
                                .accessToken
                                .token;
                            medium = 'facebook';

                            socialLogin.email = email;
                            socialLogin.medium = medium;
                            socialLogin.token = token;
                            socialLogin.uniqueId = id;
                            await prefs.setString('medium', 'facebook');
                            Provider.of<ProfileProvider>(context, listen: false)
                                .userMedium = prefs.getString(
                              'medium',
                            );

                            await Provider.of<AuthProvider>(context,
                                    listen: false)
                                .socialLogin(socialLogin, route);
                          }
                        },
                        image: Image.asset(
                          Images.facebook,
                          height: 20,
                          width: 20,
                        ),
                      ),
                    )
                  : SizedBox(),

              /// facebook and google containers
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     ElevatedButton.icon(
              //       style: ElevatedButton.styleFrom(
              //         primary: Colors.red,
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(2.0)),
              //
              //       ),
              //       icon: Image.asset(Images.google,height: 20,width: 20,color: Colors.white,),
              //       label: Text(
              //         "Google",
              //         style: TextStyle(color: Colors.white),
              //       ),
              //       onPressed: () {},
              //     ),
              //     SizedBox(width: 10.0),
              //     ElevatedButton.icon(
              //       style: ElevatedButton.styleFrom(
              //         primary:   Colors.indigo,
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(2.0)),
              //
              //       ),
              //       icon: Icon(
              //         Icons.facebook,
              //         color: Colors.white,
              //       ),
              //       label: Text(
              //         "Facebook",
              //         style: TextStyle(color: Colors.white),
              //       ),
              //       onPressed: () {},
              //     ),
              //   ],
              // ),

              // Column(
              //   children: [
              //     ElevatedButton.icon(
              //       style: ElevatedButton.styleFrom(
              //         primary: Colors.red,
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(2.0)),
              //
              //       ),
              //       icon: Image.asset(Images.google,height: 20,width: 20,color: Colors.white,),
              //       label: Text(
              //         "Google",
              //         style: TextStyle(color: Colors.white),
              //       ),
              //       onPressed: () {},
              //     ),
              //     SizedBox(height: 10.0),
              //     ElevatedButton.icon(
              //       style: ElevatedButton.styleFrom(
              //         primary:   Colors.indigo,
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(2.0)),
              //
              //       ),
              //       icon: Icon(
              //         Icons.facebook,
              //         color: Colors.white,
              //       ),
              //       label: Text(
              //         "Facebook",
              //         style: TextStyle(color: Colors.white),
              //       ),
              //       onPressed: () {},
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ],
    );
  }
}

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {this.colour,
      this.title,
      @required this.onPressed,
      this.image,
      this.color});
  final Color colour;
  final Function onPressed;
  final String title;
  final Color color;

  final Image image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Material(
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 3.0,
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 70.0,
          child: Row(
            children: [
              SizedBox(
                width: 20,
              ),
              image,
              Spacer(),
              Center(
                child: Text(title,
                    style: robotoRegular.copyWith(color: color, fontSize: 15)),
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
