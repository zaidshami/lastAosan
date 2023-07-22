import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/view/screen/profile/profile_screen.dart';


import 'package:provider/provider.dart';

import '../../../localization/language_constrants.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/profile_provider.dart';
import '../../../provider/splash_provider.dart';

import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../basewidget/animated_custom_dialog.dart';
import '../../basewidget/button/custom_button.dart';
import '../../basewidget/not_loggedin_widget.dart';
import '../address/address_screen.dart';
import '../auth/auth_screen.dart';

import '../loyaltyPoint/loyalty_point_screen.dart';
import '../more/web_view_screen.dart';
import '../more/widget/delet_my_account>confirmation_dialog.dart';
import '../more/widget/html_view_Screen.dart';
import '../more/widget/sign_out_confirmation_dialog.dart';

import '../order/order_screen.dart';
import '../setting/settings_screen.dart';
import '../support/support_ticket_screen.dart';

class Profile extends StatefulWidget {
 // const Profile({Key key}) : super(key: key);
  @override
  State<Profile> createState() => _ProfileState();

}

class _ProfileState extends State<Profile> {

  @override
  void initState() {

    super.initState();
    Provider.of<AuthProvider>(context, listen: false).isLoggedIn() ?  Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context):null;



  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(child: Text(getTranslated('PROFILE', context), style: robotoBold.copyWith(color:Colors.black,fontSize: 20),))
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,

