
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../localization/language_constrants.dart';
import '../../../../provider/location_provider.dart';
import '../../../../provider/order_provider.dart';
import '../../../../provider/profile_provider.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../../utill/math_utils.dart';
import '../../../basewidget/my_dialog.dart';
import '../../../basewidget/no_internet_screen.dart';
import '../add_new_address_screen.dart';
import 'address_list_screen.dart';
import 'adress_widget.dart';


class NewSimpleExpandableAddressList extends StatefulWidget {

  @override
  State<NewSimpleExpandableAddressList> createState() => _NewSimpleExpandableAddressListState();
}
GoogleMapController _controller;


class _NewSimpleExpandableAddressListState extends State<NewSimpleExpandableAddressList> {
  final ScrollController _scrollController = ScrollController();
  @override

  @override
  Widget build(BuildContext context) {

    return Center(
      child:    Column(
        children: [
          Container(


            padding:getPadding(top: 10),
            child: Consumer<ProfileProvider>(
              builder: (context, profile, child) =>

                  ExpansionPanelList(


                    dividerColor: Colors.black,
                    elevation: 0,


                    expansionCallback: (int index, bool isExpanded) {

                      setState(() {
                        profile.isExpanded = !isExpanded;
                      });
                      try {
                        _checkPermission(() =>
                            Provider.of<
                                LocationProvider>(
                                context, listen: false)
                                .getCurrentLocation(
                                context, true,
                                mapController: _controller),
                            context);
                      }catch(e){}
                    },
                    children: [

                      ExpansionPanel(

                        canTapOnHeader: true ,
                        backgroundColor: Colors.white,
                        isExpanded: profile.isExpanded,
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return Padding(
                            padding: getPadding(right: 10),
                            child: Container(

                              padding: getPadding(top: 8,bottom: 8 ,left: 20 ,right: 20),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${getTranslated('shipping_address', context)}',
                                    style: titilliumRegular.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Image.asset(
                                    Images.location_city,
                                    color: Colors.white,
                                    height: 30,
                                    width: 30,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        body: Column(
                          children: [

                            Consumer<ProfileProvider>(
                              builder: (context, profile, child) {
                                return SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    children: [
                                      Center(child: Text(getTranslated('ADD_ADDRESS', context),style: robotoBold,)),
                                      // FloatingActionButton(
                                      //
                                      //   onPressed: (){
                                      //
                                      //     showModalBottomSheet(
                                      //         context:
                                      //         context,
                                      //         isScrollControlled:
                                      //         true,
                                      //         backgroundColor:
                                      //         Colors
                                      //             .transparent,
                                      //         builder:
                                      //             (con) =>
                                      //             Container(
                                      //                 height:  MediaQuery.of(context).size.height*0.93 ,
                                      //                 width:   MediaQuery.of(context).size.width,
                                      //                 child: AddNewAddressScreen(isBilling: false, isCheckout: true,)));
                                      //   },
                                      //   //  Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => AddNewAddressScreen(isBilling: false))),
                                      //   child: Icon(Icons.add, color: Theme.of(context).highlightColor),
                                      //   backgroundColor: ColorResources.getPrimary(context),
                                      // ),
                                      Container(

                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: ColorResources.getPrimary(context),
                                        ),
                                        child: IconButton(

                                          onPressed: () {

                                             //todo: sssss

                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              backgroundColor: Colors.transparent,
                                              builder: (con) => Container(
                                                height: MediaQuery.of(context).size.height * 0.93,
                                                width: MediaQuery.of(context).size.width,
                                                child: AddNewAddressScreen(
                                                  isBilling: false,
                                                  isCheckout: true,
                                                ),
                                              ),
                                            );
                                          },

                                          icon: Icon(Icons.add, color: Colors.white),
                                        ),
                                      ),

                                      profile.addressList != null ? profile.addressList.length != 0 ?
                                      Container(
                                        height: MediaQuery.of(context).size.height/4,
                                        child: ListView.builder(


                                          physics: BouncingScrollPhysics(parent: FixedExtentScrollPhysics()),
                                          itemCount: profile.addressList.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return SingleChildScrollView(
                                              controller: _scrollController,
                                              scrollDirection: Axis.vertical,
                                              child: InkWell(
                                                onTap: () {
                                                  Provider.of<OrderProvider>(context, listen: false).setAddressIndex(index);
                                                  profile.isExpanded = false ;

                                                  //  Provider.of<ProfileProvider>(context, listen: false).isExpanded  = isExpanded ;

                                                  // Navigator.pop(context);
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                                                  child: Container(
                                                    margin: EdgeInsets.only(top: 5),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: ColorResources.getIconBg(context),
                                                      border: index == Provider.of<OrderProvider>(context).addressIndex ? Border.all(width: 2, color: Theme.of(context).primaryColor) : null,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Expanded(child: AddressWidget(
                                                          isCheckout:true,

                                                          addressModel: profile.addressList[index],
                                                          index: index,
                                                        )),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )  :
                                      Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_LARGE),
                                          child: NoAdressDataScreen()
                                      ) :
                                      Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))),

                                    ],
                                  ),
                                );
                              },
                            )
                          ],
                        ),

                      ),



                    ],
                  ),
            ),
          ),
          Provider.of<OrderProvider>(context,listen: false).addressIndex == null||    Provider.of<ProfileProvider>(context,listen: false).addressList.isEmpty?SizedBox():


          Padding(
            padding: getPadding(right: 20 , left: 20 , bottom: 20),
            child: Consumer<ProfileProvider>(
              builder: (context, value, child) =>
                  Consumer<OrderProvider>(
                      builder: (context, shipping,_) {
                        // Provider.of<ProfileProvider>(context, listen: false).initAddressList(context);
                        return Container(
                          decoration: BoxDecoration(
                            // border:Border.all(width: 2)
                          ),
                          //padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                InkWell(

                                  child: Card(
                                    child: Container(
                                      // padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                                      decoration: BoxDecoration(

                                        borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_DEFAULT),
                                        color: Theme.of(context).cardColor,
                                      ),
                                      child: Column(crossAxisAlignment:CrossAxisAlignment.start,
                                        children: [



                                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Divider(
                                                color: Colors.black,
                                              ),
                                              Container(

                                                child: Center(
                                                  child: Text(
                                                    Provider.of<OrderProvider>(context,listen: false).addressIndex == null ?
                                                    '${getTranslated('PlEASE_SELECT_ADDRESS', context)}'
                                                        : getTranslated("${Provider.of<ProfileProvider>(context, listen: false).addressList[
                                                    Provider.of<OrderProvider>(context, listen: false).addressIndex].addressType.toLowerCase()}", context)
                                                    ,   style: titilliumBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),
                                                    maxLines: 3, overflow: TextOverflow.fade,
                                                  ),
                                                ),
                                              ),
                                              Divider(color: Colors.black,),
                                              Container(
                                                decoration: BoxDecoration(
                                                  border:  Border.all(width: 2, color: Theme.of(context).primaryColor) ,
                                                ),
                                                child: ListTile(
                                                  leading: Image.asset(Images.location_city,color: ColorResources.getSellerTxt(context), height: 30, width: 30,),
                                                  title :Text(
                                                    Provider.of<OrderProvider>(context,listen: false).addressIndex == null ?
                                                    getTranslated('PlEASE_SELECT_ADDRESS', context)
                                                        : Provider.of<ProfileProvider>(context, listen: false).addressList[
                                                    shipping.addressIndex].address,
                                                    style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
                                                    maxLines: 3, overflow: TextOverflow.fade,
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // onTap: ()=>Navigator.of(context).push(
                                  //     CupertinoPageRoute(builder: (BuildContext context) => SavedAddressListScreen())),
                                ),

                                SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                                // _billingAddress?
                                // Card(
                                //   child: Container(
                                //     padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                                //     decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_DEFAULT),
                                //       color: Theme.of(context).cardColor,
                                //     ),
                                //     child: Column(crossAxisAlignment:CrossAxisAlignment.start,
                                //       children: [
                                //         Row(mainAxisAlignment:MainAxisAlignment.start, crossAxisAlignment:CrossAxisAlignment.start,
                                //           children: [
                                //             Expanded(child: Text('${getTranslated('billing_address', context)}',
                                //                 style: titilliumRegular.copyWith(fontWeight: FontWeight.w600))),
                                //
                                //
                                //             InkWell(
                                //               onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                                //                   builder: (BuildContext context) => SavedBillingAddressListScreen())),
                                //               child: Image.asset(Images.address, scale: 3),
                                //             ),
                                //           ],
                                //         ),
                                //         SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                                //         Column(crossAxisAlignment: CrossAxisAlignment.start,
                                //           children: [
                                //             Container(
                                //               child: Text(
                                //                 Provider.of<OrderProvider>(context).billingAddressIndex == null ? '${getTranslated('address_type', context)}'
                                //                     : Provider.of<ProfileProvider>(context, listen: false).billingAddressList[
                                //                 Provider.of<OrderProvider>(context, listen: false).billingAddressIndex].addressType,
                                //                 style: titilliumBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),
                                //                 maxLines: 1, overflow: TextOverflow.fade,
                                //               ),
                                //             ),
                                //             Divider(),
                                //             Container(
                                //               child: Text(
                                //                 Provider.of<OrderProvider>(context).billingAddressIndex == null ? getTranslated('add_your_address', context)
                                //                     : Provider.of<ProfileProvider>(context, listen: false).billingAddressList[
                                //                       shipping.billingAddressIndex].address,
                                //                 style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
                                //                 maxLines: 3, overflow: TextOverflow.fade,
                                //               ),
                                //             ),
                                //           ],
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ):SizedBox(),
                              ]),
                        );
                      }
                  ),
            ),
          ),

        ],

      ),
    );
  }
}
void _checkPermission(Function callback, BuildContext context) async {
  LocationPermission permission = await Geolocator.requestPermission();
  if(permission == LocationPermission.denied || permission == LocationPermission.whileInUse) {
    InkWell(
        onTap: () async{
          Navigator.pop(context);
          await Geolocator.requestPermission();
          _checkPermission(callback, context);
        },
        child: AlertDialog(content: MyDialog(icon: Icons.location_on_outlined, title: '', description: getTranslated('you_denied', context))));
  }else if(permission == LocationPermission.deniedForever) {
    InkWell(
        onTap: () async{
          Navigator.pop(context);
          await Geolocator.openAppSettings();
          _checkPermission(callback,context);
        },
        child: AlertDialog(content: MyDialog(icon: Icons.location_on_outlined, title: '',description: getTranslated('you_denied', context))));
  }else {
    callback();
  }
}
/// to change the color of the expansionlist
//ExpansionPanelList(
//   expansionCallback: (int index, bool isExpanded) {
//     setState(() {
//       _data[index].isExpanded = !isExpanded;
//     });
//   },
//   children: _data.map<ExpansionPanel>((Item item) {
//     return ExpansionPanel(
//       headerBuilder: (BuildContext context, bool isExpanded) {
//         // Your header builder code...
//       },
//       body: ListTile(
//         // Your body code...
//       ),
//       isExpanded: item.isExpanded,
//     );
//   }).toList(),
//   expansionCallback: (int index, bool isExpanded) {
//     setState(() {
//       _data[index].isExpanded = !isExpanded;
//     });
//   },
//   elevation: 1,
//   iconColor: Colors.red, // Change this to your desired color
// ),