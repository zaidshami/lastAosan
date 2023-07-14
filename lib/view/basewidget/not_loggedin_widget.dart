import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../provider/auth_provider.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../../view/basewidget/button/custom_button.dart';
import '../../../../view/screen/auth/auth_screen.dart';
import 'package:provider/provider.dart';

import '../../utill/app_constants.dart';

class NotLoggedInWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Padding(
        padding: EdgeInsets.all(_height*0.025),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WhyShoppingWithUs(),
            SizedBox(height: _height*0.1),
            Text(getTranslated('PLEASE_LOGIN_FIRST', context), textAlign: TextAlign.center, style: titilliumSemiBold.copyWith(fontSize: _height*0.017)),
            SizedBox(height: _height*0.05),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
              child: Container(
                width: MediaQuery.of(context).size.width/2,
                child: CustomButton(
                  buttonText: getTranslated('LOGIN', context),
                  onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => AuthScreen())),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Provider.of<AuthProvider>(context, listen: false).updateSelectedIndex(1);
                Navigator.push(context, CupertinoPageRoute(builder: (context) => AuthScreen(initialPage: 1)));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: _height*0.02),
                child: Text(getTranslated('create_new_account', context), style: titilliumRegular.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontSize: Dimensions.FONT_SIZE_SMALL,
                )),
              ),
            ),
          ],
        ));
  }
}

class WhyShoppingWithUs extends StatelessWidget {
  const WhyShoppingWithUs({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

        child: Column(
          children: [
            SizedBox(height: 15,),
            Text( getTranslated('why_shopping_with_us', context),style:robotoRegular.copyWith(fontSize: 25,fontWeight: FontWeight.bold)),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                Expanded(child: Container(
                  height: 107,
                  width: 107,



                  decoration:shopWithUsDecoration,
                  child: Column(
                    children: [
                      SvgPicture.asset(

                        Images.del,
                        width: 70,
                        height: 70,

                      ),

                      Text('توصيل مجاني',style: robotoRegular.copyWith(fontWeight: FontWeight.bold)),

                    ],
                  ),
                )),
                Expanded(child: Container(
                  height: 107,
                  width: 107,

                  decoration:BoxDecoration(
                    border: Border.all(
                      color: Colors.green.withOpacity(0.4),
                      width:0.5 ,
                    ),
                  ),
                  child: Column(
                    children: [
                      SvgPicture.asset(

                          Images.sdr,
                          width: 70,
                          height: 70,
                         // semanticsLabel: 'A red up arrow'
                      ),


                      Text('الدفع عند الاستلام',textAlign: TextAlign.center,style: robotoRegular.copyWith(fontWeight: FontWeight.bold) ,),

                    ],
                  ),
                )),
                Expanded(child: Container(
                  height: 107,
                  width: 107,

                  decoration: shopWithUsDecoration,
                  child: Column(
                    children: [
                      SvgPicture.asset(

                          Images.del2,
                          width: 70,
                          height: 70,
                         // semanticsLabel: 'A red up arrow'
                      ),


                      Text(' خدمة الاسترجاع',style: robotoRegular.copyWith(fontWeight: FontWeight.bold) ,),


                    ],
                  ),
                )),

              ],
            ),
          ],
        )
    );
  }
}
