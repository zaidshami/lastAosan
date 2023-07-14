import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/provider/facebook_login_provider.dart';
import 'package:flutter_Aosan_ecommerce/provider/google_sign_in_provider.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../provider/auth_provider.dart';
import '../../../../provider/profile_provider.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../../view/screen/auth/auth_screen.dart';
import 'package:provider/provider.dart';

class DeleteAccountConfirmationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [

        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE, vertical: 50),
          child: Text(getTranslated('want_to_delete_account', context), style: robotoBold, textAlign: TextAlign.center),
        ),

        Divider(height: 0, color: ColorResources.HINT_TEXT_COLOR),
        Row(children: [

          Expanded(child: InkWell(
            onTap: () {

              print("emailss" + Provider.of<ProfileProvider>(context,listen: false).userInfoModel.email);
              Provider.of<AuthProvider>(context, listen: false).clearSharedData().then((condition) {
                Navigator.pop(context);
                Provider.of<ProfileProvider>(context,listen: false).clearHomeAddress();
                Provider.of<ProfileProvider>(context,listen: false).clearOfficeAddress();
                Provider.of<ProfileProvider>(context,listen: false).removeUsermedium(context);
                Provider.of<GoogleSignInProvider>(context,listen: false).deleteAccount( Provider.of<ProfileProvider>(context,listen: false).userInfoModel.email);

                ///mohd



                Provider.of<AuthProvider>(context,listen: false).clearSharedData();
                Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => AuthScreen()), (route) => false);
              });
            },
            child: Container(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              alignment: Alignment.center,
              decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10))),
              child: Text(getTranslated('YES', context), style: titilliumBold.copyWith(color: Theme.of(context).primaryColor)),
            ),
          )),

          Expanded(child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: ColorResources.RED, borderRadius: BorderRadius.only(bottomRight: Radius.circular(10))),
              child: Text(getTranslated('NO', context), style: titilliumBold.copyWith(color: ColorResources.WHITE)),
            ),
          )),

        ]),
      ]),
    );
  }
}
