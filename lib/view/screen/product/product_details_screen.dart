import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/provider/profile_provider.dart';
import 'package:flutter_Aosan_ecommerce/view/screen/product/product_image_view.dart';
import 'package:flutter_Aosan_ecommerce/view/screen/product/widget/custom_bottom_sheet_for_size.dart';
import 'package:flutter_Aosan_ecommerce/view/screen/product/widget/product_specifications_expandable.dart';
import 'package:flutter_Aosan_ecommerce/view/screen/product/widget/quantity_bottom_sheet.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';
import '../../../../helper/product_type.dart';
import '../../../../provider/auth_provider.dart';
import '../../../../utill/color_resources.dart';
import '../../../../view/basewidget/rating_bar.dart';
import '../../../../view/screen/home/widget/products_view.dart';
import '../../../../view/screen/product/widget/seller_view.dart';
import '../../../../data/model/response/product_model.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../provider/product_details_provider.dart';
import '../../../../provider/product_provider.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../../view/basewidget/no_internet_screen.dart';
import '../../../../view/basewidget/title_row.dart';
import '../../../../view/screen/product/widget/product_image_view.dart';
import '../../../../view/screen/product/widget/product_title_view.dart';
import '../../../../view/screen/product/widget/related_product_view.dart';
import '../../../../view/screen/product/widget/review_widget.dart';
import '../../../../view/screen/product/widget/youtube_video_widget.dart';
import 'package:provider/provider.dart';
import '../../../data/model/response/cart_model.dart';
import '../../../helper/price_converter.dart';
import '../../../provider/cart_provider.dart';
import '../../../provider/seller_provider.dart';
import '../../../provider/splash_provider.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/images.dart';
import '../../../utill/math_utils.dart';
import '../../basewidget/animated_custom_dialog.dart';
import '../../basewidget/button/custom_button.dart';
import '../../basewidget/guest_dialog.dart';
import '../../basewidget/show_custom_snakbar.dart';
import '../cart/cart_screen.dart';
import '../home/widget/products_view_1.dart';
import '../more/widget/html_view_Screen.dart';
import 'faq_and_review_screen.dart';


class ProductDetails extends StatefulWidget {
  final Product product;

  ProductDetails({
    @required this.product,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  route(bool isRoute, String message, int stat) async {
    if (stat == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.green));
      //   Navigator.pop(context);
    } else {
      //  Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.red));
    }
  }

  _loadData(BuildContext context) async {

    Provider.of<ProductDetailsProvider>(context, listen: false)
        .removePrevReview();
    Provider.of<ProductDetailsProvider>(context, listen: false)
        .initProduct(widget.product, context);
    Provider.of<ProductProvider>(context, listen: false)
        .removePrevRelatedProduct();
    Provider.of<ProductProvider>(context, listen: false)
        .initRelatedProductList(widget.product.id.toString(), context);
    Provider.of<ProductDetailsProvider>(context, listen: false)
        .getCount(widget.product.id.toString(), context);

    Provider.of<ProductDetailsProvider>(context, listen: false)
        .getSharableLink(widget.product.slug.toString(), context);
    if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
      // Provider.of<WishListProvider>(context, listen: false).checkWishList(widget.product.id, context,Provider.of<LocalizationProvider>(context, listen: false).locale.countryCode);
    }
    Provider.of<ProductProvider>(context, listen: false)
        .initSellerProductList(widget.product.userId.toString(), 1, context);

    Provider.of<ProductDetailsProvider>(context, listen: false)
        .initData(widget.product);
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductDetailsProvider>(
        context,
        listen:
        false)
        .setImageSliderSelectedIndexZero();
    Provider.of<ProductProvider>(context, listen: false).qty1 = 1;
    bool isGuestMode =
        !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();

    if (widget.product.productType != ProductVarType.productNormal &&
        Provider.of<ProductDetailsProvider>(context, listen: false)
                .variantIndex ==
            0 &&
        (widget.product.productColorsList.length > 0 ||
            widget.product.productsizelist.length > 0)) {
      // Todo : here is the problem of the state of the release application and the problem of the first picture
      Provider.of<ProductDetailsProvider>(context, listen: false)
          .setCartVariantIndex(0, withRefresh: false);
    }
    List<dynamic> revList =
        Provider.of<ProductDetailsProvider>(context, listen: false)
                    .reviewList ==
                null
            ? []
            : Provider.of<ProductDetailsProvider>(context, listen: false)
                .reviewList;
    int _cStocks = 1;


