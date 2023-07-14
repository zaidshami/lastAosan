import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/utill/math_utils.dart';
import '../../../../helper/price_converter.dart';
import '../../../../provider/flash_deal_provider.dart';
import '../../../../provider/splash_provider.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../../view/screen/product/product_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../localization/language_constrants.dart';
import '../../../basewidget/title_row.dart';
import '../../flashdeal/flash_deal_screen.dart';
import 'featured_deal_view.dart';

class FlashDealsView extends StatelessWidget {
  final bool isHomeScreen;
  FlashDealsView({this.isHomeScreen = true});

  @override
  Widget build(BuildContext context) {
    return isHomeScreen
        ? Consumer<FlashDealProvider>(
            builder: (context, megaProvider, child) {

              double _width = MediaQuery.of(context).size.width;
              return Provider.of<FlashDealProvider>(context)
                          .flashDealList
                          .length !=
                      0
                  ? Column(
                    children: [
                    /// the title and the timer fixed note : if you want to make it with every single pic inside of an item of the listviewbuilder
                      InkWell(
                        onTap:(){Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (_) =>
                                    FlashDealScreen()));},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                Provider.of<FlashDealProvider>(context).flashDeal.title,style: robotoBold.copyWith(fontSize: 15),
                              ),
                            ),

                            Expanded(
                              child: TitleRow(
                                title: getTranslated(
                                    'flash_deal',
                                    context),
                                eventDuration:
                                megaProvider.flashDeal !=
                                    null
                                    ? megaProvider
                                    .duration
                                    : null,
                                isFlash: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            padding: EdgeInsets.all(0),
                            scrollDirection:
                                isHomeScreen ? Axis.horizontal : Axis.vertical,
                            itemCount: megaProvider.flashDealList.length == 0
                                ? 2
                                : megaProvider.flashDealList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: _width,

                                child: megaProvider.flashDealList != null
                                    ? megaProvider.flashDealList.length != 0
                                        ?     CarouselSlider.builder(

                                  options: CarouselOptions(
                                    enlargeFactor: 0.5,
                                    animateToClosest: true,
                                    autoPlayAnimationDuration: Duration(seconds:4),

                                    autoPlayInterval:Duration(seconds: 4),
                                    viewportFraction: .40,
                                    autoPlay: true,
                                    enlargeCenterPage: true,
                                    disableCenter: true,
                                    onPageChanged: (index, reason) {
                                      Provider.of<FlashDealProvider>(
                                          context,
                                          listen: false)
                                          .setCurrentIndex(index);
                                    },
                                  ),
                                  itemCount: megaProvider
                                      .flashDealList.length ==
                                      0
                                      ? 1
                                      : megaProvider
                                      .flashDealList.length,
                                  itemBuilder: (context, index, _) {
                                    return Column(
                                      children: [

                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  transitionDuration:
                                                  Duration(
                                                      seconds:
                                                      10),
                                                  pageBuilder: (context,
                                                      anim1, anim2) =>
                                                      ProductDetails(
                                                          product: megaProvider
                                                              .flashDealList[
                                                          index]),
                                                ));
                                          },
                                          child: Container(

                                            margin: EdgeInsets.all(2),

                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    10),
                                                color: Theme.of(context)
                                                    .highlightColor,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.redAccent
                                                          .withOpacity(0.3),
                                                      spreadRadius: 1,
                                                      blurRadius: 1)
                                                ]),
                                            child: Stack(children: [
                                              Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .stretch,
                                                  children: [

                                                    Container(

                                                      height: 200,
                                                      decoration:
                                                      BoxDecoration(
                                                        border: Border.all(
                                                            color: Theme.of(context).primaryColor.withOpacity(.2), width: .1),
                                                        color: ColorResources.getIconBg(context),
                                                        borderRadius: BorderRadius.all(Radius.circular(10)),),
                                                      child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(10)),
                                                        child:
                                                        CachedNetworkImage(
                                                          fit: BoxFit.contain,
                                                          errorWidget: (context, url, error) =>
                                                              Image.asset(Images.placeholder, fit: BoxFit.cover,height: _width*.50,),
                                                          placeholder: (context,
                                                              url) =>
                                                              Image.asset(Images.placeholder, fit: BoxFit.contain, height: _width * .50,),
                                                          imageUrl:

                                                          '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productImageUrl}'
                                                              '/${megaProvider.flashDealList[index].productFrontImage[0]}',
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets
                                                          .all(Dimensions
                                                          .PADDING_SIZE_SMALL),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                            megaProvider
                                                                .flashDealList[
                                                            index]
                                                                .name,
                                                            style:
                                                            robotoBold.copyWith(fontSize: 12),
                                                            maxLines: 2,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                          ),
                                                          SizedBox(
                                                              height: Dimensions
                                                                  .PADDING_SIZE_EXTRA_SMALL),
                                                          Row(children: [

                                                            Text(
                                                              megaProvider.flashDealList[index].discount >
                                                                  0
                                                                  ? PriceConverter.convertPrice(
                                                                  context,
                                                                  megaProvider
                                                                      .flashDealList[index]
                                                                      .unitPrice)
                                                                  : '',
                                                              style: robotoBold1
                                                                  .copyWith(
                                                                color: ColorResources
                                                                    .HINT_TEXT_COLOR,
                                                                decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                                fontSize:
                                                                Dimensions
                                                                    .FONT_SIZE_EXTRA_SMALL,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: Dimensions
                                                                    .PADDING_SIZE_SMALL),

                                                            Text(

                                                              PriceConverter.convertPrice(
                                                                  context,
                                                                  megaProvider
                                                                      .flashDealList[
                                                                  index]
                                                                      .unitPrice,
                                                                  discountType: megaProvider
                                                                      .flashDealList[
                                                                  index]
                                                                      .discountType,
                                                                  discount: megaProvider
                                                                      .flashDealList[
                                                                  index]
                                                                      .discount),

                                                              style: robotoBold
                                                                  .copyWith(
                                                                  fontSize: 12,
                                                                  color:
                                                                  ColorResources.getPrimary(context)),
                                                            ),
                                                          ]),
                                                        ],
                                                      ),
                                                    ),

                                                  ]),
                                              megaProvider
                                                  .flashDealList[
                                              index]
                                                  .discount >=
                                                  1
                                                  ? Positioned(
                                                top: 0,
                                                left: 0,
                                                child: Container(
                                                  padding: EdgeInsets
                                                      .symmetric(
                                                      horizontal:
                                                      Dimensions
                                                          .PADDING_SIZE_SMALL),
                                                  height: 25,
                                                  alignment: Alignment
                                                      .center,
                                                  decoration:
                                                  BoxDecoration(
                                                    color: ColorResources
                                                        .getPrimary(
                                                        context),
                                                    borderRadius: BorderRadius.only(
                                                        topLeft: Radius
                                                            .circular(
                                                            10),
                                                        bottomRight: Radius
                                                            .circular(
                                                            10)),
                                                  ),
                                                  child: Text(
                                                    PriceConverter
                                                        .percentageCalculation(
                                                      context,
                                                      megaProvider
                                                          .flashDealList[
                                                      index]
                                                          .unitPrice,
                                                      megaProvider
                                                          .flashDealList[
                                                      index]
                                                          .discount,
                                                      megaProvider
                                                          .flashDealList[
                                                      index]
                                                          .discountType,
                                                    ),
                                                    style: robotoRegular.copyWith(
                                                        color: Theme.of(
                                                            context)
                                                            .highlightColor,
                                                        fontSize:
                                                        Dimensions
                                                            .FONT_SIZE_SMALL),
                                                  ),
                                                ),
                                              )
                                                  : SizedBox.shrink(),
                                            ]),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                )
                                        : SizedBox()
                                    : Shimmer.fromColors(
                                        baseColor: Colors.grey[300],
                                        highlightColor: Colors.grey[100],
                                        enabled: megaProvider.flashDealList == null,
                                        child: Container(
                                            margin:
                                                EdgeInsets.symmetric(horizontal: 10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: ColorResources.WHITE,
                                            )),
                                      ),
                              );
                            },
                          ),
                      ),
                    ],
                  )
                  : MegaDealShimmer(isHomeScreen: isHomeScreen);
            },
          )
        : Consumer<FlashDealProvider>(
            builder: (context, megaProvider, child) {
              return Provider.of<FlashDealProvider>(context)
                          .flashDealList
                          .length !=
                      0
                  ? ListView.builder(
                      padding: EdgeInsets.all(0),
                      scrollDirection:
                          isHomeScreen ? Axis.horizontal : Axis.vertical,
                      itemCount: megaProvider.flashDealList.length == 0
                          ? 2
                          : megaProvider.flashDealList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 4000),
                                  pageBuilder: (context, anim1, anim2) =>
                                      ProductDetails(
                                          product: megaProvider
                                              .flashDealList[index]),
                                ));
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            width: isHomeScreen ? 300 : null,
                            height: 230,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).highlightColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 5)
                                ]),
                            child: Stack(children: [
                              Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        padding: EdgeInsets.all(
                                            Dimensions.PADDING_SIZE_SMALL),
                                        decoration: BoxDecoration(
                                          color:
                                              ColorResources.getIconBg(context),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10)),
                                        ),
                                        child: FadeInImage.assetNetwork(
                                          placeholder: Images.placeholder,
                                          fit: BoxFit.cover,
                                          image:'${Provider.of<SplashProvider>(context, listen: false).baseUrls.productImageUrl}'
                                              '/${megaProvider.flashDealList[index].productFrontImage[0]}',
                                          imageErrorBuilder: (c, o, s) =>
                                              Image.asset(Images.placeholder,
                                                  fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            Dimensions.PADDING_SIZE_SMALL),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              megaProvider
                                                  .flashDealList[index].name,
                                              style: robotoBold,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(
                                              height: Dimensions
                                                  .PADDING_SIZE_DEFAULT,
                                            ),

                                            Row(
                                              children: [
                                                Text(
                                                  megaProvider
                                                              .flashDealList[
                                                                  index]
                                                              .discount >
                                                          0
                                                      ? PriceConverter
                                                          .convertPrice(
                                                              context,
                                                              megaProvider
                                                                  .flashDealList[
                                                                      index]
                                                                  .unitPrice)
                                                      : '',
                                                  style: robotoBold.copyWith(
                                                    color:
                                                        ColorResources.getRed(
                                                            context),
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    fontSize: Dimensions
                                                        .FONT_SIZE_SMALL,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Dimensions
                                                      .PADDING_SIZE_DEFAULT,
                                                ),
                                                Text(
                                                  PriceConverter.convertPrice(
                                                      context,
                                                      megaProvider
                                                          .flashDealList[index]
                                                          .unitPrice,
                                                      discountType: megaProvider
                                                          .flashDealList[index]
                                                          .discountType,
                                                      discount: megaProvider
                                                          .flashDealList[index]
                                                          .discount),
                                                  style: robotoRegular.copyWith(
                                                      color: ColorResources
                                                          .getPrimary(context),
                                                      fontSize: Dimensions
                                                          .FONT_SIZE_LARGE),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height: Dimensions
                                                    .PADDING_SIZE_EXTRA_SMALL),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]),

                              // Off
                              megaProvider.flashDealList[index].discount >= 1
                                  ? Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Container(
                                        height: 20,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: ColorResources.getPrimary(
                                              context),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Dimensions
                                                  .PADDING_SIZE_SMALL),
                                          child: Text(
                                            PriceConverter
                                                .percentageCalculation(
                                              context,
                                              megaProvider.flashDealList[index]
                                                  .unitPrice,
                                              megaProvider.flashDealList[index]
                                                  .discount,
                                              megaProvider.flashDealList[index]
                                                  .discountType,
                                            ),
                                            style: robotoRegular.copyWith(
                                                color: Theme.of(context)
                                                    .highlightColor,
                                                fontSize:
                                                    Dimensions.FONT_SIZE_SMALL),
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                            ]),
                          ),
                        );
                      },
                    )
                  : MegaDealShimmer(isHomeScreen: isHomeScreen);
            },
          );
  }
}
