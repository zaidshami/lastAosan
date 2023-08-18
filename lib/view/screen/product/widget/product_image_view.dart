import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../data/model/response/product_model.dart';
import '../../../../helper/price_converter.dart';
import '../../../../provider/cart_provider.dart';
import '../../../../provider/product_details_provider.dart';
import '../../../../provider/splash_provider.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../provider/wishlist_provider.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../../view/screen/product/widget/favourite_button.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import '../../cart/cart_screen.dart';

class ProductImageView extends StatelessWidget {
  final Product productModel;
  final PageController controller;
  List<String> imagesList;

  ProductImageView(
      {@required this.productModel,
      this.controller,
      @required this.imagesList});
  int i = 1;
  List<String> get _inecatorlist => productModel.images;
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Consumer<ProductDetailsProvider>(
            builder: (ctx, details, child) {
              return InkWell(
                child: imagesList != null
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[
                                    Provider.of<ThemeProvider>(context)
                                            .darkTheme
                                        ? 700
                                        : 300],
                                spreadRadius: 1,
                                blurRadius: 5)
                          ],
                          gradient:
                              Provider.of<ThemeProvider>(context).darkTheme
                                  ? null
                                  : LinearGradient(
                                      colors: [
                                        ColorResources.WHITE,
                                        ColorResources.IMAGE_BG
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                        ),
                        child: Consumer<ProductDetailsProvider>(
                          builder: (ctx, details, child) {
                            return Stack(children: [
                              i == 1
                                  ? SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              1.5,
                                      child: imagesList != null
                                          ? PageView.builder(
                                              dragStartBehavior:
                                                  DragStartBehavior.start,
                                              pageSnapping: true,
                                              controller: controller,
                                              itemCount: imagesList.length,
                                              itemBuilder: (
                                                context,
                                                index,
                                              ) {
                                                Provider.of<ProductDetailsProvider>(
                                                        context,
                                                        listen: false)
                                                    .setImageSliderSelectedIndex1(
                                                        index);

                                                return CachedNetworkImage(
                                                  fit: BoxFit.contain,
                                                  placeholder: (context, url) =>
                                                      Image.asset(
                                                          Images.placeholder),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  imageUrl:
                                                      '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productImageUrl}/${imagesList[index]}',
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Image.asset(
                                                    Images.placeholder,
                                                    height:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    fit: BoxFit.cover,
                                                  ),
                                                );
                                              },
                                              onPageChanged: (index) {
                                                //   Provider.of<ProductDetailsProvider>(context, listen: false).setCartVariantIndex(index);
                                                print('index $index');
                                                print(
                                                    'sliderIndex ${details.imageSliderIndex}');

                                                details
                                                    .setImageSliderSelectedIndex(
                                                        index);
                                              },
                                            )
                                          : SizedBox(),
                                    )
                                  :

                                  /// old and orginal gallery view of the pics
                                  CarouselSlider.builder(
                                      options: CarouselOptions(
                                        height: 500,
                                        aspectRatio: 16 / 9,
                                        enlargeStrategy:
                                            CenterPageEnlargeStrategy.scale,
                                        viewportFraction: 0.74,
                                        enlargeCenterPage: true,
                                        initialPage: 0,
                                        enableInfiniteScroll: false,
                                        reverse: false,
                                        autoPlay: false,
                                        autoPlayInterval: Duration(seconds: 3),
                                        autoPlayAnimationDuration:
                                            Duration(milliseconds: 800),
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        onPageChanged: (index, reason) {
                                          print('index $index');
                                          print(
                                              'sliderIndex ${details.imageSliderIndex}');

                                          Provider.of<ProductDetailsProvider>(
                                                  context,
                                                  listen: false)
                                              .setImageSliderSelectedIndex(
                                                  index);
                                        },
                                        scrollDirection: Axis.horizontal,
                                      ),
                                      itemCount: imagesList.length,
                                      itemBuilder: (BuildContext context,
                                          int itemIndex, int pageViewIndex) {
                                        Provider.of<ProductDetailsProvider>(
                                                context,
                                                listen: false)
                                            .setImageSliderSelectedIndex1(
                                                itemIndex);

                                        return CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                            Images.placeholder,
                                            height: MediaQuery.of(context)
                                                .size
                                                .width,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            fit: BoxFit.cover,
                                          ),
                                          placeholder: (context, url) =>
                                              Image.asset(Images.placeholder),
                                          height:
                                              MediaQuery.of(context).size.width,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          imageUrl:
                                              '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productImageUrl}/${imagesList[itemIndex]}',
                                        );
                                      },
                                    ),

                              ///image slider in the middle in the picture
                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: 30,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: _indicators(context),
                                    ),
                                    Spacer(),
                                    Provider.of<ProductDetailsProvider>(context)
                                                .imageSliderIndex !=
                                            null
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                right: Dimensions
                                                    .PADDING_SIZE_DEFAULT,
                                                bottom: Dimensions
                                                    .PADDING_SIZE_DEFAULT),
                                            child: Text(
                                                '${Provider.of<ProductDetailsProvider>(context).imageSliderIndex + 1}' +
                                                    '/' +
                                                    '${imagesList.length.toString()}'),
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                              ),

