import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/localization/language_constrants.dart';
import 'package:flutter_Aosan_ecommerce/view/basewidget/title_row.dart';
import 'package:provider/provider.dart';


import '../../../../utill/images.dart';
import '../../provider/flash_deal_provider.dart';
import '../../utill/custom_themes.dart';
import '../../utill/dimensions.dart';
import '../screen/flashdeal/flash_deal_screen.dart';
import '../screen/home/widget/flash_deals_view.dart';
import 'custom_grid.dart';





class EmptyCart extends StatelessWidget {
  const EmptyCart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [

              InkWell(
                  onTap: () {
                    // Provider.of<ProfileProvider>(context,listen: false).getUsermedium1();
                    //
                    //
                    // Navigator.push(context, CupertinoPageRoute(builder: (_) => ProfileScreen(),));
                  },
                  child: Container(

                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    //color: Colors.red,
                    height: 90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Spacer(flex:1),
                        CircleAvatar(

                            child: Image.asset(Images.empty_cart), minRadius: 30,maxRadius: 30,),
                        Spacer(flex:2),

                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(getTranslated('cart_is_empty_!', context), style: robotoBold.copyWith(fontSize: 20),),
                              Text(getTranslated('discover_more', context), style: robotoBold.copyWith(fontSize: 12,color: Colors.grey),),

                            ],
                          ),
                        ),
                        Spacer(flex:7),
                      ],
                    ),
                    decoration: BoxDecoration(
                      //color: Colors.white,
                      border: Border(
                        top:BorderSide(
                        color: Colors.grey.withOpacity(0.1),
    width: 1,
    ) ,
                        bottom: BorderSide(
                          color: Colors.grey.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                    ),
                  ),

                ),
          // CustomGrid(),
          Consumer<FlashDealProvider>(
            builder: (context, flashDeal, child) {
              return (flashDeal.flashDeal != null &&
                  flashDeal.flashDealList != null &&
                  flashDeal.flashDealList.length > 0)
                  ? Container(
                padding: EdgeInsets.only(top: 10,left:10,right: 10),
                child: Column(
                  children: [
                    // TitleRow(
                    //     title:Provider.of<FlashDealProvider>(context).flashDeal.title,
                    //     onTap: () => Navigator.push(
                    //         context,
                    //         CupertinoPageRoute(
                    //             builder: (_) =>
                    //                 FlashDealScreen()))),
                    SizedBox(
                        height:
                        Dimensions.HOME_PAGE_PADDING),
                    Container(
                      child: Column(
                        children: [
                          Consumer<FlashDealProvider>(
                            builder:
                                (context, megaDeal, child) {
                              return (megaDeal.flashDeal !=
                                  null &&
                                  megaDeal.flashDealList !=
                                      null &&
                                  megaDeal.flashDealList
                                      .length >
                                      0)
                                  ? Container(
                                  height: 413,
                                  child:
                                  FlashDealsView())
                                  : SizedBox.shrink();
                            },
                          ),
                        ],
                      ),
                      //color: Theme.of(context).primaryColor.withOpacity(0.2),
                    ),
                  ],
                ),
              )
                  : SizedBox.shrink();
            },
          )




        ],
      );

  }
}
