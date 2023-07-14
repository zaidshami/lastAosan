import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/utill/math_utils.dart';
import 'package:provider/provider.dart';

import '../../../localization/language_constrants.dart';
import '../../../provider/order_provider.dart';
import '../../../provider/profile_provider.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../basewidget/no_internet_screen.dart';
import 'add_new_address_screen.dart';
import 'widget/address_list_screen.dart';
class SavedAddressListScreen extends StatelessWidget {
  const SavedAddressListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => AddNewAddressScreen(isBilling: false))),
        child: Icon(Icons.add, color: Theme.of(context).highlightColor),
        backgroundColor: ColorResources.getPrimary(context),
      ),
      appBar: AppBar(backgroundColor:Theme.of(context).primaryColor , title: Text(getTranslated('SHIPPING_ADDRESS_LIST', context)),),
      body: SafeArea(
          child: Consumer<ProfileProvider>(
        builder: (context, profile, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                profile.addressList != null ? profile.addressList.length != 0 ?
                SizedBox(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: profile.addressList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {Provider.of<OrderProvider>(context, listen: false).setAddressIndex(index);
                        Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                          child: Container(
                            margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorResources.getIconBg(context),
                              border: index == Provider.of<OrderProvider>(context).addressIndex ? Border.all(width: 2, color: Theme.of(context).primaryColor) : null,
                            ),
                            child: AddressListPage(address: profile.addressList[index]),
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
      )),
    );
  }
}


class SavedLocationExpanded extends StatefulWidget {
  @override
  _SavedLocationExpandedState createState() => _SavedLocationExpandedState();
}

class _SavedLocationExpandedState extends State<SavedLocationExpanded> {


  bool isExpanded = true;


  @override
  Widget build(BuildContext context) {

    return  Expanded(
      child: ListView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            //  Provider.of<ProfileProvider>(context, listen: false).isExpanded  = isExpanded ;
            },
            child: AnimatedContainer(
              margin: EdgeInsets.symmetric(
                horizontal: isExpanded ? 5 : 0,

              ),
              padding: getPadding(top: 15,right: 20,left: 20),
              height: isExpanded ? 60 : 330,
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(milliseconds: 1200),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color:Colors.grey,
                    blurRadius: 20,
                    offset: Offset(5, 10),
                  ),
                ],
                color: isExpanded?Colors.black:Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(isExpanded ? 20 : 0),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${getTranslated('shipping_address', context)}',
                         style: titilliumRegular.copyWith(fontSize: 20,fontWeight: FontWeight.w600,color: isExpanded?Colors.white:Colors.black),textAlign: TextAlign.center,
                      ),
                      Image.asset(
                        Images.location_city,

                        color: isExpanded?Colors.white:Colors.black, height: 30, width: 30,
                      ),
                      Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up,
                        color: isExpanded?Colors.white:Colors.black,
                        size: 35,
                      ),
                    ],
                  ),
                  isExpanded ? SizedBox() : SizedBox(height: 20),
                  AnimatedCrossFade(
                    firstChild:SizedBox(),
                    secondChild:Consumer<ProfileProvider>(
                      builder: (context, profile, child) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              profile.addressList != null ? profile.addressList.length != 0 ?
                              SizedBox(
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: profile.addressList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {Provider.of<OrderProvider>(context, listen: false).setAddressIndex(index);
                                     // Navigator.pop(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                                        child: Container(
                                          margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: ColorResources.getIconBg(context),
                                            border: index == Provider.of<OrderProvider>(context).addressIndex ? Border.all(width: 2, color: Theme.of(context).primaryColor) : null,
                                          ),
                                          child: AddressListPage(address: profile.addressList[index]),
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
                    ),
                    crossFadeState: isExpanded
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: Duration(milliseconds: 1200),
                    reverseDuration: Duration.zero,
                    sizeCurve: Curves.fastLinearToSlowEaseIn,
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}