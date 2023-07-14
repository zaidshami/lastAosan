import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/view/basewidget/get_loading.dart';
import 'package:flutter_Aosan_ecommerce/view/screen/dashboard/dashboard_screen.dart';
import 'package:flutter_Aosan_ecommerce/view/screen/home/home_screens.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../data/model/response/cart_model.dart';
import '../../../helper/price_converter.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/cart_provider.dart';
import '../../../provider/location_provider.dart';
import '../../../provider/order_provider.dart';
import '../../../provider/remote_config_service.dart';
import '../../../provider/splash_provider.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../basewidget/animated_custom_dialog.dart';
import '../../basewidget/button/custom_button.dart';
import '../../basewidget/custom_app_bar.dart';
import '../../basewidget/empty_cart.dart';
import '../../basewidget/guest_dialog.dart';
import '../../basewidget/my_dialog.dart';
import '../../basewidget/no_internet_screen.dart';
import '../../basewidget/show_custom_snakbar.dart';
import '../checkout/checkout_screen.dart';
import '../checkout/widget/shipping_method_bottom_sheet.dart';
import 'widget/cart_widget.dart';
GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class CartScreen extends StatefulWidget {
  final bool fromCheckout;
  final int sellerId;
  CartScreen({this.fromCheckout = false, this.sellerId = 1});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  GoogleMapController _controller;
  Future<void> _loadData()async{

    if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
      //Provider.of<CartProvider>(context, listen: false).setSelectedShippingMethod(1,0);
     await Provider.of<CartProvider>(context, listen: false).getCartDataAPI(context);
      Provider.of<CartProvider>(context, listen: false).setCartData();

      if( Provider.of<SplashProvider>(context,listen: false).configModel.shippingMethod != 'sellerwise_shipping'){
        Provider.of<CartProvider>(context, listen: false).getAdminShippingMethodList(context);
      }

    }
  }

  @override
  void initState() {
    void initState() {
      // TODO: implement initState
      super.initState();
      // try {
      //   _checkPermission(() =>
      //       Provider.of<
      //           LocationProvider>(
      //           context, listen: false)
      //           .getCurrentLocation(
      //           context, true,
      //           mapController: _controller),
      //       context);
      // }catch(e){}
    }
   //Provider.of<OrderProvider>(context, listen: false).setAddressIndex(null);
    _loadData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<CartProvider>(context, listen: false).setQtyOutFalse();

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: AppConstants.textScaleFactior),
      child: Consumer<CartProvider>(builder: (context, cart, child) {
        double amount = 0.0;
        double shippingAmount = 0.0;
        double discount = 0.0;
        double tax = 0.0;
        List<CartModel> cartList = [];
        cartList.addAll(cart.cartList);


        //TODO: seller


        List<String> orderTypeShipping = [];
        List<String> sellerList = [];
        List<CartModel> sellerGroupList = [];
        List<List<CartModel>> cartProductList = [];
        List<List<int>> cartProductIndexList = [];
        for(CartModel cart in cartList) {
          if(!sellerList.contains(cart.cartGroupId)) {
            sellerList.add(cart.cartGroupId);
            sellerGroupList.add(cart);

          }
        }

        for(String seller in sellerList) {
          List<CartModel> cartLists = [];
          List<int> indexList = [];
          for(CartModel cart in cartList) {
            if(seller == cart.cartGroupId) {
              cartLists.add(cart);
              indexList.add(cartList.indexOf(cart));
            }
          }
          cartProductList.add(cartLists);
          cartProductIndexList.add(indexList);
        }

        sellerGroupList.forEach((seller) {
          if(seller.shippingType == 'order_wise'){
            orderTypeShipping.add(seller.shippingType);
          }
        });


        if(cart.getData && Provider.of<AuthProvider>(context, listen: false).isLoggedIn() && Provider.of<SplashProvider>(context,listen: false).configModel.shippingMethod =='sellerwise_shipping') {

          Provider.of<CartProvider>(context, listen: false).getShippingMethod(context, cartProductList);



        }

        for(int i=0;i<cart.cartList.length;i++){
          /*cart.cart.iproductModel.image!= null ? thumb = cart.cart.thumbnail: thumb = cart.cart.iproductModel.image;*/

          amount += (cart.cartList[i].price - cart.cartList[i].discount) * cart.cartList[i].quantity;
          discount += cart.cartList[i].discount * cart.cartList[i].quantity;
          tax += cart.cartList[i].tax * cart.cartList[i].quantity;
        }
        for(int i=0;i<cart.chosenShippingList.length;i++){
          shippingAmount += cart.chosenShippingList[i].shippingCost;
        }
        for(int j = 0; j< cartList.length; j++){
          shippingAmount += cart.cartList[j].shippingCost??0;

        }


        return Scaffold(
          key: _scaffoldKey,
          bottomNavigationBar: (!widget.fromCheckout && !cart.isLoading)
              ? Container(
            height: 80, padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,
              vertical: Dimensions.PADDING_SIZE_DEFAULT),

            decoration: BoxDecoration(

              color: cartList.isEmpty?null:Theme.of(context).cardColor,
              borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
            ),
            child: cartList.isNotEmpty ?
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Center(
                          child: Row(
                            children: [
                              Text('${getTranslated('total_price', context)}', style: titilliumSemiBold.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_LARGE),
                              ),
                              Text(PriceConverter.convertPrice(context, amount+shippingAmount), style: titilliumSemiBold.copyWith(
                                  color: Theme.of(context).primaryColor,fontSize: Dimensions.FONT_SIZE_LARGE),
                              ),
                            ],
                          ))),

/// check out botton
                  Builder(
                    builder: (context) => InkWell(
                      onTap: () {
                      //  Navigator.push(context, CupertinoPageRoute(builder: (_) => MyCustomWidget()));



                        // print('===asd=>${orderTypeShipping.length}');
                        if  (Provider.of<CartProvider>(context, listen: false).isQtyOut == true){
                          Fluttertoast.showToast(
                              msg: 'يرجى حـذف الاصناف الصفرية',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          ); }



                        else if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
                          if (cart.cartList.length == 0) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated('select_at_least_one_product', context)), backgroundColor: Colors.red,));
                          } else if(cart.chosenShippingList.length < orderTypeShipping.length &&
                              Provider.of<SplashProvider>(context,listen: false).configModel.shippingMethod =='sellerwise_shipping'){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated('select_all_shipping_method', context)), backgroundColor: Colors.red));
                          }else if(cart.chosenShippingList.length < 1 &&
                              Provider.of<SplashProvider>(context,listen: false).configModel.shippingMethod !='sellerwise_shipping' && Provider.of<SplashProvider>(context,listen: false).configModel.inHouseSelectedShippingType =='order_wise'){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated('select_all_shipping_method', context)), backgroundColor: Colors.red));
                          }


                          else {

                            Navigator.push(context, CupertinoPageRoute(builder: (_) => CheckoutScreen(
                              cartList: cartList,totalOrderAmount: amount,shippingFee: shippingAmount, discount: discount,
                              tax: tax,
                            )));

                          }
                        } else {showAnimatedDialog(context, GuestDialog(), isFlip: true);}


                      },

                      child: Container(width: MediaQuery.of(context).size.width/2.5,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                                vertical: Dimensions.FONT_SIZE_SMALL),
                            child: Text(getTranslated('checkout', context),
                                style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                  color: Theme.of(context).cardColor,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]):
            CustomButton(
              buttonText:getTranslated('continue_shppoing', context),
              onTap: () {
                Navigator.pushAndRemoveUntil(context,
                    CupertinoPageRoute(builder: (BuildContext context) => DashBoardScreen()),
                        (Route<dynamic> route) => route is HomePage
                );

              },
            ),
          )
              : null,
          body: Column(
              children: [
                CustomAppBar(title: getTranslated('CART', context),isBackButtonExist: widget.fromCheckout? true:false),
                //Todo : here let the variable that makes the screen shows in the screen

                cart.isLoading ?
                Padding(
                  padding: const EdgeInsets.only(top: 200.0),
                  child: Center(child: getloading4(context)
                  ),
                ) :
                    sellerList.length!=0?     Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Expanded(
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
                                    await Provider.of<CartProvider>(context, listen: false).getCartDataAPI(context);
                                  }
                                },
                                child: ListView.builder(
                                  itemCount: sellerList.length,
                                  padding: EdgeInsets.all(0),
                                  itemBuilder: (context, index) {

                                    return Padding(
                                      padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            sellerGroupList[index].shopInfo.isNotEmpty ? Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(sellerGroupList[index].shopInfo,
                                                  textAlign: TextAlign.end, style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
                                                  )),
                                            ) : SizedBox(),
                                            Card(
                                              child: Container(
                                                padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_LARGE),
                                                decoration: BoxDecoration(color: Theme.of(context).highlightColor,
                                                ),
                                                child: Column(
                                                  children: [
                                                    ListView.builder(
                                                      physics: NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      padding: EdgeInsets.all(0),
                                                      itemCount: cartProductList[index].length,
                                                      itemBuilder: (context, i) {
                                                        return Column(
                                                          children: [
                                                            Divider(),
                                                            CartWidget(
                                                              cartModel: cartProductList[index][i],
                                                              index: cartProductIndexList[index][i],
                                                              fromCheckout: widget.fromCheckout,

                                                            ),
                                                            Divider()
                                                          ],
                                                        );
                                                      },
                                                    ),

                                                    //Provider.of<SplashProvider>(context,listen: false).configModel.shippingMethod =='sellerwise_shipping'?
                                                    Provider.of<SplashProvider>(context,listen: false).configModel.shippingMethod =='sellerwise_shipping' && sellerGroupList[index].shippingType =='order_wise'?
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                                                      child: InkWell(
                                                        onTap: () {
                                                          if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
                                                            showModalBottomSheet(
                                                              context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
                                                              builder: (context) => ShippingMethodBottomSheet(groupId: sellerGroupList[index].cartGroupId,sellerIndex: index, sellerId: sellerGroupList[index].id),
                                                            );
                                                          }else {
                                                            showCustomSnackBar('not_logged_in', context);
                                                          }
                                                        },


                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            border: Border.all(width: 0.5,color: Colors.grey),
                                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                              Text(getTranslated('SHIPPING_PARTNER', context), style: titilliumRegular),
                                                              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                                                Text((cart.shippingList == null || cart.shippingList[index].shippingMethodList == null || cart.chosenShippingList.length == 0 || cart.shippingList[index].shippingIndex == -1) ? ''
                                                                    : '${cart.shippingList[index].shippingMethodList[cart.shippingList[index].shippingIndex].title.toString()}',
                                                                  style: titilliumSemiBold.copyWith(color: ColorResources.getPrimary(context)),
                                                                  maxLines: 1,
                                                                  overflow: TextOverflow.ellipsis,
                                                                ),
                                                                SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                                                Icon(Icons.keyboard_arrow_down, color: Theme.of(context).primaryColor),
                                                              ]),
                                                            ]),
                                                          ),
                                                        ),
                                                      )
                                                      ,
                                                    ) :SizedBox(),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ]),
                                    );
                                  },
                                ),
                              ),
                            ),
                            // SlimyCard(),
                            //  GravityCartd(),
                            Provider.of<SplashProvider>(context,listen: false).configModel.shippingMethod !='sellerwise_shipping' && Provider.of<SplashProvider>(context,listen: false).configModel.inHouseSelectedShippingType =='order_wise'?
                            InkWell(
                              onTap: () {
                                //todo : here is the change;

                                if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
                                  showModalBottomSheet(
                                    context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
                                    builder: (context) => ShippingMethodBottomSheet(groupId: 'all_cart_group',sellerIndex: 0, sellerId: 1),
                                  );
                                }else {
                                  showCustomSnackBar('not_logged_in', context);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(width: 0.5,color: Colors.grey),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                    Text(getTranslated('SHIPPING_PARTNER', context), style: titilliumRegular),
                                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                      Text(
                                        (cart.shippingList == null ||cart.chosenShippingList.length == 0 || cart.shippingList.length==0 || cart.shippingList[0].shippingMethodList == null ||  cart.shippingList[0].shippingIndex == -1) ? ''
                                            : '${cart.shippingList[0].shippingMethodList[cart.shippingList[0].shippingIndex].title.toString()}',
                                        style: titilliumSemiBold.copyWith(color: ColorResources.getPrimary(context)),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                      Icon(Icons.keyboard_arrow_down, color: Theme.of(context).primaryColor),
                                    ]),
                                  ]),
                                ),
                              ),
                            ):SizedBox(),


                          ],
                        ),
                      ),
                    ):
                sellerList.length == 0 ? EmptyCart():

                Expanded(child: NoInternetOrDataScreen(isNoInternet: false)),
              ]),
        );
      }),
    );
  }
}



// void _checkPermission(Function callback, BuildContext context) async {
//   LocationPermission permission = await Geolocator.requestPermission();
//   if(permission == LocationPermission.denied || permission == LocationPermission.whileInUse) {
//     InkWell(
//         onTap: () async{
//           Navigator.pop(context);
//           await Geolocator.requestPermission();
//           _checkPermission(callback, context);
//         },
//         child: AlertDialog(content: MyDialog(icon: Icons.location_on_outlined, title: '', description: getTranslated('you_denied', context))));
//   }else if(permission == LocationPermission.deniedForever) {
//     InkWell(
//         onTap: () async{
//           Navigator.pop(context);
//           await Geolocator.openAppSettings();
//           _checkPermission(callback,context);
//         },
//         child: AlertDialog(content: MyDialog(icon: Icons.location_on_outlined, title: '',description: getTranslated('you_denied', context))));
//   }else {
//     callback();
//   }
// }