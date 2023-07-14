import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../../data/model/response/address_model.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/location_provider.dart';
import '../../../provider/profile_provider.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../basewidget/my_dialog.dart';
import '../../basewidget/no_internet_screen.dart';
import '../../basewidget/not_loggedin_widget.dart';
import 'add_new_address_screen.dart';
import 'widget/adress_widget.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class AddressScreen extends StatefulWidget {

  final AddressModel addressModel;
  AddressScreen({this.addressModel});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  bool _isLoggedIn;
  GoogleMapController _controller;

  @override
  void initState() {

    super.initState();

    _isLoggedIn = Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    if(_isLoggedIn) {
      Provider.of<LocationProvider>(context, listen: false).initAddressList(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: AppConstants.textScaleFactior),
      child: Scaffold(
        appBar: AppBar(
          title: Text(getTranslated('address', context)),
          backgroundColor: Theme.of(context).primaryColor,
        ),
          body: _isLoggedIn ? Consumer<ProfileProvider>(
            builder: (context, locationProvider, child) {
              return Column( mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getTranslated('saved_address', context),
                            style: robotoRegular.copyWith(color: ColorResources.getTextTitle(context)),
                          ),
                          InkWell(
                            onTap: () {
                              try {
                                _checkPermission(() => Provider.of<LocationProvider>(context, listen: false).getCurrentLocation(context, true, mapController: _controller),context);

                              }catch(e){

                              }
//                             AndroidMapRenderer mapRenderer = AndroidMapRenderer.platformDefault;
// ···
//                             final GoogleMapsFlutterPlatform mapsImplementation =
//                                 GoogleMapsFlutterPlatform.instance;
//                             if (mapsImplementation is GoogleMapsFlutterAndroid) {
//                               WidgetsFlutterBinding.ensureInitialized();
//                               mapRenderer = await mapsImplementation
//                                   .initializeWithRenderer(AndroidMapRenderer.latest);
//                             }
                              Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => AddNewAddressScreen()));
                            },
                            child: Row(
                              children: [
                                Icon(Icons.add, color: ColorResources.getTextTitle(context)),
                                Text(
                                  getTranslated('add_new', context),
                                  style: robotoRegular.copyWith(color: ColorResources.getTextTitle(context)),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  locationProvider.addressList != null ? locationProvider.addressList.length > 0 ?

                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await Provider.of<ProfileProvider>(context, listen: false).initAddressList(context);
                      },
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Scrollbar(
                        child: Center(
                          child: SizedBox(
                            child: ListView.builder(
                              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                              itemCount: locationProvider.addressList.length,
                              itemBuilder: (context, index) => AddressWidget(
                                addressModel: locationProvider.addressList[index],
                                index: index,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                      : NoInternetOrDataScreen(isNoInternet: false)
                      : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))),
                ],
              );
            },
          ) : NotLoggedInWidget(),
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
  }
  else
    if(permission == LocationPermission.deniedForever) {
    InkWell(
        onTap: () async{
          Navigator.pop(context);
          await Geolocator.openAppSettings();
          _checkPermission(callback,context);
        },
        child: AlertDialog(content: MyDialog(icon: Icons.location_on_outlined, title: '',description: getTranslated('you_denied', context))));
  }
    else {
    callback();
  }
}