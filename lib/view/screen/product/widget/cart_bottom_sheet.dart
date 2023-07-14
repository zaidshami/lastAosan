
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../data/model/response/cart_model.dart';
import '../../../../data/model/response/product_model.dart';
import '../../../../helper/price_converter.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../provider/auth_provider.dart';
import '../../../../provider/cart_provider.dart';
import '../../../../provider/product_details_provider.dart';
import '../../../../provider/seller_provider.dart';
import '../../../../provider/splash_provider.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../../view/basewidget/button/custom_button.dart';
import '../../../../view/basewidget/show_custom_snakbar.dart';
import '../../../../view/screen/cart/cart_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../auth/auth_screen.dart';
import '../../auth/widget/sign_in_widget.dart';
import '../product_details_screen.dart';

class CartBottomSheet extends StatefulWidget {
  final Product product;
  final Function callback;
  ProductOption productOption ;
  CartBottomSheet({@required this.product, this.callback});

  @override
  _CartBottomSheetState createState() => _CartBottomSheetState();
}

class _CartBottomSheetState extends State<CartBottomSheet> {

  route(bool isRoute, String message) async {
    if (isRoute) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.green));
    //  Navigator.pop(context);
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.red));
    }
  }

  String _currentColorName='AliceBlue';
  int _stock =1;

  int get stockgetter=>_stock;
  @override
  Widget build(BuildContext context) {

    Provider.of<ProductDetailsProvider>(context, listen: false).initData(widget.product);



    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          decoration: BoxDecoration(
            color: Theme.of(context).highlightColor,
            borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          ),
          child: Consumer<ProductDetailsProvider>(
            builder: (ctx, details, child) {
              double price = widget.product.unitPrice;
              double priceWithDiscount = PriceConverter.convertWithDiscount(context, price, widget.product.discount, widget.product.discountType);
              double priceWithQuantity = priceWithDiscount * details.quantity;
              String ratting = widget.product.rating != null && widget.product.rating.length != 0? widget.product.rating[0].average : "0";
              List<String> _variationList = [];
              Variation _variation;
              String _variantName ="";
              String variationType = '';
              String imgPath='';
              Widget varBody = Container();
              if(widget.product.productType==ProductVarType.productNormal){
                _stock=widget.product.currentStock;
                try {
                  imgPath = widget.product.images.first;
                }catch(r){

                }
              }
              else {
                _variantName = widget.product.variation.length != 0 ?
                widget.product.variation[details.variantIndex].file : null;
                for (int index = 0; index <
                    widget.product.choiceOptions.length; index++) {
                  _variationList.add(
                      widget.product.choiceOptions[index].options[details
                          .variationIndex[index]].trim());
                }
                if (_variantName != null) {
                  variationType = _variantName;
                  _variationList.forEach((variation) =>
                  variationType = '$variationType-$variation');
                } else {
                  bool isFirst = true;
                  _variationList.forEach((variation) {
                    if (isFirst) {
                      variationType = '$variationType$variation';
                      isFirst = false;
                    } else {
                      variationType = '$variationType-$variation';
                    }
                  });
                }

                variationType = variationType.replaceAll(' ', '');
                for (Variation variation in widget.product.variation) {
                  if (variation.type == variationType) {
                    price = variation.price;
                    _variation = variation;
                    //  _stock = variation.qty;
                    break;
                  }
                }
                if(widget.product.productType==ProductVarType.productWithColorSize) {
                  if(details.selectedSizeCode!="") {
                    _stock = int.parse(widget.product.filteredproductsizelist(details.variantIndex).size.where((element)
                    => element.code==details.selectedSizeCode).first.qunt);
                    print("jjjjj $_stock");
                    // _stock = details.sizeStoke(widget.product
                    //     .filteredproductsizelist(details.variantIndex)
                    //     .size.firstWhere((element) => element.id==details.selectedSizeCode).qunt);
                  }else{
                    _stock =1;
                  }
                  print("$_stock first the index ${details.dropdownValue.code}");

                  try {
                    imgPath = widget.product.productsizelist[details.variantIndex].images[0];
                  }catch(r){

                  }
                  varBody = Column(
                    children: [

                      widget.product
                          .filteredproductsizelist(details.variantIndex)
                          .size
                          .length > 0 ?
                      Row(children: [
                        Text('المقاس : ',
                            style: titilliumRegular.copyWith(
                                fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                        SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                        Expanded(
                          child: StatefulBuilder(

                              builder: (context, _change) {
                                return Column(
                                  children: [
                                    widget.product.productType ==
                                        ProductVarType.productWithColorSize
                                        ? SizedBox(
                                      height: 40,
                                      child: ListView.builder(
                                        itemCount: widget.product
                                            .filteredproductsizelist(details
                                            .variantIndex)
                                            .size
                                            .length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (ctx, index) {
                                          print("vvv ${ widget.product.filteredproductsizelist(details.variantIndex).size[index].code}");
                                          print("vvv2 ${details.selectedSizeCode}");
                                          bool isSelected = widget.product
                                              .filteredproductsizelist(details.variantIndex).size[index].code == details.selectedSizeCode;

                                          String colorString = '0xffF0F8FF'; //+widget.product.productsizelist[index].code.substring(1, 7);
                                          return InkWell(
                                            onTap: () {
                                              print("vvv3 ${widget.product.filteredproductsizelist(details.variantIndex).size[index].code}");
                                              details.setsize(details.dropdownValue.code);
                                            },
                                            child:

                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(Dimensions
                                                      .PADDING_SIZE_EXTRA_SMALL),
                                                  border: isSelected ? Border
                                                      .all(width: 1,
                                                      color: Theme
                                                          .of(context)
                                                          .primaryColor) : null
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                    Dimensions
                                                        .PADDING_SIZE_EXTRA_SMALL),

                                                child: Container(
                                                  padding: EdgeInsets.all(
                                                      Dimensions
                                                          .PADDING_SIZE_EXTRA_SMALL),
                                                  alignment: Alignment.center,

                                                  decoration: BoxDecoration(
                                                    //  color: Color(int.parse(colorString)),

                                                    borderRadius: BorderRadius
                                                        .circular(5),),
                                                  child: Text(widget.product
                                                      .filteredproductsizelist(
                                                      details .variantIndex)
                                                      .size[index].name),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                        :
                                    (widget.product.productType ==
                                        ProductVarType.productNormal ? Text(
                                        "normel") :

                                    widget.product.productType ==
                                        ProductVarType.productWithColor
                                        ? SizedBox(
                                      height: 40,
                                      child: ListView.builder(
                                        itemCount: widget.product
                                            .productColorsList.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (ctx, index) {
                                          String colorString = '0xff' +
                                              widget.product
                                                  .productColorsList[index].code
                                                  .substring(1, 7);
                                          return InkWell(
                                            onTap: () {
                                              _change(() {
                                                _currentColorName = widget
                                                    .product
                                                    .productColorsList[index]
                                                    .code;
                                              });

                                              Provider.of<
                                                  ProductDetailsProvider>(
                                                  context, listen: false)
                                                  .setCartVariantIndex(index);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(Dimensions
                                                      .PADDING_SIZE_EXTRA_SMALL),
                                                  border: details
                                                      .variantIndex == index
                                                      ? Border.all(width: 1,
                                                      color: Theme
                                                          .of(context)
                                                          .primaryColor)
                                                      : null
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                    Dimensions
                                                        .PADDING_SIZE_EXTRA_SMALL),

                                                child: Container(
                                                  height: Dimensions.topSpace,
                                                  width: Dimensions.topSpace,
                                                  padding: EdgeInsets.all(
                                                      Dimensions
                                                          .PADDING_SIZE_EXTRA_SMALL),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: Color(
                                                        int.parse(colorString)),
                                                    borderRadius: BorderRadius
                                                        .circular(5),),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                        : SizedBox()),

                                  ],
                                );
                              }
                          ),
                        ),


                      ]) : SizedBox(),
                      widget.product.colors.length > 0 ? SizedBox(
                          height: Dimensions.PADDING_SIZE_SMALL) : SizedBox(),
                      //


                    ],);
                }
                if(widget.product.productType==ProductVarType.productWithColor){
                if(widget.product.productColorsList.length>0) {
                  print("the index ${details.variantIndex}");
                  try {
                    imgPath = widget.product.productColorsList[details.variantIndex].images[0];
                  }catch(r){

                  }
                  Color colorString = HexColor.fromHex(widget.product.productColorsList[details.variantIndex].val);

                  _stock =widget.product
                      .productColorsList[Provider
                      .of<ProductDetailsProvider>(context, listen: false)
                      .variantIndex]
                      .qunt;
                  varBody = Column(
                    children: [

                      widget.product.productColorsList.length > 0 ?
                      Row(children: [
                        Text('${getTranslated('select_variant', context)} : ',
                            style: titilliumRegular.copyWith(
                                fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                        SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                        Expanded(
                          child: StatefulBuilder(

                              builder: (context, _change) {
                                return Column(
                                  children: [
                                   SizedBox(
                                      height: 40,
                                      child:Row(children: [

                                        Padding(
                                          padding: const EdgeInsets.all(
                                              Dimensions
                                                  .PADDING_SIZE_EXTRA_SMALL),

                                          child: Container(
                                            height: Dimensions.topSpace,
                                            width: Dimensions.topSpace,
                                            padding: EdgeInsets.all(
                                                Dimensions
                                                    .PADDING_SIZE_EXTRA_SMALL),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color:colorString,
                                              borderRadius: BorderRadius
                                                  .circular(5),),
                                          ),
                                        )
                                      ],),
                                    )


                                  ],
                                );
                              }
                          ),
                        ),


                      ]) : SizedBox(),
                      widget.product.colors.length > 0 ? SizedBox(
                          height: Dimensions.PADDING_SIZE_SMALL) : SizedBox(),
                      //


                    ],);
                }
                }
              }
              print("the stack ${_stock}");
              return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                // Close Button
                Align(alignment: Alignment.centerRight, child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).highlightColor, boxShadow: [BoxShadow(
                      color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 700 : 200],
                      spreadRadius: 1,
                      blurRadius: 5,
                    )]),
                    child: Icon(Icons.clear, size: Dimensions.ICON_SIZE_SMALL),
                  ),
                )),

                // Product details
                Column (
                  children: [
                    // Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Container(
                    //         width: 100,
                    //         height: 100,
                    //         decoration: BoxDecoration(
                    //             color: ColorResources.getImageBg(context),
                    //             borderRadius: BorderRadius.circular(5),
                    //             border: Border.all(width: .5,color: Theme.of(context).primaryColor.withOpacity(.20))
                    //         ),
                    //         child: CachedNetworkImage(
                    //           fit: BoxFit.contain,
                    //           placeholder: (context, url) =>
                    //               Image.asset(Images.placeholder,fit: BoxFit.cover),
                    //           errorWidget: (context, url, error) => Image.asset(
                    //             Images.placeholder,
                    //             fit: BoxFit.cover,
                    //           ),
                    //
                    //           imageUrl: '${Provider.of<SplashProvider>(context,listen: false).baseUrls.productImageUrl}/${imgPath}',
                    //         ),
                    //       ),
                    //       SizedBox(width: 20),
                    //       Expanded(
                    //         child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Text(widget.product.name ?? '',
                    //                   style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),
                    //                   maxLines: 2, overflow: TextOverflow.ellipsis),
                    //
                    //               SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    //               Row(
                    //                 children: [
                    //                   Icon(Icons.star,color: Colors.orange),
                    //                   Text(double.parse(ratting).toStringAsFixed(1),
                    //                       style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),
                    //                       maxLines: 2, overflow: TextOverflow.ellipsis),
                    //                 ],
                    //               ),
                    //
                    //
                    //
                    //             ]),
                    //       ),
                    //
                    //
                    //
                    //
                    //     ]),
                    // Row(
                    //   children: [
                    //     widget.product.discount > 0 ?
                    //     Container(
                    //       margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    //       padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    //       alignment: Alignment.center,
                    //       decoration: BoxDecoration(
                    //         color:Theme.of(context).primaryColor,
                    //         borderRadius: BorderRadius.circular(8),
                    //       ),
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Text(
                    //           PriceConverter.percentageCalculation(context, widget.product.unitPrice,
                    //               widget.product.discount, widget.product.discountType),
                    //           style: titilliumRegular.copyWith(color: Theme.of(context).cardColor,
                    //               fontSize: Dimensions.FONT_SIZE_DEFAULT),
                    //         ),
                    //       ),
                    //     ) : SizedBox(width: 93),
                    //     SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                    //     widget.product.discount > 0 ? Text(
                    //       PriceConverter.convertPrice(context, widget.product.unitPrice),
                    //       style: titilliumRegular.copyWith(color: ColorResources.getRed(context),
                    //           decoration: TextDecoration.lineThrough),
                    //     ) : SizedBox(),
                    //     SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                    //     Text(
                    //       PriceConverter.convertPrice(context, widget.product.unitPrice, discountType: widget.product.discountType, discount: widget.product.discount),
                    //       style: titilliumRegular.copyWith(color: ColorResources.getPrimary(context), fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
                    //     ),
                    //
                    //   ],
                    // ),
                  ],
                ),


                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                 ///varBody,
                // Variant
                // widget.product.filteredproductsizelist( Provider.of<ProductDetailsProvider>(context, listen: false).variantIndex).size.length> 0 ?
                // Row( children: [
                //   Text('${getTranslated('select_variant', context)} : ',
                //       style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                //   SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                //   Expanded(
                //     child: StatefulBuilder(
                //
                //         builder: (context, _change) {
                //           return Column(
                //             children: [
                //             widget.product.productType==ProductVarType.productWithColorSize ? SizedBox(
                //                 height: 40,
                //                 child: ListView.builder(
                //                   itemCount:widget.product.filteredproductsizelist( Provider.of<ProductDetailsProvider>(context, listen: false).variantIndex).size.length,
                //                   shrinkWrap: true,
                //                   scrollDirection: Axis.horizontal,
                //                   itemBuilder: (ctx, index) {
                //                     bool isSelected=widget.product.filteredproductsizelist( Provider.of<ProductDetailsProvider>(context, listen: false).variantIndex).size[index].code== Provider.of<ProductDetailsProvider>(context, listen: false).selectedSizeCode;
                //
                //                     String colorString = '0xffF0F8FF' ;//+widget.product.productsizelist[index].code.substring(1, 7);
                //                     return InkWell(
                //                       onTap: () {
                //                         Provider.of<ProductDetailsProvider>(context, listen: false).setsize(widget.product.filteredproductsizelist( Provider.of<ProductDetailsProvider>(context, listen: false).variantIndex).size[index].code);
                //
                //
                //                       },
                //                       child:
                //
                //                       Container(
                //                         decoration: BoxDecoration(
                //                             borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                //                             border: isSelected ? Border.all(width: 1,
                //                                 color: Theme.of(context).primaryColor):null
                //                         ),
                //                         child: Padding(padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                //
                //                           child: Container(
                //                             padding: EdgeInsets.all( Dimensions.PADDING_SIZE_EXTRA_SMALL),
                //                             alignment: Alignment.center,
                //
                //                             decoration: BoxDecoration(
                //                               //  color: Color(int.parse(colorString)),
                //
                //                               borderRadius: BorderRadius.circular(5),),
                //                             child: Text( widget.product.filteredproductsizelist( Provider.of<ProductDetailsProvider>(context, listen: true).variantIndex).size[index].name),
                //                           ),
                //                         ),
                //                       ),
                //                     );
                //                   },
                //                 ),
                //               ):
                //              ( widget.product.productType==ProductVarType.productNormal ?Text("normel"):
                //
                //              widget.product.productType==ProductVarType.productWithColor ? SizedBox(
                //                 height: 40,
                //                 child: ListView.builder(
                //                   itemCount: widget.product.productColorsList.length,
                //                   shrinkWrap: true,
                //                   scrollDirection: Axis.horizontal,
                //                   itemBuilder: (ctx, index) {
                //                     String colorString = '0xff' + widget.product.productColorsList[index].code.substring(1, 7);
                //                     return InkWell(
                //                       onTap: () {
                //                         _change((){
                //                           _currentColorName=widget.product.productColorsList[index].code;
                //
                //                         });
                //
                //                         Provider.of<ProductDetailsProvider>(context, listen: false).setCartVariantIndex(index);
                //
                //                       },
                //                       child: Container(
                //                         decoration: BoxDecoration(
                //                             borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                //                             border: details.variantIndex == index ? Border.all(width: 1,
                //                                 color: Theme.of(context).primaryColor):null
                //                         ),
                //                         child: Padding(padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                //
                //                           child: Container(height: Dimensions.topSpace, width: Dimensions.topSpace,
                //                             padding: EdgeInsets.all( Dimensions.PADDING_SIZE_EXTRA_SMALL),
                //                             alignment: Alignment.center,
                //                             decoration: BoxDecoration(
                //                               color: Color(int.parse(colorString)),
                //                               borderRadius: BorderRadius.circular(5),),
                //                           ),
                //                         ),
                //                       ),
                //                     );
                //                   },
                //                 ),
                //               ):SizedBox()),
                //               // SizedBox(
                //               //   height: 40,
                //               //   child: ListView.builder(
                //               //     itemCount: widget.product.productsizelist.where((element) => element.code==_currentColorName).first.size.length,
                //               //     shrinkWrap: true,
                //               //     scrollDirection: Axis.horizontal,
                //               //     itemBuilder: (ctx, index) {
                //               //       // String colorString = '0xff' + widget.product.colors[index].code.substring(1, 7);
                //               //       return InkWell(
                //               //         onTap: () {
                //               //           //   Provider.of<ProductDetailsProvider>(context, listen: false).setCartVariantIndex(index);
                //               //         },
                //               //         child: Container(
                //               //           decoration: BoxDecoration(
                //               //               borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                //               //               border: details.variantIndex == index ? Border.all(width: 1,
                //               //                   color: Theme.of(context).primaryColor):null
                //               //           ),
                //               //           child: Padding(padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                //               //
                //               //             child: Container(height: Dimensions.topSpace, width: Dimensions.topSpace,
                //               //               padding: EdgeInsets.all( Dimensions.PADDING_SIZE_EXTRA_SMALL),
                //               //               alignment: Alignment.center,
                //               //               decoration: BoxDecoration(
                //               //                 borderRadius: BorderRadius.circular(5),),
                //               //               child: Text( widget.product.productsizelist.where((element) => element.code==_currentColorName).first.size[index].name),
                //               //             ),
                //               //           ),
                //               //         ),
                //               //       );
                //               //     },
                //               //   ),
                //               // ),
                //             ],
                //           );
                //         }
                //     ),
                //   ),
                //
                //
                // ]) : SizedBox(),
                // widget.product.colors.length > 0 ? SizedBox(height: Dimensions.PADDING_SIZE_SMALL) : SizedBox(),
                //


                // Quantity

               ///
               //  Row(children: [
               //    Text(getTranslated('quantity', context), style: robotoBold),
               //    QuantityButton(isIncrement: false, quantity: details.quantity, stock: stockgetter),
               //    Text(details.quantity.toString(), style: titilliumSemiBold),
               //    QuantityButton(isIncrement: true, quantity: details.quantity, stock: stockgetter),
               //  ]),
               //  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
               //
               //
               //  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
               //    Text(getTranslated('total_price', context), style: robotoBold),
               //    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
               //    Text(PriceConverter.convertPrice(context, priceWithQuantity),
               //      style: titilliumBold.copyWith(color: ColorResources.getPrimary(context), fontSize: Dimensions.FONT_SIZE_LARGE),
               //    ),
               //  ]),
               //  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                Row(children: [
                  Provider.of<CartProvider>(context).isLoading ?

                  Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ) :

                  Expanded(
                    child: CustomButton(buttonText: getTranslated(_stock < 1 ?
                    'out_of_stock' : 'add_to_cart', context),
                        onTap: _stock < 1  ? null :() {
                          if(_stock > 0 ) {
                            CartModel cart = CartModel(
                                widget.product.id,
                               widget.product.thumbnail,
                                widget.product.name,
                                widget.product.addedBy == 'seller' ? '${Provider.of<SellerProvider>(context, listen: false).sellerModel.seller.fName} ''${Provider.of<SellerProvider>(context, listen: false).sellerModel.seller.lName}' : 'admin',
                                price, priceWithDiscount, details.quantity, _stock,
                                widget.product.name,
                                "widget.product.",
                             //   widget.product.colors.length > 0 ? widget.product.colors[details.variantIndex].name : '',
                               // widget.product.colors.length > 0 ? widget.product.colors[details.variantIndex].code : '',
                                widget.product.discount, widget.product.discountType, widget.product.tax,
                                widget.product.taxType, 1, '',widget.product.userId,'','','',
                                widget.product.isMultiPly==1? widget.product.shippingCost*details.quantity : widget.product.shippingCost ??0,
                                 ivariationModel:details. variationModel(widget.product,details.dropdownValue),



                            );



                            // cart.variations = _variation;
                            if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
                              Provider.of<CartProvider>(context, listen: false).addToCartAPI(
                                cart, route, context);
                            }else {
                              Provider.of<CartProvider>(context, listen: false).addToCart(cart);
                              Navigator.pop(context);
                              showCustomSnackBar(getTranslated('added_to_cart', context), context, isError: false);
                            }

                          }}),),
                  SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),


                  Provider.of<CartProvider>(context).isLoading ? SizedBox() :
                  Expanded(
                    child: CustomButton(isBuy:true,
                        buttonText: getTranslated(_stock < 1 ? 'out_of_stock' : 'buy_now', context),
                        onTap: _stock < 1  ? null :() {
                          if(_stock > 0 ) {
                            CartModel cart = CartModel(
                                widget.product.id, widget.product.thumbnail, widget.product.name,
                                widget.product.addedBy == 'seller' ?
                                '${Provider.of<SellerProvider>(context, listen: false).sellerModel.seller.fName} '
                                    '${Provider.of<SellerProvider>(context, listen: false).sellerModel.seller.lName}' : 'admin',
                                price, priceWithDiscount, details.quantity, _stock,
                                widget.product.colors.length > 0 ? widget.product.colors[details.variantIndex].name : '',
                                widget.product.colors.length > 0 ? widget.product.colors[details.variantIndex].code : '',
                                 widget.product.discount, widget.product.discountType, widget.product.tax,
                                widget.product.taxType, 1, '',widget.product.userId,'','','',
                                widget.product.isMultiPly==1? widget.product.shippingCost*details.quantity : widget.product.shippingCost ??0
                                , ivariationModel:details. variationModel(widget.product,details.dropdownValue)
                            );


                            // cart.variations = _variation;
                            if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
                              Provider.of<CartProvider>(context, listen: false).addToCartAPI(
                                cart, route, context).
                              then((value) {
                                if(value.response.statusCode == 200){
                                  _navigateToNextScreen(context);
                                }
                              }
                              );
                            }else {
                              // print('kissu koyna');
                              Fluttertoast.showToast(
                                  msg: getTranslated('Login_Msg', context),
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                              Navigator.of(context).push(CupertinoPageRoute(builder: (context) => AuthScreen()));
                            }
                          }}),
                  ),
                ],),
              ]);
            },
          ),
        ),
      ],
    );
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(CupertinoPageRoute(builder: (context) => CartScreen()));
  }
}