                              ///close icon
                              Positioned(
                                top: 16,
                                right: 16,
                                child: InkWell(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(.2),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    //color: Colors.grey.withOpacity(.5),
                                    child: Icon(Icons.close),
                                  ),
                                ),
                              ),

                              ///favorite color and cart and share
                              Positioned(
                                top: 30,
                                right: MediaQuery.of(context).size.width / 1.2 +
                                    15,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: Dimensions.PADDING_SIZE_SMALL*2,
                                    ),
                                    InkWell(
                                      onTap: (){
                                        Navigator.of(context).push(CupertinoPageRoute(builder: (context) => CartScreen(fromCheckout: false,)));
                                      },
                                      child:

                                      Card(
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                          color: Theme.of(context).cardColor,
                                          child: Padding(padding: EdgeInsets.all(5),
                                            child:   Stack(
                                                children: <Widget>[
                                                  Image.asset(Images.new_cart_image,
                                                    height: 25, width: 25,
                                                  ),
                                                  Provider.of<CartProvider>(context,listen: false).cartList.length.toString()=='0'?SizedBox(): Positioned(top: -0, right: -0,
                                                    child: Consumer<CartProvider>(builder: (context, cart, child) {
                                                      return CircleAvatar(radius: 5,
                                                        backgroundColor:Colors.red,
                                                        child: Text( Provider.of<CartProvider>(context,listen: false).cartList.length.toString(),
                                                          style: titilliumSemiBold.copyWith(
                                                            color: ColorResources.WHITE,
                                                            fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                                          ),),
                                                      );
                                                    }),
                                                  ),

                                                ]
                                            ),
                                          )
                                      ),
                                    ),


                                    SizedBox(
                                      height: Dimensions.PADDING_SIZE_SMALL,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (Provider.of<ProductDetailsProvider>(
                                                    context,
                                                    listen: false)
                                                .sharableLink !=
                                            null) {
                                          Share.share(Provider.of<
                                                      ProductDetailsProvider>(
                                                  context,
                                                  listen: false)
                                              .sharableLink);
                                        }
                                      },
                                      child: Card(
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(Icons.share,
                                              color:
                                                  Theme.of(context).cardColor,
                                              size: Dimensions.ICON_SIZE_SMALL),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              productModel.unitPrice != null &&
                                      productModel.discount != 0
                                  ? Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 160,
                                            height: 30,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius: BorderRadius.only(
                                                    bottomRight: Radius
                                                        .circular(Dimensions
                                                            .PADDING_SIZE_SMALL))),
                                            child: Text(
                                              '${PriceConverter.percentageCalculation(context, productModel.unitPrice, productModel.discount, productModel.discountType)}',
                                              style: titilliumRegular.copyWith(
                                                  color: Theme.of(context)
                                                      .cardColor,
                                                  fontSize: Dimensions
                                                      .FONT_SIZE_LARGE),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox.shrink(),
                              SizedBox.shrink(),

                              Positioned(
                                bottom: 30,
                                right: 16,
                                child: InkWell(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(

                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(.2),
                                        borderRadius:
                                        BorderRadius.circular(50)),
                                    //color: Colors.grey.withOpacity(.5),
                                    child:Row(children: [
                                      FavouriteButton(
                                        isDetails: true,
                                        backgroundColor:
                                        ColorResources.getImageBg(context),
                                        favColor: Colors.redAccent,
                                        product: productModel,
                                      ),
                                    ],)
                                  ),
                                ),
                              ),

                            ]);
                          },
                        ),
                      )
                    : SizedBox(),
              );
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _indicators(BuildContext context) {
    List<Widget> indicators = [];
    for (int index = 0; index < imagesList.length; index++) {
      indicators.add(TabPageSelectorIndicator(
        backgroundColor: index ==
                Provider.of<ProductDetailsProvider>(context).imageSliderIndex
            ? Theme.of(context).primaryColor
            : ColorResources.WHITE,
        borderColor: ColorResources.WHITE,
        size: 10,
      ));
    }
    return indicators;
  }
}