          child: Column(
            children: <Widget>[



              ///the user name and the e mail of the user
             Provider.of<AuthProvider>(context, listen: false).isLoggedIn()?

          Consumer<ProfileProvider>(

              builder: (context,profile, c){
                             return InkWell(
                  onTap: () {
                    Provider.of<ProfileProvider>(context,listen: false).getUsermedium1();



                    Navigator.push(context, CupertinoPageRoute(builder: (_) => ProfileScreen(),));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 15),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    //color: Colors.red,
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(profile.userInfoModel.fName+" "+(profile.userInfoModel.lName!= null? profile.userInfoModel.lName: " "), style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold), textDirection: TextDirection.rtl),
                              Text(profile.userInfoModel.email, style: TextStyle(color: Colors.grey), textDirection: TextDirection.rtl,),
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios,color: Theme.of(context).primaryColor,)
                      ],
                    ),
                    decoration: BoxDecoration(
                      //color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                    ),
                  ),

                );
              }


          ) :
             Consumer<ProfileProvider>(
              builder: (context,profile, c){
                return InkWell(
                  onTap: () {


                  },
                  child:    Container(
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 30),
                    child: Provider.of<AuthProvider>(context).isLoading ?
                    Center(
                      child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor,),),) :
                    CustomButton(onTap: () {
                      Navigator.push(context, CupertinoPageRoute(builder: (_) => AuthScreen(),));}, buttonText: getTranslated('SIGN_IN_UP', context)),),

                );
              }


          ),




             ///the circular avatars orders and balance
             //  Container(
             //    margin: EdgeInsets.only(top: 15),
             //    alignment: Alignment.center,
             //    width: double.infinity,
             //    height: 110,
             //    child: Row(
             //      mainAxisAlignment: MainAxisAlignment.center,
             //      children: [
             //        InkWell(
             //          onTap: () {
             //
             //            Navigator.push(context, CupertinoPageRoute(builder: (_) => OrderScreen(),));
             //          },
             //          child: Column(
             //            children: [
             //              Container(
             //                height: 70,
             //                width: 70,
             //                child: Icon(Icons.directions_bus, color: Theme
             //                    .of(context)
             //                    .primaryColor),
             //                decoration: BoxDecoration(
             //                  borderRadius: BorderRadius.circular(100),
             //                  border: Border.all(color: Theme
             //                      .of(context)
             //                      .primaryColor),
             //                  color: Colors.white,
             //                  boxShadow: [
             //                    BoxShadow(color: Colors.grey.withOpacity(0.2),
             //                        spreadRadius: 1,
             //                        blurRadius: 5)
             //                  ],
             //                ),
             //              ),
             //              Text(getTranslated('orders', context))
             //            ],
             //          ),
             //        ),
             //        SizedBox(width: 10,),
             //        InkWell(
             //          onTap: () {
             //            //Navigator.pushNamed(context, '/editProfile');
             //          },
             //          child: Column(
             //            children: [
             //              Container(
             //                height: 70,
             //                width: 70,
             //                child: Icon(Icons.car_crash_sharp, color: Theme
             //                    .of(context)
             //                    .primaryColor),
             //                decoration: BoxDecoration(
             //                  borderRadius: BorderRadius.circular(100),
             //                  border: Border.all(color: Theme
             //                      .of(context)
             //                      .primaryColor),
             //                  color: Colors.white,
             //                  boxShadow: [
             //                    BoxShadow(color: Colors.grey.withOpacity(0.2),
             //                        spreadRadius: 1,
             //                        blurRadius: 5)
             //                  ],
             //                ),
             //              ),
             //              Text("الرصيد")
             //            ],
             //          ),
             //        )
             //      ],
             //    ),
             //    decoration: BoxDecoration(
             //      //color: Colors.white,
             //      border: Border(
             //        bottom: BorderSide(
             //          color: Colors.grey.withOpacity(0.1),
             //          width: 1,
             //        ),
             //      ),
             //    ),
             //  ),

                /// why shopping with us
              WhyShoppingWithUs(),


              ///adress
              Provider.of<AuthProvider>(context, listen: false).isLoggedIn() ? InkWell(
                onTap: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (_) => AddressScreen(),));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  //color: Colors.red,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Image.asset(Images.location_city,height: 30,),
                            SizedBox(width: 10,),
                            Text(   getTranslated('address', context), style:  robotoBold.copyWith(fontSize: 12),
                                textDirection: TextDirection.rtl),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, color: Theme
                          .of(context)
                          .primaryColor,)
                    ],
                  ),
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey.withOpacity(0.1),
                        width: 1,
                      ),
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ):SizedBox(),
              
              ///orders
              Provider.of<AuthProvider>(context, listen: false).isLoggedIn() ?    InkWell(
                onTap: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (_) => OrderScreen(),));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  //color: Colors.red,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Image.asset(Images.directions_bus,height: 30,),
                            SizedBox(width: 10,),
                            Text(   getTranslated('orders', context), style:  robotoBold.copyWith(fontSize: 12),
                                textDirection: TextDirection.rtl),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, color: Theme
                          .of(context)
                          .primaryColor,)
                    ],
                  ),
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey.withOpacity(0.1),
                        width: 1,
                      ),
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ):SizedBox(),



              /// setteing
              InkWell(
                onTap: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (_) => SettingsScreen(),));
                },
                child: Container(
                  //margin: EdgeInsets.all(10),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  //color: Colors.red,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Image.asset(Images.set,height: 30,),
                            SizedBox(width: 10,),

                            Text(getTranslated('settings', context), style: robotoBold.copyWith(fontSize: 12),
                                textDirection: TextDirection.rtl),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, color: Theme
                          .of(context)
                          .primaryColor,)
                    ],
                  ),
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey.withOpacity(0.1),
                        width: 1,
                      ),
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              ///loyality points
              Provider.of<SplashProvider>(context,listen: false).configModel.loyaltyPointStatus ==1?
              TitleButton(image: Images.loyalty_point, title: getTranslated('loyalty_point', context),
                  navigateTo: LoyaltyPointScreen()):SizedBox(),

              /// offers
              // InkWell(
              //   onTap: () {
              //     Navigator.push(context, CupertinoPageRoute(builder: (_) => OffersScreen(),));
              //   },
              //   child: Container(
              //     //margin: EdgeInsets.all(10),
              //     width: MediaQuery
              //         .of(context)
              //         .size
              //         .width,
              //     //color: Colors.red,
              //     height: 50,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Container(
              //           child: Row(
              //             children: [
              //               Image.asset(
              //                 Images.offers,
              //                 height: 30,
              //               ),
              //               SizedBox(width: 15,),
              //               Text( getTranslated('offers', context), style: robotoBold.copyWith(fontSize: 20),
              //                   textDirection: TextDirection.rtl),
              //             ],
              //           ),
              //         ),
              //         Icon(Icons.arrow_forward_ios, color: Theme
              //             .of(context)
              //             .primaryColor,)
              //       ],
              //     ),
              //     decoration: BoxDecoration(
              //       //color: Colors.white,
              //       border: Border(
              //         top: BorderSide(
              //           color: Colors.grey.withOpacity(0.1),
              //           width: 1,
              //         ),
              //         bottom: BorderSide(
              //           color: Colors.grey.withOpacity(0.1),
              //           width: 1,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),


              ///notifications
              // Provider.of<AuthProvider>(context, listen: false).isLoggedIn() ?   InkWell(
              //   onTap: () {
              //     Navigator.push(context, CupertinoPageRoute(builder: (_) => NotificationScreen(),));
              //   },
              //   child: Container(
              //     //margin: EdgeInsets.all(10),
              //     width: MediaQuery
              //         .of(context)
              //         .size
              //         .width,
              //     //color: Colors.red,
              //     height: 50,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Container(
              //           child: Row(
              //             children: [
              //               Image.asset(
              //                 Images.notification_filled,
              //                 height: 30,
              //               ),
              //               SizedBox(width: 15,),
              //               Text( getTranslated('notification', context), style: TextStyle(fontSize: 20,),
              //                   textDirection: TextDirection.rtl),
              //             ],
              //           ),
              //         ),
              //         Icon(Icons.arrow_forward_ios, color: Theme
              //             .of(context)
              //             .primaryColor,)
              //       ],
              //     ),
              //     decoration: BoxDecoration(
              //       //color: Colors.white,
              //       border: Border(
              //         top: BorderSide(
              //           color: Colors.grey.withOpacity(0.1),
              //           width: 1,
              //         ),
              //         bottom: BorderSide(
              //           color: Colors.grey.withOpacity(0.1),
              //           width: 1,
              //         ),
              //       ),
              //     ),
              //   ),
              // ):SizedBox(),

              ///support_ticket
              InkWell(
                onTap: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (_) => SupportTicketScreen(),));
                },
                child: Container(
                  //margin: EdgeInsets.all(10),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  //color: Colors.red,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Image.asset(
                              Images.preference,
                              height: 25,
                              color: Colors.black,
                            ),
                            SizedBox(width: 15,),
                            Text( getTranslated('support_ticket', context), style: robotoBold.copyWith(fontSize: 12),
                                textDirection: TextDirection.rtl),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, color: Theme
                          .of(context)
                          .primaryColor,)
                    ],
                  ),
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey.withOpacity(0.1),
                        width: 1,
                      ),
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),


              ///terms_condition
              InkWell(
                onTap: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (_) => HtmlViewScreen(title: getTranslated('terms_condition', context),
                    url: Provider.of<SplashProvider>(context, listen: false).configModel.termsConditions,)));
                },
                child: Container(
                  //margin: EdgeInsets.all(10),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  //color: Colors.red,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Image.asset(
                              Images.term_condition,
                              height: 25,
                            ),
                            SizedBox(width: 15,),
                            Text( getTranslated('terms_condition', context), style:  robotoBold.copyWith(fontSize: 12),
                                textDirection: TextDirection.rtl),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, color: Theme
                          .of(context)
                          .primaryColor,)
                    ],
                  ),
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey.withOpacity(0.1),
                        width: 1,
                      ),
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),

              ///privacy_policy
              InkWell(
                onTap: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (_) => HtmlViewScreen(title: getTranslated('privacy_policy', context),
                    url: Provider.of<SplashProvider>(context, listen: false).configModel.privacyPolicy,)));
                },
                child: Container(
                  //margin: EdgeInsets.all(10),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  //color: Colors.red,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Image.asset(
                              Images.privacy_policy,
                              height: 25,
                              color: Colors.black,
                            ),
                            SizedBox(width: 15,),
                            Text( getTranslated('privacy_policy', context), style:  robotoBold.copyWith(fontSize: 12),
                                textDirection: TextDirection.rtl),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, color: Theme
                          .of(context)
                          .primaryColor,)
                    ],
                  ),
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey.withOpacity(0.1),
                        width: 1,
                      ),
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),

              ///faq
              // InkWell(
              //   onTap: () {
              //     Navigator.push(context, CupertinoPageRoute(builder: (_) => FaqScreen(title: getTranslated('faq', context),)));
              //   },
              //   child: Container(
              //     //margin: EdgeInsets.all(10),
              //     width: MediaQuery
              //         .of(context)
              //         .size
              //         .width,
              //     //color: Colors.red,
              //     height: 50,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Container(
              //           child: Row(
              //             children: [
              //               Image.asset(
              //                 Images.help_center,
              //                 height: 30,
              //               ),
              //               SizedBox(width: 15,),
              //               Text( getTranslated('faq', context), style:  robotoBold.copyWith(fontSize: 20),
              //                   textDirection: TextDirection.rtl),
              //             ],
              //           ),
              //         ),
              //         Icon(Icons.arrow_forward_ios, color: Theme
              //             .of(context)
              //             .primaryColor,)
              //       ],
              //     ),
              //     decoration: BoxDecoration(
              //       //color: Colors.white,
              //       border: Border(
              //         top: BorderSide(
              //           color: Colors.grey.withOpacity(0.1),
              //           width: 1,
              //         ),
              //         bottom: BorderSide(
              //           color: Colors.grey.withOpacity(0.1),
              //           width: 1,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              ///about_us
              InkWell(
                onTap: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (_) => HtmlViewScreen(title: getTranslated('about_us', context),
                    url: Provider.of<SplashProvider>(context, listen: false).configModel.aboutUs,)));
                },
                child: Container(
                  //margin: EdgeInsets.all(10),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  //color: Colors.red,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Image.asset(
                              Images.about_us,
                              height: 30,
                            ),
                            SizedBox(width: 15,),
                            Text( getTranslated('about_us', context), style:  robotoBold.copyWith(fontSize:12),
                                textDirection: TextDirection.rtl),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, color: Theme
                          .of(context)
                          .primaryColor,)
                    ],
                  ),
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey.withOpacity(0.1),
                        width: 1,
                      ),
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              // isGuestMode ? SizedBox() : mohd

              ///sign_out
              Provider.of<AuthProvider>(context, listen: false).isLoggedIn() ?   ListTile(
                leading: Icon(Icons.exit_to_app, color: ColorResources.getPrimary(context), size: 25),
                title: Text(getTranslated('sign_out', context),
                    style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
                onTap: () => showAnimatedDialog(context, SignOutConfirmationDialog(), isFlip: true),
              ) : SizedBox(),
              ///delete_account

              Provider.of<AuthProvider>(context, listen: false).isLoggedIn() ?   ListTile(
                leading: Icon(Icons.delete_forever_outlined, color: ColorResources.getPrimary(context), size: 18),
                title: Text(getTranslated('delete_account', context),
                    style: titilliumRegular.copyWith(fontSize: 10)),
                onTap: () => showAnimatedDialog(context, DeleteAccountConfirmationDialog(), isFlip: true),
              ) : SizedBox(),


              ///whatsapp and facebook icons
             Padding(
               padding: EdgeInsets.only(left: 20),
               child: Row(
                 children: [

                   SizedBox(width: 15,),
                   Expanded(
                     child: InkWell(
                       onTap: () {
                         // Navigator.push(context, CupertinoPageRoute(builder: (_) =>  WebViewScreen(title:
                         // getTranslated('contact_us', context)),));
                         Provider.of<ProfileProvider>(context,listen: false).openWhatsapp(context: context, text: 'مرحبا متجر اوسان ', number: '+967779922883');

                       },
                       child: Container(
                         margin: EdgeInsets.only(top: 20),
                         height: 50,
                         width: MediaQuery
                             .of(context)
                             .size
                             .width/1.1,
                         //color: Colors.red,
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [


                             Text(getTranslated('customer_care', context),style: robotoBold.copyWith(fontSize: 13),
                               textDirection: TextDirection.rtl,),
                             SizedBox(width: 15,),
                             Image.asset(Images.whatsapp,height: 30,),
                             SizedBox(width: 15,),

                           ],
                         ),
                         decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(5),
                           border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
                         ),
                       ),
                     ),
                   ),

                   SizedBox(width: 15,),
                   Expanded(
                     child: InkWell(
                       onTap: () {
                         // Navigator.push(context, CupertinoPageRoute(builder: (_) =>  WebViewScreen(title:
                         // getTranslated('contact_us', context)),));

                         ///facebook app open function
                         Provider.of<ProfileProvider>(context,listen: false).openFacebook();


                       },
                       child: Container(
                         margin: EdgeInsets.only(top: 20),
                         height: 50,
                         width: MediaQuery
                             .of(context)
                             .size
                             .width/1.1,
                         //color: Colors.red,
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [

                             Text(getTranslated('Our_page_On', context),style: robotoBold.copyWith(fontSize: 13),
                               textDirection: TextDirection.rtl,),
                             SizedBox(width: 15,),
                             Image.asset(Images.facebook,height: 30,),

                           ],
                         ),
                         decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(5),
                           border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
                         ),
                       ),
                     ),
                   ),




                 ],
               ),
             ),
             Padding(
               padding: EdgeInsets.only(left: 20),
               child: Row(
                 children: [


                   SizedBox(width: 15,),
                   Expanded(
                     child: InkWell(
                       onTap: () {
                         // Navigator.push(context, CupertinoPageRoute(builder: (_) =>  WebViewScreen(title:
                         // getTranslated('contact_us', context)),));

                         ///facebook app open function
                         Provider.of<ProfileProvider>(context,listen: false).openInstagram( context,'aosanonline');

                       },
                       child: Container(
                         margin: EdgeInsets.only(top: 20),
                         height: 50,
                         width: MediaQuery
                             .of(context)
                             .size
                             .width/1.1,
                         //color: Colors.red,
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [

                             Text(getTranslated('Our_page_On', context),style: robotoBold.copyWith(fontSize: 13),
                               textDirection: TextDirection.rtl,),
                             SizedBox(width: 15,),
                             Image.asset(Images.instagram,height: 30,),

                           ],
                         ),
                         decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(5),
                           border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
                         ),
                       ),
                     ),
                   ),
                   SizedBox(width: 15,),
                   Expanded(
                     child: Row(
                       children: [


                         Expanded(
                           child: InkWell(
                             onTap: () {
                               // Navigator.push(context, CupertinoPageRoute(builder: (_) =>  WebViewScreen(title:
                               // getTranslated('contact_us', context)),));

                               // ///facebook app open function
                               // Provider.of<ProfileProvider>(context,listen: false).openFacebook();
                               Provider.of<ProfileProvider>(context,listen: false).openDailPad();




                             },
                             child: Container(
                               margin: EdgeInsets.only(top: 20),
                               height: 50,
                               width: MediaQuery
                                   .of(context)
                                   .size
                                   .width/1.1,
                               //color: Colors.red,
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [

                                   Text(getTranslated('Call_Us', context),style: robotoBold.copyWith(fontSize: 15),
                                     textDirection: TextDirection.rtl,),
                                   SizedBox(width: 15,),
                                   Image.asset(Images.cal,height: 30,),

                                 ],
                               ),
                               decoration: BoxDecoration(
                                 color: Colors.white,
                                 borderRadius: BorderRadius.circular(5),
                                 border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
                               ),
                             ),
                           ),
                         ),





                       ],
                     ),
                   ),




                 ],
               ),
             ),


              ///contact us phone




              ///contact ust redirect to the web page
          /*    InkWell(
                onTap: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (_) =>  WebViewScreen(title:
                  getTranslated('contact_us', context), url: '',),));

                  ///whats app open function
                  // Provider.of<ProfileProvider>(context,listen: false).openWhatsapp(context: context, text: 'hello', number: '+967779922883');


                },
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 50,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width/1.1,
                  //color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text(getTranslated('contact_us', context),style: robotoBold.copyWith(fontSize: 15),
                        textDirection: TextDirection.rtl,),


                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
                  ),
                ),
              ),*/

              /// contact us
              //   Container(
            //
            //     child: Column(
            //       children: [
            //         SizedBox(height: 15,),
            //         Text( getTranslated('why_shopping_with_us', context),style:robotoRegular.copyWith(fontSize: 35,fontWeight: FontWeight.bold)),
            //         SizedBox(height: 15,),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //
            //           children: [
            //
            //             Expanded(child: Container(
            //               height: 100,
            //               width: 100,
            //
            //
            //
            //               decoration:shopWithUsDecoration,
            //               child: Column(
            //                 children: [
            //                   SvgPicture.asset(
            //
            //                       Images.del,
            //                       width: 70,
            //                       height: 70,
            //
            //                   ),
            //                   Spacer(),
            //                   Text('توصيل مجاني',style: robotoRegular.copyWith(fontWeight: FontWeight.bold)),
            //                   Spacer(),
            //
            //                 ],
            //               ),
            //             )),
            //             Expanded(child: Container(
            //               height: 100,
            //               width: 100,
            //
            //               decoration:BoxDecoration(
            //                 border: Border.all(
            //                   color: Colors.green.withOpacity(0.4),
            //                   width:0.5 ,
            //                 ),
            //               ),
            //               child: Column(
            //                 children: [
            //                   SvgPicture.asset(
            //
            //                       Images.sdr,
            //                       width: 70,
            //                       height: 70,
            //                       semanticsLabel: 'A red up arrow'
            //                   ),
            //
            //                   Spacer(),
            //                   Text('الدفع عند الاستلام',style: robotoRegular.copyWith(fontWeight: FontWeight.bold) ,),
            //                   Spacer(),
            //                 ],
            //               ),
            //             )),
            //             Expanded(child: Container(
            //               height: 100,
            //               width: 100,
            //
            //               decoration: shopWithUsDecoration,
            //               child: Column(
            //                 children: [
            //               SvgPicture.asset(
            //
            //                   Images.del2,
            //                   width: 70,
            //                   height: 70,
            //                 semanticsLabel: 'A red up arrow'
            //                      ),
            //
            //                   Spacer(),
            //                   Text(' خدمة الاسترجاع',style: robotoRegular.copyWith(fontWeight: FontWeight.bold) ,),
            //                   Spacer(),
            //
            //                 ],
            //               ),
            //             )),
            //
            // ],
            //         ),
            //       ],
            //     )
            //   ),


              ///version number
              Container(
                margin: EdgeInsets.only(top: 70),
                height: 40,
                width: MediaQuery
                    .of(context)
                    .size
                    .width/1.1,
                //color: Colors.red,
                child: Center(child: Text("ⓒ  اوسان 2023 . رقم الاصدار  ${ Provider.of<SplashProvider>(context,listen: false).packageInfo.buildNumber}", style:  robotoBold.copyWith(fontSize: 13),
                  textDirection: TextDirection.rtl,)),

              ) //version

            ],
          ),
        )
    );
  }
}
class TitleButton extends StatelessWidget {
  final String image;
  final String title;
  final Widget navigateTo;
  TitleButton({@required this.image, @required this.title, @required this.navigateTo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(image, width: 25, height: 25, fit: BoxFit.fill,
          color: ColorResources.getPrimary(context)),
      title: Text(title, style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
      onTap: () => Navigator.push(
        context, CupertinoPageRoute(builder: (_) => navigateTo),
      ),
    );
  }
}