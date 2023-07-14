

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/model/response/product_model.dart';
import '../../../../helper/price_converter.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../provider/product_provider.dart';
import '../../../../provider/splash_provider.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../../utill/math_utils.dart';
import '../../product/product_details_screen.dart';



class RecommendedProductCard1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Product recommendedProduct = Provider.of<ProductProvider>(context, listen: false).recommendedProduct;
    double cardWidth = MediaQuery.of(context).size.width * 0.8;
    double cardHeight = MediaQuery.of(context).size.height * 0.6;
    return Container(
      width: cardWidth,
      height: cardHeight,
      margin: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                getTranslated('recommended_product', context),
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.1)
                ),
                child: CachedNetworkImage(
                  errorWidget: (context, url, error) => Image.asset(
                    Images.placeholder,
                    fit: BoxFit.cover,
                  ),
                  placeholder: (context, url) => Image.asset(
                    Images.placeholder,
                    fit: BoxFit.fill,
                  ),
                  imageUrl:
                  '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productImageUrl}/${recommendedProduct.productFrontImage[0]}',
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
          Padding(
            padding: getPadding(top: 15,bottom: 15,left: 5,right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [

                  Text(
                    recommendedProduct.name ?? '',
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(

                    PriceConverter.convertPrice(
                      context,
                      recommendedProduct.unitPrice,
                      discountType: recommendedProduct.discountType,
                      discount: recommendedProduct.discount,
                    ),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                ],),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Text(
                    recommendedProduct.desc ?? '',
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Tajawal',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),


                ],),
                SizedBox(height: 5,),

                //BUY NOW BOTTON
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => ProductDetails(product: recommendedProduct),
                        ),
                      );
                    },//Center(child: Text(getTranslated('buy_now', context))
                    child: Text(getTranslated('buy_now', context), ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      textStyle: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 32.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*

class FixedCard extends StatefulWidget {
  final Color color;
  final String num;
  final String numEng;
  final String content;

  FixedCard(this.color, this.num, this.numEng, this.content);

  @override
  _FixedCardState createState() => _FixedCardState();
}

class _FixedCardState extends State<FixedCard> {
  var padding = 150.0;
  var bottomPadding = 0.0;
  int i =1  ;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),

      child: i == 0 ?
      Column(
        // alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 0, bottom: 0),

            child: Container(
              width: MediaQuery.of(context).size.width,

              child: TopCardItem(
                widget.color,
                widget.num,
                widget.numEng,
                widget.content,
                    () {
                  setState(() {
                    padding = padding == 0 ? 150.0 : 0.0;
                    bottomPadding = bottomPadding == 0 ? 0 : 0.0;
                  });
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(

              margin: EdgeInsets.only(right: 20, left: 20),
              height: 500,
              decoration: BoxDecoration(
                color: Colors.grey.shade200.withOpacity(1.0),
                borderRadius:
                BorderRadius.vertical(bottom: Radius.circular(0),top: Radius.circular(0)),
              ),
              child: CachedNetworkImage(
                errorWidget: (context, url, error) => Image.asset(
                  Images.placeholder,
                  fit: BoxFit.cover,
                ),
                placeholder: (context, url) => Image.asset(
                  Images.placeholder,
                  fit: BoxFit.fill,
                ),
                imageUrl:
                '${Provider.of<SplashProvider>(context,listen: false).baseUrls.productThumbnailUrl}'
                    '/${Provider.of<ProductProvider>(context, listen: false)
                    .recommendedProduct.thumbnail}'
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0, bottom: 0),
            // duration: Duration(milliseconds: 5000),
            // curve: Curves.fastLinearToSlowEaseIn,
            child: Container(

              child: BottomCardItem(
                widget.color,
                widget.num,
                widget.numEng,
                widget.content,
                    () {
                  setState(() {
                    padding = padding == 0 ? 150.0 : 0.0;
                    bottomPadding = bottomPadding == 0 ? 0 : 0.0;
                  });
                },
              ),
            ),
          ),
        ],
      ):

      Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade400.withOpacity(1.0),
          borderRadius:
          BorderRadius.vertical(bottom: Radius.circular(30), top: Radius.circular(30)),
        ),

        child: Column(
          children: [
            SizedBox(height: 10,),
            Center(child:
            Text(
                getTranslated('recommended_product', context),
                style:titilliumBold.copyWith(fontSize: 20,color: Colors.black)
            ),),
             Align(
              alignment: Alignment.bottomCenter,
              child: Container(

                margin: EdgeInsets.only(right: 30, left: 30),
                height: 500,

                child: CachedNetworkImage(
                    errorWidget: (context, url, error) => Image.asset(
                      Images.placeholder,
                      fit: BoxFit.contain,
                    ),
                    placeholder: (context, url) => Image.asset(
                      Images.placeholder,
                      fit: BoxFit.cover,
                    ),
                    imageUrl:
                    '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productImageUrl}/${Provider.of<ProductProvider>(context, listen: false).recommendedProduct.productFrontImage[0]}',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 100,
              decoration: BoxDecoration(
                         borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [

                        Text(Provider.of<ProductProvider>(context, listen: false).recommendedProduct.name??'',maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: titilliumRegular.copyWith(color:Colors.black,
                                fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                        Spacer(),
                        Column(
                          children: [
                            Provider.of<ProductProvider>(context, listen: false).recommendedProduct !=null && Provider.of<ProductProvider>(context, listen: false).recommendedProduct.discount!= null && Provider.of<ProductProvider>(context, listen: false).recommendedProduct.discount > 0  ? Text(
                              PriceConverter.convertPrice(context, Provider.of<ProductProvider>(context, listen: false).recommendedProduct.unitPrice),
                              style: robotoBold.copyWith(
                                color: ColorResources.getRed(context),
                                decoration: TextDecoration.lineThrough,
                                fontSize: Dimensions.FONT_SIZE_SMALL,
                              ),
                            ) : SizedBox.shrink(),
                            Provider.of<ProductProvider>(context, listen: false).recommendedProduct != null && Provider.of<ProductProvider>(context, listen: false).recommendedProduct.unitPrice != null?
                            Text(
                              PriceConverter.convertPrice(context, Provider.of<ProductProvider>(context, listen: false).recommendedProduct.unitPrice,
                                  discountType: Provider.of<ProductProvider>(context, listen: false).recommendedProduct.discountType,
                                  discount: Provider.of<ProductProvider>(context, listen: false).recommendedProduct.discount),
                              style: titilliumSemiBold.copyWith(
                                color: Colors.redAccent,
                                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                              ),
                            ):SizedBox(),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 1000),
                            pageBuilder: (context, anim1, anim2) => ProductDetails(product: Provider.of<ProductProvider>(context, listen: false).recommendedProduct)));
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 40,right: 40),
                        width: MediaQuery.of(context).size.width,height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
                            color: Colors.black
                        ),
                        child: Center(child: Text(getTranslated('buy_now', context),
                          style:robotoBold.copyWith(
                            color: ColorResources.getRed(context),
                            decoration: TextDecoration.lineThrough,
                            fontSize: Dimensions.FONT_SIZE_DEFAULT,
                          ),)),),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class BottomCardItem extends StatelessWidget {
  final Color color;
  final String num;
  final String numEng;
  final String content;
  final onTap;
  BottomCardItem(this.color, this.num, this.numEng, this.content, this.onTap);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        height: 100,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey.shade200.withOpacity(1.0),
          borderRadius:
          BorderRadius.vertical(bottom: Radius.circular(30)),

        ),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Text(Provider.of<ProductProvider>(context, listen: false).recommendedProduct.name??'',maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: titilliumRegular.copyWith(color:Colors.black,
                      fontSize: Dimensions.FONT_SIZE_DEFAULT)),
              Provider.of<ProductProvider>(context, listen: false).recommendedProduct !=null && Provider.of<ProductProvider>(context, listen: false).recommendedProduct.discount!= null && Provider.of<ProductProvider>(context, listen: false).recommendedProduct.discount > 0  ? Text(
                PriceConverter.convertPrice(context, Provider.of<ProductProvider>(context, listen: false).recommendedProduct.unitPrice),
                style: robotoBold.copyWith(
                  color: ColorResources.getRed(context),
                  decoration: TextDecoration.lineThrough,
                  fontSize: Dimensions.FONT_SIZE_SMALL,
                ),
              ) : SizedBox.shrink(),
              Provider.of<ProductProvider>(context, listen: false).recommendedProduct != null && Provider.of<ProductProvider>(context, listen: false).recommendedProduct.unitPrice != null?
              Text(
                PriceConverter.convertPrice(context, Provider.of<ProductProvider>(context, listen: false).recommendedProduct.unitPrice,
                    discountType: Provider.of<ProductProvider>(context, listen: false).recommendedProduct.discountType,
                    discount: Provider.of<ProductProvider>(context, listen: false).recommendedProduct.discount),
                style: titilliumSemiBold.copyWith(
                  color: Colors.redAccent,
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                ),
              ):SizedBox(),
              InkWell(
                onTap: (){
                  Navigator.push(context, PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 1000),
                      pageBuilder: (context, anim1, anim2) => ProductDetails(product: Provider.of<ProductProvider>(context, listen: false).recommendedProduct)));
                },
                child: Container(
                  width: 90,height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
                    color: Colors.black
                  ),
                  child: Center(child: Text(getTranslated('buy_now', context),
                    style:robotoBold.copyWith(
                      color: ColorResources.getRed(context),
                      decoration: TextDecoration.lineThrough,
                      fontSize: Dimensions.FONT_SIZE_DEFAULT,
                    ),)),),
              ),
            ],
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}


class TopCardItem extends StatelessWidget {

  final Color color;
  final String num;
  final String numEng;
  final String content;
  final onTap;

  TopCardItem(this.color, this.num, this.numEng, this.content, this.onTap);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        height: 35,
        width: width,
        decoration: BoxDecoration(


          color: Colors.grey.shade200.withOpacity(1.0),
          borderRadius:
          BorderRadius.vertical(top: Radius.circular(30)),

        ),
        child: Column(

          children: [

            Spacer(),
            Text(
                getTranslated('recommended_product', context),
                style:titilliumBold.copyWith(fontSize: 20,color: Colors.black)
            ),
Spacer(),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}*/