    int _stock = 1;
    // finaal qIndex = widget.product.categoryList.indexWhere((element) => element.id == id);
    String _currentColorName = 'AliceBlue';
    ScrollController _scrollController = ScrollController();
    String ratting = widget.product != null &&
            widget.product.rating != null &&
            widget.product.rating.length != 0
        ? widget.product.rating[0].average.toString()
        : "0";
    _loadData(context);
    return widget.product != null
        ? MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaleFactor: AppConstants.textScaleFactior),
            child: Consumer<ProductDetailsProvider>(
              builder: (context, details, child) {
                double price = widget.product.unitPrice;
                double priceWithDiscount = PriceConverter.convertWithDiscount(
                    context,
                    price,
                    widget.product.discount,
                    widget.product.discountType);

                return details.hasConnection
                    ? Scaffold(
                        backgroundColor: Theme.of(context).cardColor,
                        bottomNavigationBar: Row(
                          children: [
                            Provider.of<CartProvider>(context).isLoading
                                ? SizedBox()
                                : Expanded(
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),

                                        ///new quantity
                                        widget.product.productType !=
                                                    ProductVarType
                                                        .productWithColorSize

                                            ? widget.product.currentStock >= 1
                                                ? Expanded(
                                                    flex: 2,
                                                    child: Consumer<
                                                        ProfileProvider>(
                                                      builder: (context, value,
                                                              child) =>
                                                          InkWell(
                                                        onTap: () {
                                                          showModalBottomSheet(
                                                              isDismissible:
                                                                  true,
                                                              context: context,
                                                              isScrollControlled:
                                                                  true,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              builder:
                                                                  (con) =>
                                                                      Padding(
                                                                        padding:
                                                                            getPadding(bottom: 0),
                                                                        child: Container(
                                                                            height:
                                                                                150,
                                                                            child:

                                                                           MyQuantityCustomWidget(qty:  widget.product.productType !=
                                                                               ProductVarType
                                                                                   .productWithColor?  widget.product.currentStock : widget.product.productColorsList[ Provider.of<ProductDetailsProvider>(context, listen: false).qStock].qunt)  ),
                                                                      ));
                                                        },
                                                        child: Container(
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                'الكمية',
                                                                style: robotoRegular
                                                                    .copyWith(
                                                                        height:
                                                                            1,
                                                                        fontSize:
                                                                            20),
                                                              ),
                                                              Consumer<
                                                                      ProductProvider>(
                                                                  builder: (context,
                                                                          value,
                                                                          child) =>
                                                                      Text(
                                                                          '${value.qty}',
                                                                          style:
                                                                              robotoBold.copyWith(fontSize: 20))),
                                                            ],
                                                          ),
                                                          decoration:
                                                              customDecoration
                                                                  .copyWith(
                                                                      border:
                                                                          Border
                                                                              .all(
                                                            color: Colors.black,
                                                            width: 1,
                                                          )),
                                                          height: 53,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox()
                                            : SizedBox(),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          flex: 8,
                                          child: CustomButton(
                                              buttonText: getTranslated(
                                                  _stock < 1
                                                      ? 'out_of_stock'
                                                      : 'add_to_cart',
                                                  context),
                                              onTap: _stock < 1
                                                  ? null
                                                  : () {
                                                      if (isGuestMode) {
                                                        showAnimatedDialog(
                                                            context,
                                                            GuestDialog(),
                                                            isFlip: true);
                                                      } else {
                                                        if (widget.product
                                                                    .productType ==
                                                                ProductVarType
                                                                    .productWithColorSize &&
                                                            Provider.of<ProductDetailsProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .dropdownValue ==
                                                                null) {
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  'يرجى تحديد المقاس',
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              gravity:
                                                                  ToastGravity
                                                                      .BOTTOM,
                                                              timeInSecForIosWeb:
                                                                  1,
                                                              backgroundColor:
                                                                  Colors.red,
                                                              textColor:
                                                                  Colors.white,
                                                              fontSize: 16.0);
                                                        }

                                                        if (_stock > 0) {
                                                          CartModel cart =
                                                              CartModel(
                                                            widget.product.id,
                                                            widget.product
                                                                .thumbnail,
                                                            widget.product.name,
                                                            widget.product
                                                                        .addedBy ==
                                                                    'seller'
                                                                ? '${Provider.of<SellerProvider>(context, listen: false).sellerModel.seller.fName} '
                                                                    '${Provider.of<SellerProvider>(context, listen: false).sellerModel.seller.lName}'
                                                                : 'admin',
                                                            price,
                                                            priceWithDiscount,
                                                            Provider.of<ProductProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .qty,
                                                            widget.product
                                                                .currentStock,
                                                            widget.product.name,
                                                            "widget.product.",
                                                            widget.product
                                                                .discount,
                                                            widget.product
                                                                .discountType,
                                                            widget.product.tax,
                                                            widget.product
                                                                .taxType,
                                                            1,
                                                            '',
                                                            widget
                                                                .product.userId,
                                                            '',
                                                            '',
                                                            '',
                                                            widget.product
                                                                        .isMultiPly ==
                                                                    1
                                                                ? widget.product
                                                                        .shippingCost *
                                                                    details
                                                                        .quantity
                                                                : widget.product
                                                                        .shippingCost ??
                                                                    0,
                                                            ivariationModel: details
                                                                .variationModel(
                                                                    widget
                                                                        .product,
                                                                    details
                                                                        .dropdownValue),
                                                          );

                                                          // cart.variations = _variation;
                                                          if (Provider.of<
                                                                      AuthProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .isLoggedIn()) {
                                                            Provider.of<CartProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .addToCartAPI(
                                                                    cart,
                                                                    route,
                                                                    context);
                                                          } else {
                                                            Provider.of<CartProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .addToCart(
                                                                    cart);
                                                            //  Navigator.pop(context);
                                                            showCustomSnackBar(
                                                                getTranslated(
                                                                    'added_to_cart',
                                                                    context),
                                                                context,
                                                                isError: false);
                                                          }
                                                        }
                                                      }
                                                    }),
                                        ),
                                        Padding(
                                          padding: getPadding(bottom: 7,right: 5),
                                          child: Stack(

                                              children: [
                                            GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(CupertinoPageRoute(
                                                      builder: (context) => CartScreen()));
                                                },
                                                child: Image.asset(
                                                    Images.cart_arrow_down_image,
                                                    fit:  BoxFit.cover,
                                                    height: 45,
                                                    color: ColorResources.getPrimary(context))),

                                            Positioned(
                                              top: 0,
                                              right: 0,
                                              child:
                                              Consumer<CartProvider>(builder: (context, cart, child) {
                                                return Container(
                                                  height: 14,
                                                  width: 14,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: ColorResources.getPrimary(context),
                                                  ),
                                                  child: Text(
                                                    cart.cartList.length.toString(),

                                                    style: titilliumSemiBold.copyWith(
                                                        fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                                        color: Theme.of(context).highlightColor),
                                                  ),
                                                );
                                              }),
                                            )

                                          ]),
                                        )
                                      ],
                                    ),
                                  ),

                            Provider.of<CartProvider>(context).isLoading
                                ? Expanded(
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                          Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    width: Dimensions.PADDING_SIZE_DEFAULT),

                            /// buy now
                            // Provider.of<CartProvider>(context).isLoading ? SizedBox() :
                            // CustomButton(isBuy:true,
                            //     buttonText: getTranslated(_stock < 1 ? 'out_of_stock' : 'buy_now', context),
                            //     onTap: _stock < 1  ? null :() {
                            //       if  ( Provider.of<ProductDetailsProvider>(context, listen: false).dropdownValue == null){
                            //         Fluttertoast.showToast(
                            //             msg: 'يرجى تحديد المقاس',
                            //             toastLength: Toast.LENGTH_SHORT,
                            //             gravity: ToastGravity.BOTTOM,
                            //             timeInSecForIosWeb: 1,
                            //             backgroundColor: Colors.red,
                            //             textColor: Colors.white,
                            //             fontSize: 16.0
                            //         ); }
                            //       if(_stock > 0 ) {
                            //         CartModel cart = CartModel(
                            //             widget.product.id, widget.product.thumbnail, widget.product.name,
                            //             widget.product.addedBy == 'seller' ?
                            //             '${Provider.of<SellerProvider>(context, listen: false).sellerModel.seller.fName} '
                            //                 '${Provider.of<SellerProvider>(context, listen: false).sellerModel.seller.lName}' : 'admin',
                            //             price, priceWithDiscount, details.quantity, _stock,
                            //             widget.product.colors.length > 0 ? widget.product.colors[details.variantIndex].name : '',
                            //             widget.product.colors.length > 0 ? widget.product.colors[details.variantIndex].code : '',
                            //             widget.product.discount, widget.product.discountType, widget.product.tax,
                            //             widget.product.taxType, 1, '',widget.product.userId,'','','',
                            //             widget.product.isMultiPly==1? widget.product.shippingCost*details.quantity : widget.product.shippingCost ??0
                            //             , ivariationModel:details. variationModel(widget.product,details.dropdownValue)
                            //         );
                            //
                            //
                            //         // cart.variations = _variation;
                            //         if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
                            //           Provider.of<CartProvider>(context, listen: false).addToCartAPI(
                            //               cart, route, context).
                            //           then((value) {
                            //             if(value.response.statusCode == 200){
                            //               _navigateToNextScreen(context);
                            //             }
                            //           }
                            //           );
                            //         }else {
                            //           // print('kissu koyna');
                            //           Fluttertoast.showToast(
                            //               msg: getTranslated('Login_Msg', context),
                            //               toastLength: Toast.LENGTH_SHORT,
                            //               gravity: ToastGravity.CENTER,
                            //               timeInSecForIosWeb: 1,
                            //               backgroundColor: Colors.green,
                            //               textColor: Colors.white,
                            //               fontSize: 16.0
                            //           );
                            //           Navigator.of(context).push(CupertinoPageRoute(builder: (context) => AuthScreen()));
                            //         }
                            //       }}),
                          ],
                        ),
