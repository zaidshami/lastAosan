import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/utill/math_utils.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../helper/price_converter.dart';
import '../../../../provider/featured_deal_provider.dart';
import '../../../../provider/splash_provider.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../product/product_details_screen.dart';

class FeaturedDealsView extends StatelessWidget {
  final bool isHomePage;
  FeaturedDealsView({this.isHomePage = true});

  @override
  Widget build(BuildContext context) {
  //Todo : take the way that you converted the featured deal from here to the rest of the categories 
    return Consumer<FeaturedDealProvider>(
      builder: (context, featuredDealProvider, child) {
        return featuredDealProvider.featuredDealProductList.length > 0 ?
        (isHomePage? ListView.builder(
            semanticChildCount: 2,
          padding: EdgeInsets.all(3),
          scrollDirection:isHomePage ?Axis.horizontal:Axis.vertical,
          shrinkWrap: false,
          //physics: NeverScrollableScrollPhysics(),
          itemCount: featuredDealProvider.featuredDealProductList.length <20 && isHomePage ?
          featuredDealProvider.featuredDealProductList.length :featuredDealProvider.featuredDealProductList.length >20 && isHomePage?20: featuredDealProvider.featuredDealProductList.length,
          itemBuilder: (context, index) {
            // print('---ff-------${featuredDealProvider.featuredDealProductList[index].id}-=====================>${featuredDealProvider.featuredDealProductList[0].name}');
            return InkWell(
              onTap: () {
                Navigator.push(context, PageRouteBuilder(transitionDuration: Duration(milliseconds: 1000),
                  pageBuilder: (context, anim1, anim2) => ProductDetails(product: featuredDealProvider.featuredDealProductList[index]),
                ));
              },
              child: Container(
                //todo : here convert the height into percentage instad of the numbers


                width: isHomePage ?  MediaQuery.of(context).size.width/2.2 :  MediaQuery.of(context).size.width/2.5,
                height: isHomePage ? 200 : 300,
                decoration: BoxDecoration(

                  border: Border.all(width: 0.3,color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).highlightColor,

                ),
                child: Stack(
                    children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width/1.5,
                          width: MediaQuery.of(context).size.width/2.7,
                          decoration: BoxDecoration(
                            color: ColorResources.getIconBg(context),
                            borderRadius: BorderRadius.only(topLeft:Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              bottomLeft: Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),),
                          ),
                          child: ClipRRect(

                            borderRadius: BorderRadius.only(topLeft:Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              bottomLeft: Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),),
                            child: CachedNetworkImage(
                              errorWidget: (context, url, error) => Image.asset(
                                Images.placeholder,

                              ),
                              placeholder: (context, url) => Image.asset(
                                Images.placeholder,

                              ),
                              imageUrl: '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productImageUrl}''/${featuredDealProvider.featuredDealProductList[index].productFrontImage.first}',

                            ),



                          ),
                        ),
                        Divider()

                      ],
                    ),


                    Padding(
                      padding:getPadding(right:  Dimensions.PADDING_SIZE_SMALL , top: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            featuredDealProvider.featuredDealProductList[index].name,

                            style: robotoBold.copyWith(height: 1.3,fontSize: Dimensions.FONT_SIZE_SMALL),


                            maxLines: 1,

                            overflow: TextOverflow.ellipsis,
                          ),

                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                          Row(crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  featuredDealProvider.featuredDealProductList[index].discount > 0 ? PriceConverter.convertPrice(context, featuredDealProvider.featuredDealProductList[index].unitPrice.toDouble()) : '',
                                  style: titilliumSemiBold1.copyWith(
                                    color: ColorResources.getRed(context),

                                    decoration: TextDecoration.lineThrough,
                                    fontSize:10,
                                  ),
                                ),
                                featuredDealProvider.featuredDealProductList[index].discount > 0? SizedBox(width:7): SizedBox(),
                                Text(
                                  PriceConverter.convertPrice(context, featuredDealProvider.featuredDealProductList[index].unitPrice.toDouble(),
                                      discountType: featuredDealProvider.featuredDealProductList[index].discountType, discount: featuredDealProvider.featuredDealProductList[index].discount.toDouble()),
                                  style: robotoBold.copyWith(color: ColorResources.getPrimary(context),fontSize: 12),
                                ),


                              ]),
                        ],
                      ),
                    ),
                  ]),

                  // Off
                  featuredDealProvider.featuredDealProductList[index].discount > 0 ? Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      height: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ColorResources.getPrimary(context),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                      ),
                      child: Text(
                        PriceConverter.percentageCalculation(
                          context,
                          featuredDealProvider.featuredDealProductList[index].unitPrice.toDouble(),
                          featuredDealProvider.featuredDealProductList[index].discount.toDouble(),
                          featuredDealProvider.featuredDealProductList[index].discountType,
                        ),
                        style: robotoRegular.copyWith(color: Theme.of(context).highlightColor,
                            fontSize: Dimensions.FONT_SIZE_SMALL),
                      ),
                    ),
                  ) : SizedBox.shrink(),
                ]),

              ),
            );
          },
        ):
        StaggeredGridView.countBuilder(
          mainAxisSpacing : 5.0,
          crossAxisSpacing : 5.0,
          scrollDirection:isHomePage ?Axis.horizontal:Axis.vertical,
          // padding: EdgeInsets.symmetric(
          //     horizontal: Dimensions.PADDING_SIZE_SMALL),
          physics: BouncingScrollPhysics(),
          crossAxisCount: 2,
          itemCount: featuredDealProvider.featuredDealProductList.length >4 && isHomePage ?
          4 : featuredDealProvider.featuredDealProductList.length,
          shrinkWrap: true,
          staggeredTileBuilder: (int index) =>
              StaggeredTile.fit(1),
          itemBuilder: (BuildContext context, int index) {

            return InkWell(
              onTap: () {
                Navigator.push(context, PageRouteBuilder(transitionDuration: Duration(milliseconds: 1000),
                  pageBuilder: (context, anim1, anim2) => ProductDetails(product: featuredDealProvider.featuredDealProductList[index]),
                ));
              },
              child: Container(
                width: isHomePage ? 150 : 150,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).highlightColor,

                ),
                child: Stack(
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(

                              decoration: BoxDecoration(

                                borderRadius: BorderRadius.only(topLeft:Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  bottomLeft: Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(topLeft:Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  bottomLeft: Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),),
                                child: CachedNetworkImage(
                                  errorWidget: (context, url, error) => Image.asset(
                                    Images.placeholder,

                                  ),
                                  placeholder: (context, url) => Image.asset(
                                    Images.placeholder,

                                  ),
                                    imageUrl: '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productImageUrl}''/${featuredDealProvider.featuredDealProductList[index].productFrontImage.first}',

                                ),


                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    featuredDealProvider.featuredDealProductList[index].name,
                                    style: robotoBold.copyWith(height: 1.3,fontSize: Dimensions.FONT_SIZE_SMALL),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                                  Row(crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          featuredDealProvider.featuredDealProductList[index].discount > 0 ? PriceConverter.convertPrice(context, featuredDealProvider.featuredDealProductList[index].unitPrice.toDouble()) : '',
                                          style: robotoRegular.copyWith(
                                            color: ColorResources.getRed(context),
                                            decoration: TextDecoration.lineThrough,
                                            fontSize: Dimensions.FONT_SIZE_SMALL,
                                          ),
                                        ),
                                        featuredDealProvider.featuredDealProductList[index].discount > 0? SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT): SizedBox(),
                                        Text(
                                          PriceConverter.convertPrice(context, featuredDealProvider.featuredDealProductList[index].unitPrice.toDouble(),
                                              discountType: featuredDealProvider.featuredDealProductList[index].discountType, discount: featuredDealProvider.featuredDealProductList[index].discount.toDouble()),
                                          style: robotoBold.copyWith(color: ColorResources.getPrimary(context),fontSize: Dimensions.FONT_SIZE_LARGE),
                                        ),


                                      ]),
                                ],
                              ),
                            ),
                          ]),

                      // Off
                      featuredDealProvider.featuredDealProductList[index].discount > 0 ? Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          height: 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: ColorResources.getPrimary(context),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                          ),
                          child: Text(
                            PriceConverter.percentageCalculation(
                              context,
                              featuredDealProvider.featuredDealProductList[index].unitPrice.toDouble(),
                              featuredDealProvider.featuredDealProductList[index].discount.toDouble(),
                              featuredDealProvider.featuredDealProductList[index].discountType,
                            ),
                            style: robotoRegular.copyWith(color: Theme.of(context).highlightColor,
                                fontSize: Dimensions.FONT_SIZE_SMALL),
                          ),
                        ),
                      ) : SizedBox.shrink(),
                    ]),

              ),
            );
          },

        )) : MegaDealShimmer(isHomeScreen: isHomePage);
      },
    );
  }
}

class MegaDealShimmer extends StatelessWidget {
  final bool isHomeScreen;
  MegaDealShimmer({@required this.isHomeScreen});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: isHomeScreen ? Axis.horizontal : Axis.vertical,
      itemCount: 2,
      itemBuilder: (context, index) {

        return Container(
          margin: EdgeInsets.all(5),
          width: 300,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorResources.WHITE,
              boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 1, blurRadius: 5)]),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled: Provider.of<FeaturedDealProvider>(context).featuredDealProductList.length == 0,
            child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [

              Expanded(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                  decoration: BoxDecoration(
                    color: ColorResources.ICON_BG,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                  ),
                ),
              ),

              Expanded(
                flex: 6,
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 20, color: ColorResources.WHITE),
                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        Row(children: [
                          Expanded(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Container(height: 20, width: 50, color: ColorResources.WHITE),
                            ]),
                          ),
                          Container(height: 10, width: 50, color: ColorResources.WHITE),
                          Icon(Icons.star, color: Colors.orange, size: 15),
                        ]),
                      ]),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}

