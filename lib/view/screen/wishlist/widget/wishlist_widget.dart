import 'package:decorated_dropdownbutton/decorated_dropdownbutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../data/model/response/cart_model.dart';
import '../../../../data/model/response/product_model.dart';
import '../../../../helper/price_converter.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../provider/auth_provider.dart';
import '../../../../provider/cart_provider.dart';
import '../../../../provider/localization_provider.dart';
import '../../../../provider/product_details_provider.dart';
import '../../../../provider/seller_provider.dart';
import '../../../../provider/splash_provider.dart';
import '../../../../provider/wishlist_provider.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../../view/screen/product/widget/cart_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../basewidget/button/custom_button.dart';
import '../../../basewidget/show_custom_snakbar.dart';
import '../../product/product_details_screen.dart';
import '../../product/widget/custom_bottom_sheet_for_size.dart';

class WishListWidget extends StatelessWidget {
  final Product product;
  static Size dropdownValue = null;
  final int index;
  WishListWidget({this.product, this.index});

  @override
  Widget build(BuildContext context) {
    dropdownValue = null;
    String _currentColorName = 'AliceBlue';
    route(bool isRoute, String message) async {
      if (isRoute) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: Colors.green));
        //   Navigator.pop(context);
      } else {
        //  Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: Colors.red));
      }
    }

    int _stock = 1;
    double price = product.unitPrice;
    double priceWithDiscount = PriceConverter.convertWithDiscount(
        context, price, product.discount, product.discountType);
    return Container(
      padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: MaterialButton(
        onPressed: () {
          Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 1000),
                pageBuilder: (context, anim1, anim2) =>
                    ProductDetails(product: product),
              ));
        },
        child: Padding(
          padding: const EdgeInsets.only(
              left: Dimensions.PADDING_SIZE_EXTRA_SMALL,
              right: Dimensions.PADDING_SIZE_DEFAULT),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                  Stack(
                    children: [
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          border: Border.all(
                              width: .5,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.25)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          child: FadeInImage.assetNetwork(
                            placeholder: Images.placeholder,
                            fit: BoxFit.contain,
                            width: 70,
                            height: 80,
                            image:
                                '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productImageUrl}/${product.productFrontImage[0]}',
                            imageErrorBuilder: (c, o, s) => Image.asset(
                                Images.placeholder,
                                fit: BoxFit.cover,
                                width: 80,
                                height: 80),
                          ),
                        ),
                      ),
                      product.unitPrice != null && product.discount > 0
                          ? Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                height: 20,
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(Dimensions
                                            .PADDING_SIZE_EXTRA_SMALL),
                                        bottomRight: Radius.circular(Dimensions
                                            .PADDING_SIZE_EXTRA_SMALL)),
                                    color: Theme.of(context).primaryColor),
                                child: Text(
                                  product.unitPrice != null &&
                                          product.discount != null &&
                                          product.discountType != null
                                      ? PriceConverter.percentageCalculation(
                                          context,
                                          product.unitPrice,
                                          product.discount,
                                          product.discountType)
                                      : '',
                                  style: titilliumRegular.copyWith(
                                      fontSize:
                                          Dimensions.FONT_SIZE_EXTRA_SMALL,
                                      color: Theme.of(context).cardColor),
                                ),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                  SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                product.name ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: titilliumSemiBold.copyWith(
                                  color: ColorResources.getReviewRattingColor(
                                      context),
                                  fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                ),
                              ),
                            ),
                            SizedBox(
                                width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            Consumer<WishListProvider>(
                              builder: (context, wishProvider, child) {
                                return InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (_) => new AlertDialog(
                                                title: new Text(getTranslated(
                                                    'ARE_YOU_SURE_WANT_TO_REMOVE_WISH_LIST',
                                                    context)),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text(getTranslated(
                                                        'YES', context)),
                                                    onPressed: () async {
                                                      wishProvider
                                                          .removeWishList(
                                                              product);
                                                      Navigator.of(context)
                                                          .pop();
                                                      await Provider.of<WishListProvider>(context, listen: false).initWishList(context,
                                                        Provider.of<LocalizationProvider>(
                                                                context,
                                                                listen: false)
                                                            .locale
                                                            .countryCode,
                                                      );
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Text(getTranslated(
                                                        'NO', context)),
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                  ),
                                                ],
                                              ));
                                    },
                                    child: Image.asset(
                                      Images.delete,
                                      scale: 3,
                                      color: ColorResources.getRed(context)
                                          .withOpacity(.90),
                                    ));
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                        Row(
                          children: [
                            product.discount != null && product.discount > 0
                                ? Text(
                                    product.unitPrice != null
                                        ? PriceConverter.convertPrice(
                                            context, product.unitPrice)
                                        : '',
                                    style: titilliumSemiBold.copyWith(
                                        color: ColorResources.getRed(context),
                                        decoration: TextDecoration.lineThrough),
                                  )
                                : SizedBox(),
                            product.discount != null && product.discount > 0
                                ? SizedBox(
                                    width: Dimensions.PADDING_SIZE_DEFAULT)
                                : SizedBox(),
                            Text(
                              PriceConverter.convertPrice(
                                  context, product.unitPrice,
                                  discount: product.discount,
                                  discountType: product.discountType),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: titilliumRegular.copyWith(
                                  color: ColorResources.getPrimary(context),
                                  fontSize: Dimensions.FONT_SIZE_LARGE),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        /// Chose the variant
                        // product.productType ==
                        //         ProductVarType.productWithColorSize
                        //     ? Consumer<ProductDetailsProvider>(
                        //         builder: (context, details, child) =>
                        //             DecoratedBox(
                        //                 decoration: BoxDecoration(
                        //                     color: Colors
                        //                         .white, //background color of dropdown button
                        //                     border: Border.all(
                        //                         color: Colors.black38,
                        //                         width:
                        //                             1), //border of dropdown button
                        //                     borderRadius: BorderRadius.circular(
                        //                         5), //border raiuds of dropdown button
                        //                     boxShadow: <BoxShadow>[
                        //                       //apply shadow on Dropdown button
                        //                       BoxShadow(
                        //                           color: Color.fromRGBO(0, 0, 0,
                        //                               0.57), //shadow for button
                        //                           blurRadius:
                        //                               1) //blur radius of shadow
                        //                     ]),
                        //                 child: Padding(
                        //                     padding: EdgeInsets.only(
                        //                         left: 5, right: 20),
                        //                     child: StatefulBuilder(
                        //                       builder: (context, _change) {
                        //                         return SizedBox(
                        //                           height: 25,
                        //                           width: MediaQuery.of(context)
                        //                                   .size
                        //                                   .width *
                        //                               0.35,
                        //                           child: DropdownButton<Size>(
                        //                             //  value:details.selectedSizeCode ==null ? null : details.selectedSizeCode,
                        //                             hint: Text(
                        //                               'اختر المقاس',
                        //                               style:
                        //                                   robotoBold.copyWith(
                        //                                       color:
                        //                                           Colors.black,
                        //                                       fontSize: 10),
                        //                             ),
                        //                             //  value: details.dropdownValue ,
                        //                             value: dropdownValue == null
                        //                                 ? product
                        //                                     .filteredproductsizelist(
                        //                                         0)
                        //                                     .size[0]
                        //                                 : dropdownValue,
                        //                             items: product
                        //                                 .filteredproductsizelist(
                        //                                     0)
                        //                                 .size
                        //                                 .map(
                        //                                   (map) =>
                        //                                       DropdownMenuItem(
                        //                                     onTap: () {
                        //                                       // m   =  widget.product
                        //                                       //     .filteredproductsizelist(details
                        //                                       //     .variantIndex)
                        //                                       //     .size.indexOf(map) ;
                        //
                        //                                       dropdownValue =
                        //                                           map;
                        //
                        //                                       print('ssssss' +
                        //                                           dropdownValue
                        //                                               .code);
                        //                                     },
                        //                                     child: Text(
                        //                                       map.name,
                        //                                       style: robotoBold
                        //                                           .copyWith(
                        //                                               color: Colors
                        //                                                   .black,
                        //                                               fontSize:
                        //                                                   15),
                        //                                     ),
                        //                                     value: map,
                        //                                   ),
                        //                                 )
                        //                                 .toList(),
                        //                             onChanged: (value) {
                        //                               //get value when changed
                        //                               _change(() {
                        //                                 dropdownValue = value;
                        //                                 //  Provider.of<ProductDetailsProvider>(context, listen: false).setsize(dropdownValue.code);
                        //                               });
                        //
                        //                               print(
                        //                                   "You have selected " +
                        //                                       dropdownValue.id);
                        //                               /*
                        //
                        //                                         details.selectedSizeCode = value as String ;
                        //                                         print('ssss is '+ details.selectedSizeCode);*/
                        //                               // details.variantIndex = value as int;
                        //                             },
                        //                             icon: Padding(
                        //                                 //Icon at tail, arrow (moov1)bottom is default icon
                        //                                 padding:
                        //                                     EdgeInsets.only(
                        //                                         right: 50),
                        //                                 child: Icon(Icons
                        //                                     .keyboard_arrow_down_sharp)),
                        //                             iconEnabledColor: Colors
                        //                                 .black, //Icon color
                        //                             style: TextStyle(
                        //                                 //te
                        //                                 color: Colors
                        //                                     .black, //Font color
                        //                                 fontSize:
                        //                                     20 //font size on dropdown button
                        //                                 ),
                        //
                        //                             dropdownColor: Colors
                        //                                 .white, //dropdown background color
                        //                             underline:
                        //                                 Container(), //remove underline
                        //                             isExpanded:
                        //                                 true, //make true to make width 100%
                        //                           ),
                        //                         );
                        //                       },
                        //                     ))),
                        //       )
                        //     : SizedBox(),
                        Row(
                          children: [
                            Text(
                              '${getTranslated('qty', context)}:' +
                                  ' ' +
                                  '${product.minQty}',
                              style: titleRegular.copyWith(
                                  color: ColorResources.getReviewRattingColor(
                                      context)),
                              textAlign: TextAlign.center,
                            ),
                            Spacer(),

                            /*   Row(
                              children: [
                                Provider.of<CartProvider>(context).isLoading
                                    ? SizedBox()
                                    : CustomButton(
                                        isBorder: true,
                                        fontSize: 10,
                                        height: 35,
                                        buttonText: '  ' +
                                            getTranslated(
                                                _stock < 1
                                                    ? 'out_of_stock'
                                                    : 'add_to_cart',
                                                context) +
                                            '  ',
                                        onTap: _stock < 1
                                            ? null
                                            : () {
                                                /// example how to get random element form a list
                                                //  var list = ['a','b','c','d','e'];
                                                // print( 'the randomized element is ' +list.elementAt(Random().nextInt(list.length)).toString());
                                                if (product.productType ==
                                                        ProductVarType
                                                            .productWithColorSize &&
                                                    dropdownValue == null) {
                                                  Fluttertoast.showToast(
                                                      msg: 'يرجى تحديد المقاس',
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor:
                                                          Colors.red,
                                                      textColor: Colors.white,
                                                      fontSize: 16.0);
                                                }

                                                if (_stock > 0) {
                                                  CartModel cart = CartModel(
                                                    product.id,
                                                    product.thumbnail,
                                                    product.name,
                                                    product.addedBy == 'seller'
                                                        ? '${Provider.of<SellerProvider>(context, listen: false).sellerModel.seller.fName} '
                                                            '${Provider.of<SellerProvider>(context, listen: false).sellerModel.seller.lName}'
                                                        : 'admin',
                                                    price,
                                                    priceWithDiscount,
                                                    Provider.of<ProductDetailsProvider>(
                                                            context,
                                                            listen: false)
                                                        .quantity,
                                                    _stock,
                                                    product.name,
                                                    "widget.product.",
                                                    //   widget.product.colors.length > 0 ? widget.product.colors[details.variantIndex].name : '',
                                                    // widget.product.colors.length > 0 ? widget.product.colors[details.variantIndex].code : '',
                                                    product.discount,
                                                    product.discountType,
                                                    product.tax,
                                                    product.taxType, 1, '',
                                                    product.userId, '', '', '',
                                                    product.isMultiPly == 1
                                                        ? product.shippingCost *
                                                            Provider.of<ProductDetailsProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .quantity
                                                        : product
                                                                .shippingCost ??
                                                            0,
                                                    ivariationModel: Provider
                                                            .of<ProductDetailsProvider>(
                                                                context,
                                                                listen: false)
                                                        .variationModel(product,
                                                            dropdownValue),
                                                  );

                                                  // cart.variations = _variation;
                                                  if (Provider.of<AuthProvider>(
                                                          context,
                                                          listen: false)
                                                      .isLoggedIn()) {
                                                    Provider.of<CartProvider>(
                                                            context,
                                                            listen: false)
                                                        .addToCartAPI(cart,
                                                            route, context);
                                                  } else {
                                                    Provider.of<CartProvider>(
                                                            context,
                                                            listen: false)
                                                        .addToCart(cart);
                                                    //  Navigator.pop(context);
                                                    showCustomSnackBar(
                                                        getTranslated(
                                                            'added_to_cart',
                                                            context),
                                                        context,
                                                        isError: false);
                                                  }
                                                }
                                              }),
                                Provider.of<CartProvider>(context).isLoading
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              new AlwaysStoppedAnimation<Color>(
                                            Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        width: Dimensions.PADDING_SIZE_DEFAULT),

                                /// buy now
                                // Provider.of<CartProvider>(context).isLoading ? SizedBox() :
                                // Expanded(
                                //   child: CustomButton(isBuy:true,
                                //       buttonText: getTranslated(_stock < 1 ? 'out_of_stock' : 'buy_now', context),
                                //       onTap: _stock < 1  ? null :() {
                                //         if  ( dropdownValue == null){
                                //           Fluttertoast.showToast(
                                //               msg: 'يرجى تحديد المقاس',
                                //               toastLength: Toast.LENGTH_SHORT,
                                //               gravity: ToastGravity.BOTTOM,
                                //               timeInSecForIosWeb: 1,
                                //               backgroundColor: Colors.red,
                                //               textColor: Colors.white,
                                //               fontSize: 16.0
                                //           ); }
                                //         if(_stock > 0 ) {
                                //           CartModel cart = CartModel(
                                //               widget.product.id, widget.product.thumbnail, widget.product.name,
                                //               widget.product.addedBy == 'seller' ?
                                //               '${Provider.of<SellerProvider>(context, listen: false).sellerModel.seller.fName} '
                                //                   '${Provider.of<SellerProvider>(context, listen: false).sellerModel.seller.lName}' : 'admin',
                                //               price, priceWithDiscount, details.quantity, _stock,
                                //               widget.product.colors.length > 0 ? widget.product.colors[details.variantIndex].name : '',
                                //               widget.product.colors.length > 0 ? widget.product.colors[details.variantIndex].code : '',
                                //               widget.product.discount, widget.product.discountType, widget.product.tax,
                                //               widget.product.taxType, 1, '',widget.product.userId,'','','',
                                //               widget.product.isMultiPly==1? widget.product.shippingCost*details.quantity : widget.product.shippingCost ??0
                                //               , ivariationModel:details. variationModel(widget.product,details.dropdownValue)
                                //           );
                                //
                                //
                                //           // cart.variations = _variation;
                                //           if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
                                //             Provider.of<CartProvider>(context, listen: false).addToCartAPI(
                                //                 cart, route, context).
                                //             then((value) {
                                //               if(value.response.statusCode == 200){
                                //                 _navigateToNextScreen(context);
                                //               }
                                //             }
                                //             );
                                //           }else {
                                //             // print('kissu koyna');
                                //             Fluttertoast.showToast(
                                //                 msg: getTranslated('Login_Msg', context),
                                //                 toastLength: Toast.LENGTH_SHORT,
                                //                 gravity: ToastGravity.CENTER,
                                //                 timeInSecForIosWeb: 1,
                                //                 backgroundColor: Colors.green,
                                //                 textColor: Colors.white,
                                //                 fontSize: 16.0
                                //             );
                                //             Navigator.of(context).push(CupertinoPageRoute(builder: (context) => AuthScreen()));
                                //           }
                                //         }}),
                                // ),
                              ],
                            ),*/

                            ///old add to cart
                            // InkWell(
                            //   onTap: () => showModalBottomSheet(
                            //       context: context,
                            //       isScrollControlled: true,
                            //       backgroundColor: Colors.transparent,
                            //       builder: (con) =>
                            //           CartBottomSheet(product: product)),
                            //   child: Container(
                            //     height: 30,
                            //     margin: EdgeInsets.only(
                            //         left: Dimensions.PADDING_SIZE_SMALL),
                            //     padding: EdgeInsets.symmetric(
                            //         horizontal: Dimensions.PADDING_SIZE_SMALL),
                            //     alignment: Alignment.center,
                            //     decoration: BoxDecoration(
                            //         boxShadow: [
                            //           BoxShadow(
                            //             color: Colors.grey.withOpacity(0.2),
                            //             spreadRadius: 1,
                            //             blurRadius: 7,
                            //             offset: Offset(0, 1),
                            //           ),
                            //         ],
                            //         gradient: LinearGradient(colors: [
                            //           Theme.of(context).primaryColor,
                            //           Theme.of(context).primaryColor,
                            //           Theme.of(context).primaryColor,
                            //         ]),
                            //         borderRadius: BorderRadius.circular(
                            //             Dimensions.PADDING_SIZE_EXTRA_SMALL)),
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         Icon(Icons.shopping_cart,
                            //             color: Colors.white, size: 15),
                            //         SizedBox(
                            //           width:
                            //               Dimensions.PADDING_SIZE_EXTRA_SMALL,
                            //         ),
                            //         FittedBox(
                            //           child: Text(
                            //               getTranslated('add_to_cart', context),
                            //               style: titleRegular.copyWith(
                            //                   fontSize:
                            //                       Dimensions.FONT_SIZE_DEFAULT,
                            //                   color: Colors.white)),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              Divider()
            ],
          ),
        ),
      ),
    );
  }
}