// BottomCartView(product: widget.product),

                        body: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              widget.product != null
                                  ?

                                  ///the image of the product
                                  InkWell(
                                      onTap: () {
                        Navigator.push(
                        context,
                        CupertinoPageRoute(
                        builder: (context) =>
                        ProductsImageView(
                        product: widget.product,
                        imagesList: details
                            .imagesList(widget
                            .product))));

                        },



                                      child: ProductImageView(
                                        productModel: widget.product,
                                        imagesList:
                                            details.imagesList(widget.product),
                                      ))
                                  : SizedBox(),

                              /// product details
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -25.0, 0.0),
                                padding: EdgeInsets.only(
                                    top: Dimensions.FONT_SIZE_DEFAULT),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).canvasColor,
                                  // borderRadius: BorderRadius.only(topLeft:Radius.circular(Dimensions.PADDING_SIZE_EXTRA_LARGE),
                                  //     topRight:Radius.circular(Dimensions.PADDING_SIZE_EXTRA_LARGE) ),
                                ),
                                child: Column(
                                  children: [
                                    ///the name and the price and the discounted price and the old  choice and  old clolr of the product
                                    ProductTitleView(
                                        productModel: widget.product),
                                    //MoreChoiceProduct(productModel: widget.product,),

                                    /// the move of the cartbottom to the details page it self
                                    // CartBottomSheet(product: widget.product,),

                                    /// the new colors of the products
                                    widget.product.productType !=
                                            ProductVarType.productNormal
                                        ? (widget.product.productType ==
                                                ProductVarType
                                                    .productWithColorSize
                                            ? (widget.product.productsizelist
                                                        .length >
                                                    0
                                                ? Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                              '${getTranslated('select_variant' /*color*/, context)} : ',
                                                              style: titilliumRegular
                                                                  .copyWith(
                                                                      fontSize:
                                                                          Dimensions
                                                                              .FONT_SIZE_DEFAULT)),
                                                          Expanded(
                                                            child: SizedBox(
                                                              height: 105,
                                                              child: ListView
                                                                  .builder(
                                                                itemCount: widget
                                                                    .product
                                                                    .productsizelist
                                                                    .length,
                                                                shrinkWrap:
                                                                    true,
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                itemBuilder:
                                                                    (ctx,
                                                                        index) {
                                                                  return InkWell(
                                                                    onTap: () {
                                                                      // _change((){
                                                                      //   _currentColorName=widget.product.colors[index].name;
                                                                      //
                                                                      // });
                                                                      //
                                                                      // _currentColorName = widget
                                                                      //     .product
                                                                      //     .productColorsList[index]
                                                                      //     .code;

                                                                      Provider.of<ProductDetailsProvider>(context, listen: false).setCartVariantIndex(
                                                                          index,
                                                                          withRefresh:
                                                                              true);
                                                                      //  print("vvv3 ${widget.product.filteredproductsizelist(details.variantIndex).size[index].code}");
                                                                      //   print("sizes are  ${widget.product.filteredproductsizelist(details .variantIndex).size[index].name}");

                                                                      //details.setsize(widget.product.filteredproductsizelist(details.variantIndex).size[0].code);
                                                                      Provider.of<ProductDetailsProvider>(
                                                                              context,
                                                                              listen: false)
                                                                          .dropdownValue = null;
                                                                      //   widget.product.filteredproductsizelist(details.variantIndex).size[0];
                                                                    },
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                          85,
                                                                          width:
                                                                          58,
                                                                          padding:
                                                                          EdgeInsets.all(1),
                                                                          alignment:
                                                                          Alignment.center,
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                                                              border: details.variantIndex == index ? Border.all(width: 1, color: ColorResources.getRed(context)) : null),
                                                                          child:
                                                                              FittedBox(
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
                                                                              imageUrl: '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productImageUrl}/${widget.product.productsizelist[index].images[0]}',
                                                                              ),
                                                                            ),
                                                                        ),
                                                                        // Text('${widget.product.productsizelist[index].code}' ,style: robotoRegular,),
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox())
                                            : widget.product.productType ==
                                                    ProductVarType
                                                        .productWithColor
                                                ? (widget
                                                            .product
                                                            .productColorsList
                                                            .length >
                                                        0
                                                    ? Row(
                                                        children: [
                                                          Text(
                                                              '${getTranslated('select_variant', context)} : ',
                                                              style: titilliumRegular
                                                                  .copyWith(
                                                                      fontSize:
                                                                          Dimensions
                                                                              .FONT_SIZE_DEFAULT)),
                                                          SizedBox(
                                                            height: 80,
                                                            child: ListView
                                                                .builder(
                                                              itemCount: widget
                                                                  .product
                                                                  .productColorsList
                                                                  .length,
                                                              shrinkWrap: true,
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              itemBuilder:
                                                                  (ctx, index) {
                                                                return InkWell(
                                                                  onTap: () {
                                                                    Provider.of<ProductDetailsProvider>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .setImageSliderSelectedIndexZero();

                                                                    // print(
                                                                    //     'sliderIndex ${Provider.of<ProductDetailsProvider>(context, listen: false).imageSliderIndex}');

                                                                    Provider.of<ProductDetailsProvider>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .setCartVariantIndex(
                                                                            index);

                                                                    /// zaid
                                                                    // Provider.of<ProductDetailsProvider>(context, listen: false).initData(widget.product);
                                                                    //  details.setsize(widget.product.filteredproductsizelist(details.variantIndex).size[0].code);

                                                                    //  print( widget.product.productColorsList.length);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(Dimensions
                                                                                .PADDING_SIZE_EXTRA_SMALL),
                                                                        border: details.variantIndex ==
                                                                                index
                                                                            ? Border.all(
                                                                                width: 1,
                                                                                color: ColorResources.getRed(context))
                                                                            : null),
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          85,
                                                                      width: 58,
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              1),
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          FittedBox(
                                                                        //mohd11
                                                                        fit: BoxFit
                                                                            .fill,

                                                                        child:
                                                                            CachedNetworkImage(
                                                                          errorWidget: (context, url, error) =>
                                                                              Image.asset(
                                                                            Images.placeholder,
                                                                            fit:
                                                                                BoxFit.fill,
                                                                          ),
                                                                          placeholder: (context, url) =>
                                                                              Image.asset(
                                                                            Images.placeholder,
                                                                            fit:
                                                                                BoxFit.fill,
                                                                          ),
                                                                          imageUrl:
                                                                              '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productImageUrl}/${widget.product.productColorsList[index].images[0]}',
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : SizedBox())
                                                : SizedBox())
                                        : SizedBox(),

                                    ///the new bottom cart
                                    Consumer<ProductDetailsProvider>(
                                      builder: (ctx, details, child) {
                                        ///zaid
                                        // widget.product.productType!= ProductVarType.productNormal?  details.setsize(widget.product.filteredproductsizelist(details.variantIndex).size[0].code):SizedBox();

                                        double price = widget.product.unitPrice;
                                        double priceWithDiscount =
                                            PriceConverter.convertWithDiscount(
                                                context,
                                                price,
                                                widget.product.discount,
                                                widget.product.discountType);
                                        double priceWithQuantity =
                                            priceWithDiscount *
                                                details.quantity;
                                        String ratting = widget
                                                        .product.rating !=
                                                    null &&
                                                widget.product.rating.length !=
                                                    0
                                            ? widget.product.rating[0].average
                                            : "0";
                                        List<String> _variationList = [];
                                        Variation _variation;
                                        String _variantName = "";
                                        String variationType = '';
                                        String imgPath = '';
                                        Widget varBody = Container();
                                        if (widget.product.productType ==
                                            ProductVarType.productNormal) {
                                          _stock = widget.product.currentStock;
                                          try {
                                            imgPath =
                                                widget.product.images.first;
                                          } catch (r) {}
                                        } else {
                                          _variantName =
                                              widget.product.variation.length !=
                                                      0
                                                  ? widget
                                                      .product
                                                      .variation[
                                                          details.variantIndex]
                                                      .file
                                                  : null;
                                          for (int index = 0;
                                              index <
                                                  widget.product.choiceOptions
                                                      .length;
                                              index++) {
                                            _variationList.add(widget
                                                .product
                                                .choiceOptions[index]
                                                .options[details
                                                    .variationIndex[index]]
                                                .trim());
                                          }
                                          if (_variantName != null) {
                                            variationType = _variantName;
                                            _variationList.forEach(
                                                (variation) => variationType =
                                                    '$variationType-$variation');
                                          } else {
                                            bool isFirst = true;
                                            _variationList.forEach((variation) {
                                              if (isFirst) {
                                                variationType =
                                                    '$variationType$variation';
                                                isFirst = false;
                                              } else {
                                                variationType =
                                                    '$variationType-$variation';
                                              }
                                            });
                                          }

                                          variationType =
                                              variationType.replaceAll(' ', '');
                                          for (Variation variation
                                              in widget.product.variation) {
                                            if (variation.type ==
                                                variationType) {
                                              price = variation.price;
                                              _variation = variation;
                                              //  _stock = variation.qty;
                                              break;
                                            }
                                          }
                                          if (widget.product.productType ==
                                              ProductVarType
                                                  .productWithColorSize) {
                                            /// zaid
                                            if (details.selectedSizeCode !=
                                                "") {
                                              // _stock = int.parse(widget.product.filteredproductsizelist(details.variantIndex).size.where((element) => element.code==details.selectedSizeCode).first.qunt);
                                              // print("jjjjj $_stock");
                                              // _stock = details.sizeStoke(widget.product
                                              //     .filteredproductsizelist(details.variantIndex)
                                              //     .size.firstWhere((element) => element.id==details.selectedSizeCode).qunt);
                                            } else {
                                              _stock = 1;
                                            }
                                            print(
                                                "$_stock first the index ${widget.product.filteredproductsizelist(details.variantIndex).size.length}");

                                            try {
                                              imgPath = widget
                                                  .product
                                                  .productsizelist[
                                                      details.variantIndex]
                                                  .images[0];
                                            } catch (r) {}
                                            varBody = Column(
                                              children: [
                                                widget.product
                                                            .filteredproductsizelist(
                                                                details
                                                                    .variantIndex)
                                                            .size
                                                            .length >
                                                        0
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          top: 8,
                                                          bottom: 8,
                                                        ),
                                                        child: Row(children: [
                                                          // Text('المقاس : ',
                                                          //     style: titilliumRegular.copyWith(
                                                          //         fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                                                          SizedBox(
                                                              width: Dimensions
                                                                  .PADDING_SIZE_DEFAULT),
                                                          Expanded(
                                                            flex: 6,
                                                            child: StatefulBuilder(
                                                                builder: (context,
                                                                    _change) {
                                                              // details.dropdownValue = null;
                                                              return Column(
                                                                children: [
                                                                  widget.product
                                                                              .productType ==
                                                                          ProductVarType
                                                                              .productWithColorSize
                                                                      ? SizedBox(
                                                                          height:
                                                                              40,
                                                                          child:
                                                                              /*  ListView.builder(
                                                                                  itemCount: widget.product.filteredproductsizelist(details.variantIndex).size.length,
                                                                                  shrinkWrap: true,
                                                                                  scrollDirection: Axis.horizontal,
                                                                                  itemBuilder: (ctx, index) {
                                                                                    print("vvv ${widget.product.filteredproductsizelist(details.variantIndex).size[index].code}");
                                                                                    print("vvv2 ${details.selectedSizeCode}");
                                                                                    bool isSelected = widget.product.filteredproductsizelist(details.variantIndex).size[index].code == details.selectedSizeCode;

                                                                                    String colorString = '0xffF0F8FF'; //+widget.product.productsizelist[index].code.substring(1, 7);

                                                                                    /// zaid  ?? consumer
                                                                                    return InkWell(
                                                                                      onTap: () {
                                                                                        // print("vvv3 ${widget.product.filteredproductsizelist(details.variantIndex).size[index].code}");
                                                                                        // print("vvv10 ${widget.product.filteredproductsizelist(details .variantIndex).size[index].name}");

                                                                                        details.setsize(widget.product.filteredproductsizelist(details.variantIndex).size[index].name);
                                                                                      },
                                                                                      child: Container(
                                                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL), border: isSelected ? Border.all(width: 1, color: Theme.of(context).primaryColor) : null),
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                                                                          child: Container(
                                                                                            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                                                                            alignment: Alignment.center,
                                                                                            decoration: BoxDecoration(
                                                                                              //  color: Color(int.parse(colorString)),

                                                                                              borderRadius: BorderRadius.circular(5),
                                                                                            ),
                                                                                            child: Text(widget.product.filteredproductsizelist(details.variantIndex).size[index].name),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                )*/
                                                                              DecoratedBox(
                                                                                  decoration: BoxDecoration(
                                                                                      color: Colors.white, //background color of dropdown button
                                                                                      border: Border.all(color: Colors.black38, width: 1), //border of dropdown button
                                                                                      borderRadius: BorderRadius.circular(5), //border raiuds of dropdown button
                                                                                      boxShadow: <BoxShadow>[
                                                                                        //apply shadow on Dropdown button
                                                                                        BoxShadow(
                                                                                            color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                                                                                            blurRadius: 1) //blur radius of shadow
                                                                                      ]),
                                                                                  child: Padding(
                                                                                      padding: EdgeInsets.only(left: 20, right: 10),
                                                                                      child: DropdownButton(
                                                                                        hint: Text(
                                                                                          'اختر المقاس',
                                                                                          style: robotoBold.copyWith(color: Colors.black),
                                                                                        ),

                                                                                        value: details.dropdownValue == null ? null : details.dropdownValue,
                                                                                        items: widget.product
                                                                                            .filteredproductsizelist(details.variantIndex)
                                                                                            .size
                                                                                            .map(
                                                                                              (map) => DropdownMenuItem(
                                                                                                enabled: map.qunt != "0",
                                                                                                onTap: () {
                                                                                                  details.dropdownValue = map;
                                                                                                  //print('ssssss' + details.dropdownValue.code);
                                                                                                },
                                                                                                child: MediaQuery(
                                                                                                  data: MediaQuery.of(context).copyWith(textScaleFactor: AppConstants.textScaleFactior),
                                                                                                  child: Row(
                                                                                                    children: [
                                                                                                      Text(
                                                                                                        map.name,
                                                                                                        style: robotoBold.copyWith(color: map.qunt == "0" ? Colors.grey : Colors.black),
                                                                                                      ),
                                                                                                      Expanded(child: Container()),
                                                                                                      map.qunt == "0"
                                                                                                          ? Row(
                                                                                                              children: [
                                                                                                                Text(
                                                                                                                  " نفذت الكمية ",
                                                                                                                  style: robotoBold.copyWith(color: Colors.grey),
                                                                                                                ),
                                                                                                                Consumer<ProductDetailsProvider>(
                                                                                                                  builder: (context, value1, child) => Row(
                                                                                                                    children: [
                                                                                                                      Transform.scale(
                                                                                                                        scale: 0.8,
                                                                                                                        child: Radio(
                                                                                                                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                                                                                                              (Set<MaterialState> states) {
                                                                                                                                if (states.contains(MaterialState.selected)) {
                                                                                                                                  return Colors.green; // Change this to your desired color when the radio button is selected
                                                                                                                                }
                                                                                                                                return Colors.red; // Change this to your desired color when the radio button is not selected
                                                                                                                              },
                                                                                                                            ),
                                                                                                                            toggleable: true,
                                                                                                                            value: "radio value",
                                                                                                                            groupValue: value1.radioValue,
                                                                                                                            onChanged: (value) {
                                                                                                                              print("aaa" + value1.isRadioSelected.toString());
                                                                                                                              value1.radioValue = value;
                                                                                                                            }),
                                                                                                                      ),
                                                                                                                      value1.isRadioSelected
                                                                                                                          ? Row(
                                                                                                                              children: [
                                                                                                                                Transform.scale(
                                                                                                                                    scale: 0.7,
                                                                                                                                    child: Icon(
                                                                                                                                      Icons.check_circle,
                                                                                                                                      color: Colors.green,
                                                                                                                                    )),
                                                                                                                                Text(
                                                                                                                                  "سيتم اشعارك",
                                                                                                                                  style: robotoBold.copyWith(color: Colors.green),
                                                                                                                                ),
                                                                                                                              ],
                                                                                                                            )
                                                                                                                          : Text(
                                                                                                                              "اشعرني",
                                                                                                                              style: robotoBold.copyWith(color: Colors.green),
                                                                                                                            ),
                                                                                                                    ],
                                                                                                                  ),
                                                                                                                ),

                                                                                                                //  Text(map.qunt),
                                                                                                              ],
                                                                                                            )
                                                                                                          : map.qunt == "1"
                                                                                                              ? Row(
                                                                                                                  children: [
                                                                                                                    Text(" متبقي ", style: robotoBold.copyWith(color: Colors.grey)),
                                                                                                                    Text(map.qunt, style: robotoBold.copyWith(color: Colors.grey)),
                                                                                                                    Text("  فقط ", style: robotoBold.copyWith(color: Colors.grey)),
                                                                                                                  ],
                                                                                                                )
                                                                                                              : SizedBox()
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                                value: map,
                                                                                              ),
                                                                                            )
                                                                                            .toList(),
                                                                                        onChanged: (value) {
                                                                                          //get value when changed
                                                                                          _change(() {
                                                                                            details.dropdownValue = value;
                                                                                            details.setsize(details.dropdownValue.code);
                                                                                          });

                                                                                          print("You have selected " + details.dropdownValue.id);
                                                                                          print("the qty of the selected color is " + details.dropdownValue.qunt);
                                                                                          /*

                                                            details.selectedSizeCode = value as String ;
                                                            print('ssss is '+ details.selectedSizeCode);*/
                                                                                          // details.variantIndex = value as int;
                                                                                        },
                                                                                        icon: Padding(
                                                                                            //Icon at tail, arrow (moov1)bottom is default icon
                                                                                            padding: EdgeInsets.only(right: 50),
                                                                                            child: Icon(Icons.keyboard_arrow_down_sharp)),
                                                                                        iconEnabledColor: Colors.black, //Icon color
                                                                                        style: TextStyle(
                                                                                            //te
                                                                                            color: Colors.black, //Font color
                                                                                            fontSize: 20 //font size on dropdown button
                                                                                            ),

                                                                                        dropdownColor: Colors.white, //dropdown background color
                                                                                        underline: Container(), //remove underline
                                                                                        isExpanded: true, //make true to make width 100%
                                                                                      ))),
                                                                        )
                                                                      : (widget.product.productType ==
                                                                              ProductVarType.productNormal
                                                                          ? Text("normel")
                                                                          : widget.product.productType == ProductVarType.productWithColor
                                                                              ? SizedBox(
                                                                                  height: 40,
                                                                                  child: ListView.builder(
                                                                                    itemCount: widget.product.productColorsList.length,
                                                                                    shrinkWrap: true,
                                                                                    scrollDirection: Axis.horizontal,
                                                                                    itemBuilder: (ctx, index) {
                                                                                      String colorString = '0xff' + widget.product.productColorsList[index].code.substring(1, 7);
                                                                                      return InkWell(
                                                                                        onTap: () {
                                                                                          _change(() {
                                                                                            _currentColorName = widget.product.productColorsList[index].code;
                                                                                          });

                                                                                          Provider.of<ProductDetailsProvider>(context, listen: false).setCartVariantIndex(index);
                                                                                        },
                                                                                        child: Container(
                                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL), border: details.variantIndex == index ? Border.all(width: 1, color: Theme.of(context).primaryColor) : null),
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                                                                            child: Container(
                                                                                              height: Dimensions.topSpace,
                                                                                              width: Dimensions.topSpace,
                                                                                              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                                                                              alignment: Alignment.center,
                                                                                              decoration: BoxDecoration(
                                                                                                color: Color(int.parse(colorString)),
                                                                                                borderRadius: BorderRadius.circular(5),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                  ))
                                                                              : SizedBox()),
                                                                ],
                                                              );
                                                            }),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          //  widget.product.categoryIds.any((element) => element.id == 179)
                                                          widget.product
                                                                      .img_path !=
                                                                  null
                                                              ? Expanded(
                                                                  flex: 4,
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      print('the imageis' +
                                                                          widget
                                                                              .product
                                                                              .img_path
                                                                              .toString());

                                                                      showModalBottomSheet(
                                                                          context:
                                                                              context,
                                                                          isScrollControlled:
                                                                              true,
                                                                          backgroundColor: Colors
                                                                              .transparent,
                                                                          builder: (con) =>
                                                                              CustomBottomSheet(
                                                                                product: widget.product,
                                                                              ));
                                                                    },
                                                                    child: Row(
                                                                      children: [
                                                                        Image
                                                                            .asset(
                                                                          Images
                                                                              .ruler,
                                                                          height:
                                                                              40,
                                                                        ),
                                                                        Text(
                                                                          'دليل المقاسات',
                                                                          style: robotoBold.copyWith(
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        //Icon(Icons.read_more_rounded,color: Colors.black,)
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )
                                                              : SizedBox()
                                                        ]),
                                                      )
                                                    : SizedBox(),
                                                widget.product.colors.length > 0
                                                    ? SizedBox(
                                                        height: Dimensions
                                                            .PADDING_SIZE_SMALL)
                                                    : SizedBox(),
                                                //
                                                // (widget.product.details != null && widget.product.details.isNotEmpty) ?
                                                // SimpleExpandablePage(productSpecification:widget.product.details,) : SizedBox(),
                                              ],
                                            );
                                          }
                                          if (widget.product.productType ==
                                              ProductVarType.productWithColor) {
                                            if (widget.product.productColorsList
                                                    .length >
                                                0) {
                                              print(
                                                  "the index1 ${details.variantIndex}");
                                              try {
                                                imgPath = widget
                                                    .product
                                                    .productColorsList[
                                                        details.variantIndex]
                                                    .images[0];
                                              } catch (r) {}
                                              Color colorString =
                                                  HexColor.fromHex(widget
                                                      .product
                                                      .productColorsList[
                                                          details.variantIndex]
                                                      .val);

                                              _stock = widget
                                                  .product
                                                  .productColorsList[Provider
                                                          .of<ProductDetailsProvider>(
                                                              context,
                                                              listen: false)
                                                      .variantIndex]
                                                  .qunt;
                                              varBody = Column(
                                                children: [
                                                  /// second color
                                                  // widget.product
                                                  //     .productColorsList.length > 0 ?
                                                  // Row(children: [
                                                  //   // Text('${getTranslated('select_variant', context)} : ',
                                                  //   //     style: titilliumRegular.copyWith(
                                                  //   //         fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                                                  //   // SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                                                  //
                                                  //
                                                  //   // Expanded(
                                                  //   //   child: StatefulBuilder(
                                                  //   //
                                                  //   //       builder: (context, _change) {
                                                  //   //         return Column(
                                                  //   //           children: [
                                                  //   //             SizedBox(
                                                  //   //               height: 40,
                                                  //   //               child:Row(children: [
                                                  //   //
                                                  //   //                 Padding(
                                                  //   //                   padding: const EdgeInsets.all(
                                                  //   //                       Dimensions
                                                  //   //                           .PADDING_SIZE_EXTRA_SMALL),
                                                  //   //
                                                  //   //                   child: Container(
                                                  //   //                     height: Dimensions.topSpace,
                                                  //   //                     width: Dimensions.topSpace,
                                                  //   //                     padding: EdgeInsets.all(
                                                  //   //                         Dimensions
                                                  //   //                             .PADDING_SIZE_EXTRA_SMALL),
                                                  //   //                     alignment: Alignment.center,
                                                  //   //                     decoration: BoxDecoration(
                                                  //   //                       color:colorString,
                                                  //   //                       borderRadius: BorderRadius
                                                  //   //                           .circular(5),),
                                                  //   //                   ),
                                                  //   //                 )
                                                  //   //               ],),
                                                  //   //             )
                                                  //   //
                                                  //   //
                                                  //   //           ],
                                                  //   //         );
                                                  //   //       }
                                                  //   //   ),
                                                  //   // ),
                                                  //
                                                  //
                                                  // ]) : SizedBox(),
                                                  widget.product.colors.length >
                                                          0
                                                      ? SizedBox(
                                                          height: Dimensions
                                                              .PADDING_SIZE_SMALL)
                                                      : SizedBox(),
                                                  //
                                                ],
                                              );
                                            }
                                          }
                                        }
                                        print("the stack ${_stock}");
                                        return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              /// Close Button
                                              /*Align(alignment: Alignment.centerRight, child: InkWell(
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
                              )),*/

                                              ///  Product details
                                              /*Column(
                                children: [
                                  Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              color: ColorResources.getImageBg(context),
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(width: .5,color: Theme.of(context).primaryColor.withOpacity(.20))
                                          ),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.contain,
                                            placeholder: (context, url) =>
                                                Image.asset(Images.placeholder,fit: BoxFit.cover),
                                            errorWidget: (context, url, error) => Image.asset(
                                              Images.placeholder,
                                              fit: BoxFit.cover,
                                            ),

                                            imageUrl: '${Provider.of<SplashProvider>(context,listen: false).baseUrls.productImageUrl}/${imgPath}',
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        Expanded(
                                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(widget.product.name ?? '',
                                                    style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),
                                                    maxLines: 2, overflow: TextOverflow.ellipsis),

                                                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                                                Row(
                                                  children: [
                                                    Icon(Icons.star,color: Colors.orange),
                                                    Text(double.parse(ratting).toStringAsFixed(1),
                                                        style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),
                                                        maxLines: 2, overflow: TextOverflow.ellipsis),
                                                  ],
                                                ),



                                              ]),
                                        ),




                                      ]),
                                  Row(
                                    children: [
                                      widget.product.discount > 0 ?
                                      Container(
                                        margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color:Theme.of(context).primaryColor,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            PriceConverter.percentageCalculation(context, widget.product.unitPrice,
                                                widget.product.discount, widget.product.discountType),
                                            style: titilliumRegular.copyWith(color: Theme.of(context).cardColor,
                                                fontSize: Dimensions.FONT_SIZE_DEFAULT),
                                          ),
                                        ),
                                      ) : SizedBox(width: 93),
                                      SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                                      widget.product.discount > 0 ? Text(
                                        PriceConverter.convertPrice(context, widget.product.unitPrice),
                                        style: titilliumRegular.copyWith(color: ColorResources.getRed(context),
                                            decoration: TextDecoration.lineThrough),
                                      ) : SizedBox(),
                                      SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                                      Text(
                                        PriceConverter.convertPrice(context, widget.product.unitPrice, discountType: widget.product.discountType, discount: widget.product.discount),
                                        style: titilliumRegular.copyWith(color: ColorResources.getPrimary(context), fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),*/

                                              ///the widget that determaies the type of the product and the way of the showing in the screen
                                              varBody,

                                              ///quantity
                                              // Row(children: [
                                              //   Text(getTranslated('quantity', context), style: robotoBold),
                                              //   QuantityButton(isIncrement: false, quantity: details.quantity, stock: _stock),
                                              //   Text(details.quantity.toString(), style: titilliumSemiBold),
                                              // ]),
                                              // SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                                              ///total price
                                              // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                              //   Text(getTranslated('total_price', context), style: robotoBold),
                                              //   SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                                              //   Text(PriceConverter.convertPrice(context, priceWithQuantity),
                                              //     style: titilliumBold.copyWith(color: ColorResources.getPrimary(context), fontSize: Dimensions.FONT_SIZE_LARGE),
                                              //   ),
                                              // ]),
                                              // SizedBox(height: Dimensions.PADDING_SIZE_SMALL),


                                              (widget.product.details != null||widget.product.model_number!=null ||widget.product.details2!=null) ?
                                              SimpleExpandablePage(
                                                      productSpecification:
                                                          widget
                                                              .product.details,modelNumber: widget.product.model_number,productSpecification2: widget.product.details2,)
                                                  : SizedBox(),

                                              /// add to cart and buy now bottoms (moov)
                                              // Row(children: [
                                              //   Provider.of<CartProvider>(context).isLoading ?
                                              //
                                              //   Center(
                                              //     child: CircularProgressIndicator(
                                              //       valueColor: new AlwaysStoppedAnimation<Color>(
                                              //         Theme.of(context).primaryColor,
                                              //       ),
                                              //     ),
                                              //   ) :
                                              //
                                              //   Expanded(
                                              //     child: CustomButton(buttonText: getTranslated(_stock < 1 ?
                                              //     'out_of_stock' : 'add_to_cart', context),
                                              //         onTap: _stock < 1  ? null :() {
                                              //           if(_stock > 0 ) {
                                              //             CartModel cart = CartModel(
                                              //               widget.product.id,
                                              //
                                              //               widget.product.thumbnail,
                                              //               widget.product.name,
                                              //               widget.product.addedBy == 'seller' ? '${Provider.of<SellerProvider>(context, listen: false).sellerModel.seller.fName} ''${Provider.of<SellerProvider>(context, listen: false).sellerModel.seller.lName}' : 'admin',
                                              //               price, priceWithDiscount, details.quantity, _stock,
                                              //               widget.product.name,
                                              //               "widget.product.",
                                              //               //   widget.product.colors.length > 0 ? widget.product.colors[details.variantIndex].name : '',
                                              //               // widget.product.colors.length > 0 ? widget.product.colors[details.variantIndex].code : '',
                                              //               widget.product.discount, widget.product.discountType, widget.product.tax,
                                              //               widget.product.taxType, 1, '',widget.product.userId,'','','',
                                              //               widget.product.isMultiPly==1? widget.product.shippingCost*details.quantity : widget.product.shippingCost ??0,
                                              //               ivariationModel:details. variationModel(widget.product),
                                              //
                                              //
                                              //
                                              //             );
                                              //
                                              //
                                              //
                                              //             // cart.variations = _variation;
                                              //             if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
                                              //               Provider.of<CartProvider>(context, listen: false).addToCartAPI(
                                              //                   cart, route, context);
                                              //             }else {
                                              //               Provider.of<CartProvider>(context, listen: false).addToCart(cart);
                                              //               Navigator.pop(context);
                                              //               showCustomSnackBar(getTranslated('added_to_cart', context), context, isError: false);
                                              //             }
                                              //
                                              //           }}),),
                                              //   SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                                              //
                                              //
                                              //   Provider.of<CartProvider>(context).isLoading ? SizedBox() :
                                              //   Expanded(
                                              //     child: CustomButton(isBuy:true,
                                              //         buttonText: getTranslated(_stock < 1 ? 'out_of_stock' : 'buy_now', context),
                                              //         onTap: _stock < 1  ? null :() {
                                              //           if(_stock > 0 ) {
                                              //             CartModel cart = CartModel(
                                              //                 widget.product.id, widget.product.thumbnail, widget.product.name,
                                              //                 widget.product.addedBy == 'seller' ?
                                              //                 '${Provider.of<SellerProvider>(context, listen: false).sellerModel.seller.fName} '
                                              //                     '${Provider.of<SellerProvider>(context, listen: false).sellerModel.seller.lName}' : 'admin',
                                              //                 price, priceWithDiscount, details.quantity, _stock,
                                              //                 widget.product.colors.length > 0 ? widget.product.colors[details.variantIndex].name : '',
                                              //                 widget.product.colors.length > 0 ? widget.product.colors[details.variantIndex].code : '',
                                              //                 widget.product.discount, widget.product.discountType, widget.product.tax,
                                              //                 widget.product.taxType, 1, '',widget.product.userId,'','','',
                                              //                 widget.product.isMultiPly==1? widget.product.shippingCost*details.quantity : widget.product.shippingCost ??0
                                              //                 , ivariationModel:details. variationModel(widget.product)
                                              //             );
                                              //
                                              //
                                              //             // cart.variations = _variation;
                                              //             if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
                                              //               Provider.of<CartProvider>(context, listen: false).addToCartAPI(
                                              //                   cart, route, context).
                                              //               then((value) {
                                              //                 if(value.response.statusCode == 200){
                                              //                   _navigateToNextScreen(context);
                                              //                 }
                                              //               }
                                              //               );
                                              //             }else {
                                              //               // print('kissu koyna');
                                              //               Fluttertoast.showToast(
                                              //                   msg: getTranslated('Login_Msg', context),
                                              //                   toastLength: Toast.LENGTH_SHORT,
                                              //                   gravity: ToastGravity.CENTER,
                                              //                   timeInSecForIosWeb: 1,
                                              //                   backgroundColor: Colors.green,
                                              //                   textColor: Colors.white,
                                              //                   fontSize: 16.0
                                              //               );
                                              //               Navigator.of(context).push(CupertinoPageRoute(builder: (context) => AuthScreen()));
                                              //             }
                                              //           }}),
                                              //   ),
                                              // ],),
                                            ]);
                                      },
                                    ),

                                    /// the video url  of the prodcut
                                    widget.product.videoUrl != null
                                        ? YoutubeVideoWidget(
                                            url: widget.product.videoUrl)
                                        : SizedBox(),

                                    /// the seller of the product if we activate  the multivindor
                            AppConstants.showSellerInfo?
                            widget.product.addedBy == 'seller'
                                        ? SellerView(
                                            sellerId: widget.product.userId
                                                .toString())
                                        : SizedBox.shrink():SizedBox(),

                                    ///customer review
                                    revList.length > 0
                                        ? Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: EdgeInsets.only(
                                                top: Dimensions
                                                    .PADDING_SIZE_SMALL),
                                            padding: EdgeInsets.all(Dimensions
                                                .PADDING_SIZE_DEFAULT),
                                            color: Theme.of(context).cardColor,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    getTranslated(
                                                        'customer_reviews',
                                                        context),
                                                    style: titilliumSemiBold
                                                        .copyWith(
                                                            fontSize: Dimensions
                                                                .FONT_SIZE_LARGE),
                                                  ),
                                                  SizedBox(
                                                    height: Dimensions
                                                        .PADDING_SIZE_DEFAULT,
                                                  ),
                                                  Container(
                                                    width: 230,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      color: ColorResources
                                                          .visitShop(context),
                                                      borderRadius: BorderRadius
                                                          .circular(Dimensions
                                                              .PADDING_SIZE_EXTRA_LARGE),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        RatingBar(
                                                          rating: double.parse(
                                                              ratting),
                                                          size: 18,
                                                        ),
                                                        SizedBox(
                                                            width: Dimensions
                                                                .PADDING_SIZE_DEFAULT),
                                                        Text('${double.parse(ratting).toStringAsFixed(1)}' +
                                                            ' ' +
                                                            '${getTranslated('out_of_5', context)}'),
                                                      ],
                                                    ),
                                                  ),

                                                  SizedBox(
                                                      height: Dimensions
                                                          .PADDING_SIZE_DEFAULT),
                                                  //Text('${getTranslated('total', context)}' + ' '+'${details.reviewList != null ? details.reviewList.length : 0}' +' '+ '${getTranslated('reviews', context)}'),

                                                  details.reviewList != null
                                                      ? details.reviewList
                                                                  .length !=
                                                              0
                                                          ? ReviewWidget(
                                                              reviewModel: details
                                                                  .reviewList[0])
                                                          : SizedBox()
                                                      : ReviewShimmer(),
                                                  details.reviewList != null
                                                      ? details.reviewList
                                                                  .length >
                                                              1
                                                          ? ReviewWidget(
                                                              reviewModel: details
                                                                  .reviewList[1])
                                                          : SizedBox()
                                                      : ReviewShimmer(),
                                                  details.reviewList != null
                                                      ? details.reviewList
                                                                  .length >
                                                              2
                                                          ? ReviewWidget(
                                                              reviewModel: details
                                                                  .reviewList[2])
                                                          : SizedBox()
                                                      : ReviewShimmer(),

                                                  InkWell(
                                                      onTap: () {
                                                        if (details
                                                                .reviewList !=
                                                            null) {
                                                          Navigator.push(
                                                              context,
                                                              CupertinoPageRoute(
                                                                  builder: (_) =>
                                                                      ReviewScreen(
                                                                          reviewList:
                                                                              details.reviewList)));
                                                        }
                                                      },
                                                      child: details.reviewList !=
                                                                  null &&
                                                              details.reviewList
                                                                      .length >
                                                                  3
                                                          ? Text(
                                                              getTranslated(
                                                                  'view_more',
                                                                  context),
                                                              style: titilliumRegular.copyWith(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor),
                                                            )
                                                          : SizedBox())
                                                ]),
                                          )
                                        : SizedBox(),

                                    /// the order of the product according to the seller
                                    widget.product.addedBy == 'seller'
                                        ? Padding(
                                            padding: EdgeInsets.all(Dimensions
                                                .PADDING_SIZE_DEFAULT),
                                            child: TitleRow(
                                                title: getTranslated(
                                                    'more_from_the_shop',
                                                    context),
                                                isDetailsPage: true),
                                          )
                                        : SizedBox(),

                                    /// the seller
                                    widget.product.addedBy == 'seller'
                                        ? Padding(
                                            padding: EdgeInsets.all(Dimensions
                                                .PADDING_SIZE_EXTRA_SMALL),
                                            child: ProductView1(
                                                isHomePage: true,
                                                productType:
                                                    ProductType.SELLER_PRODUCT,
                                                scrollController:
                                                    _scrollController,
                                                sellerId: widget.product.userId
                                                    .toString()),
                                          )
                                        : SizedBox(),

                                    Row(
                                      children: [
                                        SizedBox(width: 4),
                                        Expanded(

                                          flex: 4,
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SvgPicture.asset(
                                              Images.del,
                                              width: 50,
                                              height: 50,
                                              //  semanticsLabel: 'A red up arrow'
                                            ),
                                            Text(
                                              "توصيل مجاني داخل صنعاء \n خلال 1 - 2 أيام",
                                              style: robotoBold.copyWith(
                                                  fontSize: 11),
                                            )
                                          ],
                                        )),

                                        Expanded(

                                            flex: 4,

                                            child: Row(
                                          children: [
                                            // SvgPicture.asset(Images.sdr, width: 30, height: 30, color: Colors.black,),
                                            SvgPicture.asset(
                                              Images.del2,
                                              width: 50,
                                              height: 50,
                                              // semanticsLabel: 'A red up arrow'
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      CupertinoPageRoute(
                                                          builder: (_) =>
                                                              HtmlViewScreen(
                                                                title: getTranslated(
                                                                    'terms_condition',
                                                                    context),
                                                                url: Provider.of<
                                                                            SplashProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .configModel
                                                                    .termsConditions,
                                                              )));
                                                },
                                                child: Column(
                                                  children: [
                                                    //       Text(" هذا المنتج قابل للأرجاع  \n خلال  10 ايام",style: robotoBold.copyWith(fontSize: 11),),
                                                    Text(
                                                      "تعرف على المنتجات  \n القابلة الارجاع ... >",
                                                      style:
                                                          robotoBold.copyWith(
                                                              fontSize: 11),
                                                    ),
                                                  ],
                                                ))
                                          ],
                                        )),

                                        SizedBox(
                                          width: 20,
                                        )
                                      ],
                                    ),

                                    ///related products
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: Dimensions.PADDING_SIZE_SMALL),
                                      // padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: Dimensions
                                                    .PADDING_SIZE_EXTRA_SMALL,
                                                vertical: Dimensions
                                                    .PADDING_SIZE_EXTRA_SMALL),
                                            child: TitleRow(
                                                title: getTranslated(
                                                    'related_products',
                                                    context),
                                                isDetailsPage: true),
                                          ),
                                          SizedBox(height: 5),
                                          RelatedProductView(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ))
                    : Scaffold(
                        body: NoInternetOrDataScreen(
                            isNoInternet: true,
                            child: ProductDetails(product: widget.product)));
              },
            ),
          )
        : SizedBox();
  }
}

