import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/view/basewidget/show_custom_snakbar.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';
import '../../utill/custom_themes.dart';
import '../screen/checkout/widget/shipping_method_bottom_sheet.dart';


class GravityCartd extends StatefulWidget {
  @override
  _GravityCartdState createState() => _GravityCartdState();
}

class _GravityCartdState extends State<GravityCartd> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return    InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        setState(() {
          isTapped = !isTapped;
          // if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
          //     showModalBottomSheet(
          //       context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
          //       builder: (context) => ShippingMethodBottomSheet(groupId: 'all_cart_group',sellerIndex: 0, sellerId: 1),
          //     );
          //   }else {
          //     showCustomSnackBar('not_logged_in', context);
          //   }

        });
      },
      child: Stack(
        children: [
          AnimatedContainer(

            margin: EdgeInsets.only(bottom: isTapped ? 0 : MediaQuery.of(context).size.shortestSide),
            duration: Duration(seconds: 1),
            curve: isTapped ? Curves.decelerate : Curves.ease,
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color:Colors.grey,
              //Color(0xffFF4E4E),
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.3),
                  blurRadius: 10,
                  offset: Offset(0, 7),
                ),
              ],
            ),
            child: isTapped? Center(child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Spacer(),
    Icon(isTapped ? Icons.arrow_downward : Icons.arrow_upward, color: Colors.white, size: 35,),
    Spacer(),
    Text('choose shipping method',style:titilliumBold.copyWith(fontSize: 20) ,),
    Spacer(),
    ],
    ),): Expanded(child: Column(
               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Spacer(),
                     Icon(isTapped ? Icons.arrow_downward : Icons.arrow_upward, color: Colors.white, size: 35,),
                     Spacer(),
                     Text('choose shipping method',style:titilliumBold.copyWith(fontSize: 20) ,),
                     Spacer(),
                   ],
                 ),
                 ShippingMethodBottomSheet(groupId:'all_cart_group',sellerIndex: 0,sellerId: 1,),

               ],
              ),),
          ),
        ],
      ),
    );
  }
}