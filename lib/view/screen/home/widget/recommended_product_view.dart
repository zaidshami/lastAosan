import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../helper/price_converter.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../provider/product_provider.dart';
import '../../../../provider/splash_provider.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../../view/basewidget/rating_bar.dart';
import '../../../../view/screen/product/product_details_screen.dart';
import 'package:provider/provider.dart';


class RecommendedProductView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<ProductProvider>(
          builder: (context, recommended, child) {
            String ratting = recommended.recommendedProduct != null && recommended.recommendedProduct.rating != null && recommended.recommendedProduct.rating.length != 0? recommended.recommendedProduct.rating[0].average : "0";

            return recommended.recommendedProduct != null?
            InkWell(
              onTap: () {

                Navigator.push(context, PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 1000),
                  pageBuilder: (context, anim1, anim2) => ProductDetails(product: recommended.recommendedProduct)));

              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      Text(getTranslated('recommended_product', context),
                        style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
                            fontWeight: FontWeight.bold
                        ),),
                      // Text(getTranslated('/${recommended.recommendedProduct.discountType}', context),
                      //   style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
                      //       fontWeight: FontWeight.bold
                      //   ),),

                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                      // AspectRatio(
                      //   aspectRatio: 16/9, //aspect ratio for Image
                      //   child: Image(
                      //     image: AssetImage('assets/img.png'),
                      //     fit: BoxFit.fill, //fill type of image inside aspectRatio
                      //   ),
                      // ),
                      Container(

                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      margin: EdgeInsets.only(bottom: 20.0),
                      height: 300,
                      child: Row(
                        children: <Widget>[
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: <Widget>[
                          //     Text(recommended.recommendedProduct.name??'',maxLines: 2,
                          //         textAlign: TextAlign.center,
                          //         overflow: TextOverflow.ellipsis,
                          //         style: titilliumRegular.copyWith(color:Colors.black,
                          //             fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                          //
                          //     SizedBox(
                          //       height: 10.0,
                          //     ),
                          //
                          //     SizedBox(
                          //       height: 10.0,
                          //     ),
                          //     Center(
                          //       child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                          //         children: [
                          //           // Text('${double.parse(ratting).toStringAsFixed(1)}'+ ' '+ '${getTranslated('out_of_5', context)}',
                          //           //     style: titilliumBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                          //           // Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                          //           //   children: [
                          //           //     RatingBar(rating: double.parse(ratting), size: 18,),
                          //           //     Text('(${ratting.toString()})')
                          //           //   ],
                          //           // ),  mohd rating
                          //
                          //
                          //           SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_EXTRA_SMALL),
                          //           recommended.recommendedProduct !=null && recommended.recommendedProduct.discount!= null && recommended.recommendedProduct.discount > 0  ? Text(
                          //             PriceConverter.convertPrice(context, recommended.recommendedProduct.unitPrice),
                          //             style: robotoBold.copyWith(
                          //               color: ColorResources.getRed(context),
                          //               decoration: TextDecoration.lineThrough,
                          //               fontSize: Dimensions.FONT_SIZE_SMALL,
                          //             ),
                          //           ) : SizedBox.shrink(),
                          //           SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_EXTRA_SMALL),
                          //           recommended.recommendedProduct != null && recommended.recommendedProduct.unitPrice != null?
                          //           Text(
                          //             PriceConverter.convertPrice(context, recommended.recommendedProduct.unitPrice,
                          //                 discountType: recommended.recommendedProduct.discountType,
                          //                 discount: recommended.recommendedProduct.discount),
                          //             style: titilliumSemiBold.copyWith(
                          //               color: Colors.red,
                          //               fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                          //             ),
                          //           ):SizedBox(),
                          //
                          //         ],),
                          //     ),
                          //
                          //     // Text( PriceConverter.convertPrice(context, recommended.recommendedProduct.unitPrice),
                          //     //   style: robotoBold.copyWith(
                          //     //     color: ColorResources.getRed(context),
                          //     //     decoration: TextDecoration.lineThrough,
                          //     //     fontSize: Dimensions.FONT_SIZE_SMALL,
                          //     //   ),),
                          //     // :SizedBox.shrink(),
                          //     SizedBox(
                          //       height: 10.0,
                          //     ),
                          //
                          //
                          //     //buy now
                          //     Container(width: 90,height: 35,
                          //       decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
                          //           color: Colors.grey.withOpacity(0.2)
                          //       ),
                          //       child: Center(child: Text(getTranslated('buy_now', context),
                          //         style:robotoBold.copyWith(
                          //
                          //           color: ColorResources.getRed(context),
                          //           decoration: TextDecoration.lineThrough,
                          //           fontSize: Dimensions.FONT_SIZE_DEFAULT,
                          //
                          //         ),)),),
                          //   ],
                          // ),
                          Expanded(

                              child:  recommended.recommendedProduct !=null && recommended.recommendedProduct.thumbnail !=null?
                          CachedNetworkImage(
                          errorWidget: (context, url, error) => Image.asset(
                        Images.placeholder,
                        fit: BoxFit.cover,
                      ),
                    placeholder: (context, url) => Image.asset(
                      Images.placeholder,
                      fit: BoxFit.cover,
                    ),
                    imageUrl:
                    '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productImageUrl}/${Provider.of<ProductProvider>(context, listen: false).recommendedProduct.productFrontImage[0]}',
                ):SizedBox()),
                          Expanded(
                            child:
                            Container(

                              padding: EdgeInsets.only(top:50.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(recommended.recommendedProduct.name??'',maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: titilliumRegular.copyWith(color:Colors.black,
                                        fontSize: Dimensions.FONT_SIZE_DEFAULT)),

                                  SizedBox(
                                    height: 10.0,
                                  ),

                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Center(
                                    child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        // Text('${double.parse(ratting).toStringAsFixed(1)}'+ ' '+ '${getTranslated('out_of_5', context)}',
                                        //     style: titilliumBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                                        // Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                                        //   children: [
                                        //     RatingBar(rating: double.parse(ratting), size: 18,),
                                        //     Text('(${ratting.toString()})')
                                        //   ],
                                        // ),  mohd rating


                                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_EXTRA_SMALL),
                                        recommended.recommendedProduct !=null && recommended.recommendedProduct.discount!= null && recommended.recommendedProduct.discount > 0  ? Text(
                                          PriceConverter.convertPrice(context, recommended.recommendedProduct.unitPrice),
                                          style: robotoBold.copyWith(
                                            color: ColorResources.getRed(context),
                                            decoration: TextDecoration.lineThrough,
                                            fontSize: Dimensions.FONT_SIZE_SMALL,
                                          ),
                                        ) : SizedBox.shrink(),
                                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_EXTRA_SMALL),
                                        recommended.recommendedProduct != null && recommended.recommendedProduct.unitPrice != null?
                                        Text(
                                          PriceConverter.convertPrice(context, recommended.recommendedProduct.unitPrice,
                                              discountType: recommended.recommendedProduct.discountType,
                                              discount: recommended.recommendedProduct.discount),
                                          style: titilliumSemiBold.copyWith(
                                            color: Colors.red,
                                            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                                          ),
                                        ):SizedBox(),

                                      ],),
                                  ),

                                  // Text( PriceConverter.convertPrice(context, recommended.recommendedProduct.unitPrice),
                                  //   style: robotoBold.copyWith(
                                  //     color: ColorResources.getRed(context),
                                  //     decoration: TextDecoration.lineThrough,
                                  //     fontSize: Dimensions.FONT_SIZE_SMALL,
                                  //   ),),
                                      // :SizedBox.shrink(),
                                  SizedBox(
                                    height: 10.0,
                                  ),


                                //buy now
                                  Container(width: 90,height: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
                                      color: Colors.grey.withOpacity(0.2)
                                    ),
                                    child: Center(child: Text(getTranslated('buy_now', context),
                                      style:robotoBold.copyWith(

                                        color: ColorResources.getRed(context),
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: Dimensions.FONT_SIZE_DEFAULT,

                                      ),)),),
                                ],
                              ),
                              margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(5.0, 5.0),
                                        blurRadius: 10.0)
                                  ]),
                            ),
                          ),

                        ],
                      ),
                    ),

                      //the old recomended
                      // Stack(
                      //   children: [
                      //     Container(
                      //       width: MediaQuery.of(context).size.width,
                      //       height: 260,
                      //       decoration: BoxDecoration(
                      //         color: Theme.of(context).cardColor
                      //       ),
                      //     ), // the outer
                      //     Positioned(
                      //       bottom: 0,
                      //       child: Container(
                      //         width: MediaQuery.of(context).size.width-35,
                      //         height: 120,
                      //         decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      //                 bottomRight: Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
                      //             color: Theme.of(context).primaryColor
                      //         ),
                      //       ),
                      //     ),
                      //
                      //     //the image
                      //     recommended.recommendedProduct !=null && recommended.recommendedProduct.thumbnail !=null?
                      //     Positioned(
                      //       left: 15,
                      //       top: 15,
                      //       child: Column(
                      //         children: [Container(width: MediaQuery.of(context).size.width/2.5,
                      //           height: MediaQuery.of(context).size.width/2.5,
                      //             decoration: BoxDecoration(
                      //               color: Theme.of(context).highlightColor,
                      //                 border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.20),width: .5),
                      //                 borderRadius: BorderRadius.all(Radius.circular(5))),
                      //             child: ClipRRect(
                      //               borderRadius: BorderRadius.all(Radius.circular(5)),
                      //               child: FadeInImage.assetNetwork(
                      //                 placeholder: Images.placeholder, fit: BoxFit.cover,
                      //                 image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls.productThumbnailUrl}'
                      //                     '/${recommended.recommendedProduct.thumbnail}',
                      //                 imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, fit: BoxFit.cover),
                      //               ),
                      //             ),
                      //           ),
                      //           Container(width: MediaQuery.of(context).size.width/2.5,
                      //               padding: EdgeInsets.only(left: 2,top: 10),
                      //               child: Center(
                      //                 child: Text(recommended.recommendedProduct.name??'',maxLines: 2,
                      //                     textAlign: TextAlign.center,
                      //                     overflow: TextOverflow.ellipsis,
                      //                     style: titilliumRegular.copyWith(color: Theme.of(context).cardColor,
                      //                         fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                      //               )),
                      //         ],
                      //       ),
                      //     ):SizedBox(),
                      //
                      //     Positioned(right: 0,top: 0,
                      //       child: Container(width: MediaQuery.of(context).size.width/2.5,
                      //         height: MediaQuery.of(context).size.width/2.5,
                      //         child:
                      //       Center(
                      //         child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                      //           children: [
                      //           Text('${double.parse(ratting).toStringAsFixed(1)}'+ ' '+ '${getTranslated('out_of_5', context)}',
                      //               style: titilliumBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                      //             Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                      //               children: [
                      //                 RatingBar(rating: double.parse(ratting), size: 18,),
                      //                 Text('(${ratting.toString()})')
                      //               ],
                      //             ),
                      //
                      //           SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_EXTRA_SMALL),
                      //           recommended.recommendedProduct !=null && recommended.recommendedProduct.discount!= null && recommended.recommendedProduct.discount > 0  ? Text(
                      //             PriceConverter.convertPrice(context, recommended.recommendedProduct.unitPrice),
                      //             style: robotoBold.copyWith(
                      //               color: ColorResources.getRed(context),
                      //               decoration: TextDecoration.lineThrough,
                      //               fontSize: Dimensions.FONT_SIZE_SMALL,
                      //             ),
                      //           ) : SizedBox.shrink(),
                      //           SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_EXTRA_SMALL),
                      //           recommended.recommendedProduct != null && recommended.recommendedProduct.unitPrice != null?
                      //           Text(
                      //             PriceConverter.convertPrice(context, recommended.recommendedProduct.unitPrice,
                      //                 discountType: recommended.recommendedProduct.discountType,
                      //                 discount: recommended.recommendedProduct.discount),
                      //             style: titilliumSemiBold.copyWith(
                      //               color: ColorResources.getPrimary(context),
                      //               fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                      //             ),
                      //           ):SizedBox(),
                      //
                      //         ],),
                      //       ),),
                      //     ),
                      //
                      //
                      //     Positioned(
                      //       right: 25,bottom: 70,
                      //       child: Container(width: 110,height: 35,
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
                      //         color: Theme.of(context).cardColor.withOpacity(.25),
                      //       ),
                      //       child: Center(child: Text(getTranslated('buy_now', context),
                      //         style: TextStyle(color: Theme.of(context).cardColor),)),),
                      //     ),
                      //
                      //
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ):SizedBox();

          },
        ),
      ],
    );
  }


}