class QuantityButton extends StatelessWidget {
  final bool isIncrement;
  final int quantity;
  final bool isCartWidget;
  final int stock;

  QuantityButton({
    @required this.isIncrement,
    @required this.quantity,
    @required this.stock,
    this.isCartWidget = false,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        print("000111");
        if (!isIncrement && quantity > 1) {
          print("000222");

          Provider.of<ProductDetailsProvider>(context, listen: false)
              .setQuantity(quantity - 1);
        } else if (isIncrement && quantity < stock) {
          print("000333");

          Provider.of<ProductDetailsProvider>(context, listen: false)
              .setQuantity(quantity + 1);
        }
      },
      icon: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border:
                Border.all(width: 1, color: Theme.of(context).primaryColor)),
        child: Icon(
          isIncrement ? Icons.add : Icons.remove,
          color: isIncrement
              ? quantity >= stock
                  ? ColorResources.getLowGreen(context)
                  : ColorResources.getPrimary(context)
              : quantity > 1
                  ? ColorResources.getPrimary(context)
                  : ColorResources.getTextTitle(context),
          size: isCartWidget ? 26 : 20,
        ),
      ),
    );
  }
}

void _navigateToNextScreen(BuildContext context) {
  Navigator.of(context)
      .push(CupertinoPageRoute(builder: (context) => CartScreen()));
}
