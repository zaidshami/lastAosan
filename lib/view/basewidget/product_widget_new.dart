import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/provider/product_details_provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

import '../../data/model/response/product_model.dart';
import '../../helper/price_converter.dart';
import '../../localization/language_constrants.dart';
import '../../provider/splash_provider.dart';
import '../../provider/wishlist_provider.dart';
import '../../utill/color_resources.dart';
import '../../utill/custom_themes.dart';
import '../../utill/dimensions.dart';
import '../../utill/images.dart';
import '../screen/product/product_details_screen.dart';
import '../screen/product/widget/favourite_button.dart';

class ProductWidgetNew extends StatelessWidget {
  final Product productModel;



  final bool isFavorite;


  ProductWidgetNew({

    @required this.productModel,


    this.isFavorite = false,

  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          CustomCupertinoPageRoute(
            builder: (context) => ProductDetails(product: productModel),
          ),
        );
      },
      child: Card(
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Consumer<ProductDetailsProvider>(
              builder: (context, value, child) =>
           Stack(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 0.78,
                    child: Swiper(
                      pagination: SwiperPagination(
                        builder: DotSwiperPaginationBuilder(
                          size: 6.0, // Adjust the size here
                          activeSize: 6.0,
                          space: 1.5,// Adjust the active size here
                        ),
                        alignment:  Alignment.bottomCenter,
                      ),
                      itemCount: productModel.productFrontImage.length,
                      itemBuilder: (BuildContext context, int index) {
                        return  CachedNetworkImage(
                          errorWidget: (context, url, error) => Image.asset(
                            Images.placeholder,
                            fit: BoxFit.cover,
                          ),
                          placeholder: (context, url) => Image.asset(
                            Images.placeholder,
                      fit: BoxFit.cover,
                          ),
                          imageUrl:
                          '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productImageUrl}/${productModel.productFrontImage[index]}',fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child:

                          Consumer<WishListProvider>(
                             builder: (context, value, child) =>
                             FavouriteButton(
                              backgroundColor: ColorResources.getImageBg(context),
                              favColor: Colors.redAccent,
                              product: productModel,
                            ),
                          ),
                    ),

                  productModel.productType == ProductVarType.productWithColor && productModel.productColorsList.length>1  ?
                  Positioned(
                    right: 0,
                    bottom: 0,
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
                                     productModel.productColorsList.length.toString()+" "+getTranslated("Color", context),
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
                  productModel.productType == ProductVarType.productWithColorSize &&productModel.productsizelist.length>1  ?
                  Positioned(
                    right: 0,
                    bottom: 0,
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
                                  productModel.productsizelist.length.toString()+" "+getTranslated("Color", context),
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
                  if (productModel.discount != null && productModel.discount !=0)
                    Positioned(
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
                                productModel.unitPrice,
                              productModel.discount,
                               productModel.discountType),
                            style: robotoRegular.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).errorColor,
                                fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                // height: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(productModel.name ?? '',
                        style: robotoBold,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL /2),
                    Text(productModel.desc ?? '',
                        style: robotoBold.copyWith(fontSize: 11, color: Colors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL/2),
                    Row(
                      children: [
                        productModel.discount > 0 &&
                            productModel.discount != null
                            ? Text(

                          PriceConverter.convertPrice(
                              context,productModel.unitPrice),
                          style: titilliumRegular1.copyWith(  overflow: TextOverflow.ellipsis,color: Colors.red,
                              decoration: TextDecoration.lineThrough),
                        )
                            : SizedBox.shrink(),
                        SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL/2),
                        Row(children: [
                          Text(
                            PriceConverter.convertPrice(
                                context,productModel.unitPrice ?? 0.0,
                                discountType:productModel.discountType,
                                discount:productModel.discount),
                            style: robotoBold.copyWith(
                                overflow: TextOverflow.ellipsis,
                                color: ColorResources.getPrimary(context)),
                          ),
                        ]),

                      ],
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

class CustomCupertinoPageRoute<T> extends CupertinoPageRoute<T> {
  CustomCupertinoPageRoute({
    @required WidgetBuilder builder,
    RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
    builder: builder,
    settings: settings,
    maintainState: maintainState,
    fullscreenDialog: fullscreenDialog,
  );

  @override
  Duration get transitionDuration => const Duration(milliseconds: 1000);
}
