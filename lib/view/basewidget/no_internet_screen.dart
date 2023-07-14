import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import 'not_loggedin_widget.dart';

class NoInternetOrDataScreen extends StatelessWidget {
  final bool isNoInternet;
  final Widget child;
  NoInternetOrDataScreen({@required this.isNoInternet, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // WhyShoppingWithUs(),f
            // Spacer(),
            Image.asset(isNoInternet ? Images.no_internet : Images.no_data2,
                width: 150, height: 150),
            Text(
                isNoInternet
                    ? getTranslated('OPPS', context)
                    : getTranslated('sorry', context),
                style: titilliumBold.copyWith(
                  fontSize: 30,
                  color: isNoInternet
                      ? Theme.of(context).textTheme.bodyText1.color
                      : ColorResources.getColombiaBlue(context),
                )),
            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            Text(
              isNoInternet
                  ? getTranslated('no_internet_connection', context)
                  : getTranslated("no_data_found", context),
              textAlign: TextAlign.center,
              style: titilliumRegular,
            ),
            SizedBox(height: 40),
            isNoInternet
                ? Container(
                    height: 45,
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: ColorResources.getYellow(context)),
                    child: TextButton(
                      onPressed: () async {
                        if (await Connectivity().checkConnectivity() !=
                            ConnectivityResult.none) {
                          Navigator.pushReplacement(context,
                              CupertinoPageRoute(builder: (_) => child));
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(getTranslated('RETRY', context),
                            style: titilliumSemiBold.copyWith(
                                color: Theme.of(context).highlightColor,
                                fontSize: Dimensions.FONT_SIZE_LARGE)),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
class NoAdressDataScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // WhyShoppingWithUs(),f
            // Spacer(),


            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            Text(


                  getTranslated("no_address_found", context),
              textAlign: TextAlign.center,
              style: titilliumRegular,
            ),
            SizedBox(height: 40),

          ],
        ),
      ),
    );
  }
}
