import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/localization/language_constrants.dart';
import 'package:flutter_Aosan_ecommerce/provider/wishlist_provider.dart';
import 'package:flutter_Aosan_ecommerce/utill/math_utils.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import '../../data/model/response/product_model.dart';
import '../../helper/price_converter.dart';
import '../../provider/product_provider.dart';
import '../../provider/splash_provider.dart';
import '../../utill/color_resources.dart';
import '../../utill/custom_themes.dart';
import '../../utill/dimensions.dart';
import '../../utill/images.dart';
import '../screen/product/product_details_screen.dart';
import '../screen/product/widget/favourite_button.dart';

class ProductWidget extends StatefulWidget {
  final Product productModel;
  final PageController controller;
  final bool isSelected;

  ProductWidget(
      {@required this.productModel, this.controller, this.isSelected});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {

  List<String> get _inecatorlist=>widget.productModel.productFrontImage;
  int _selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 1000),
              pageBuilder: (context, anim1, anim2) =>
                  ProductDetails(product: widget.productModel),
            ));
      },
      child: Container(
        // height: MediaQuery.of(context).size.height ,
        margin: EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).highlightColor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5)
          ],
        ),
        child: Stack(
            fit : StackFit.loose,
            children: [
///product image
          Column(
            //  crossAxisAlignment: CrossAxisAlignment.end,
              children: [
            // Product Image
            Container(
              height:
              defaultTargetPlatform == TargetPlatform.android ?MediaQuery.of(context).size.height *0.41:
              defaultTargetPlatform == TargetPlatform.iOS?MediaQuery.of(context).size.height / 2.6:MediaQuery.of(context).size.height *0.41,
              decoration: BoxDecoration(
                color: ColorResources.getIconBg(context),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),

              child: StatefulBuilder(
                  builder: (context, _change) {
                    return Stack(
                      children: [
                        PageView.builder(
                          onPageChanged: (index) {
                            Provider.of<ProductProvider>(context, listen: false)
                                .setImageSliderSelectedIndex(index);

                            _change(()=>_selectedIndex=index);
                          },
                          itemCount: widget.productModel.productFrontImage.length,
                          controller: widget.controller,
                           itemBuilder: (context, index) {
                            // print(
                            //     'imgs ${Provider.of<SplashProvider>(context, listen: false).baseUrls.productImageUrl}/${widget.productModel.images[index]}');
                            return FittedBox(
                              //mohd11
                              fit: BoxFit.fill,
                              child: CachedNetworkImage(
                                errorWidget: (context, url, error) => Image.asset(
                                  Images.placeholder,
                                  fit: BoxFit.fill,
                                ),
                                placeholder: (context, url) => Image.asset(
                                  Images.placeholder,
                                  fit: BoxFit.fill,
                                ),
                                imageUrl:
                                '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productImageUrl}/${widget.productModel.productFrontImage[index]}',
                              ),
                            );
                          },
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: CustomIndecator(_selectedIndex,_inecatorlist),
                        )

                      ],
                    );
                  }
              ),
            ),

            // Product Details
            Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: Container(
                // height: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.productModel.name ?? '',
                        style: robotoBold,
                        maxLines: 1,
                        overflow: TextOverflow.fade),
                    Text(widget.productModel.desc ?? '',
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Tajawal',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                        softWrap: true,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    Row(
                      children: [
                        widget.productModel.discount > 0 &&
                            widget.productModel.discount != null
                            ? Text(
                          PriceConverter.convertPrice(
                              context, widget.productModel.unitPrice),
                          style: titilliumRegular1.copyWith(color: Colors.red,
                              decoration: TextDecoration.lineThrough),
                        )
                            : SizedBox.shrink(),
                        SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        Row(children: [
                          Text(
                            PriceConverter.convertPrice(
                                context, widget.productModel.unitPrice ?? 0.0,
                                discountType: widget.productModel.discountType,
                                discount: widget.productModel.discount),
                            style: robotoBold.copyWith(
                                color: ColorResources.getPrimary(context)),
                          ),
                        ]),

                      ],
                    ),

                  ],
                ),
              ),
            ),
          ]),

          // Off
          Positioned(
            right: (MediaQuery.of(context).size.width / 3) + 20,
            child: FavouriteButton(
              backgroundColor: ColorResources.getImageBg(context),
              favColor: Colors.redAccent,
              product: widget.productModel,
            ),
          ),


            widget.productModel.productType == ProductVarType.productWithColor && widget.productModel.productColorsList.length>1  ?
             Positioned(
            top: (MediaQuery.of(context).size.height / 3)+10,
            child: Center(
              child: Container(
                  //width: 30,
                  height: 40,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(Images.ColorsNo),
                      Container(
                        height: 15,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: Colors.white
                        ),
                        child: Center(
                          child:Text(
                            widget.productModel.productColorsList.length.toString()+" "+getTranslated("Color", context),
                            textAlign: TextAlign.center,
                            style: robotoBold.copyWith(
                              fontSize: 11,
                            ),
                          )
                        ),
                      )
                    ],
                  )),
            ),
          ):SizedBox(),


              widget.productModel.productType == ProductVarType.productWithColorSize && widget.productModel.productsizelist.length>1  ?
              Positioned(
                top: (MediaQuery.of(context).size.height / 3)+10,
                child: Center(
                  child: Container(
                    //width: 30,
                      height: 40,
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(Images.ColorsNo),
                          Container(
                            height: 15,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                color: Colors.white
                            ),
                            child: Center(
                                child:Text(
                                  widget.productModel.productsizelist.length.toString()+" "+getTranslated("Color", context),
                                  textAlign: TextAlign.center,
                                  style: robotoBold.copyWith(
                                    fontSize: 11,
                                  ),
                                )
                            ),
                          )
                        ],
                      )),
                ),
              ):SizedBox(),


          widget.productModel.discount >= 1
              ? Positioned(
            top: 0,
            right: 0,
            child: Container(
              height: 20,
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  // topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
              ),
              child: Center(
                child: Text(
                  PriceConverter.percentageCalculation(
                      context,
                      widget.productModel.unitPrice,
                      widget.productModel.discount,
                      widget.productModel.discountType),
                  style: robotoRegular.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).errorColor,
                      fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL),
                ),
              ),
            ),
          )
              : SizedBox.shrink(),
        ]),
      ),
    );
  }

  // List<Widget> _indicators(BuildContext context) {
  //   List<Widget> indicators = [];
  //   List<String> temp  ;
  //   widget.productModel.productType == ProductVarType.productWithColor? temp=  widget.productModel.productFrontImage:
  //   widget.productModel.productType == ProductVarType.productWithColorSize? temp = widget.productModel.productFrontImage:
  //    temp = widget.productModel.images;
  //   for (int index = 0; index <
  //       temp.length; index++) {
  //     indicators.add(TabPageSelectorIndicator(
  //       backgroundColor: index ==
  //           Provider.of<ProductProvider>(context, listen: false)
  //               .selectImageIndex
  //           ? Theme.of(context).primaryColor
  //           : ColorResources.WHITE,
  //       borderColor: ColorResources.WHITE,
  //       size: 10,
  //       //productModel: widget.productModel,
  //     ));
  //   }
  //   return indicators;
  // }
}
class CustomIndecator extends StatelessWidget{
  List<String>  temp ;
  int selectedIndex;
  CustomIndecator(this.selectedIndex,this.temp);
  @override
  Widget build(BuildContext context) {

    return  Container(
      height: 20,
      width:20.0*temp.length ,
      child: ListView.builder(
        itemCount: temp.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {

          return TabPageSelectorIndicator(
            backgroundColor: index ==selectedIndex
                ? Theme.of(context).primaryColor
                : ColorResources.WHITE,
            borderColor: ColorResources.GREY,
            size: 9,
            //productModel: widget.productModel,
          );
        },),
    );
  }


}



