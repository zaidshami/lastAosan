import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/utill/math_utils.dart';
import 'package:geolocator/geolocator.dart';


import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../../data/model/response/address_model.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/location_provider.dart';
import '../../../provider/order_provider.dart';
import '../../../provider/profile_provider.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../basewidget/button/custom_button.dart';
import '../../basewidget/custom_app_bar.dart';
import '../../basewidget/my_dialog.dart';
import '../../basewidget/textfield/custom_textfield.dart';
import 'select_location_screen.dart';

class AddNewAddressScreen extends StatefulWidget {
  final bool isEnableUpdate;
  final bool fromCheckout;
  final AddressModel address;
  final bool isBilling;
  final bool isCont;
  final bool isCheckout;
  AddNewAddressScreen({this.isEnableUpdate = false, this.address, this.fromCheckout = false, this.isBilling , this.isCheckout = false,this.isCont=false,});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  List<String> cityList = [
    'صنعاء',
    'عدن',
    'الحديدة',
    'تعز',
    'إب',
    'ذمار',
    'البيضاء',
    'عمران',
    'مأرب',
    'حضرموت',
    'حجة',
    'شبوة',
    'لحج',
    'المحويت',
    'صعدة',
    'الجوف',
    'أبين',
    'ريمة',
    'الضالع',
    'المهرة',
  ];
  final TextEditingController _contactPersonNameController = TextEditingController();
  final TextEditingController _contactPersonNumberController = TextEditingController();
  final TextEditingController _cityController = TextEditingController(text: 'صنعاء');
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _zip2CodeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final FocusNode _addressNode = FocusNode();
  final FocusNode _nameNode = FocusNode();
  final FocusNode _numberNode = FocusNode();
  final FocusNode _cityNode = FocusNode();
  final FocusNode _zipNode = FocusNode();
  final FocusNode _zip2Node = FocusNode();
  GoogleMapController _controller;
  CameraPosition _cameraPosition;
  bool _updateAddress = true;
  Address _address;
  final ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    _address = Address.shipping;
    Provider.of<LocationProvider>(context, listen: false).initializeAllAddressType(context: context);
    Provider.of<LocationProvider>(context, listen: false).updateAddressStatusMessae(message: '');
    Provider.of<LocationProvider>(context, listen: false).updateErrorMessage(message: '');
    //_checkPermission(() => Provider.of<LocationProvider>(context, listen: false).getCurrentLocation(context, true, mapController: _controller),context);
    if (widget.isEnableUpdate && widget.address != null) {
      _updateAddress = false;
      Provider.of<LocationProvider>(context, listen: false).updatePosition(CameraPosition(target: LatLng(double.parse(widget.address.latitude), double.parse(widget.address.longitude))), true, widget.address.address, context);
      _contactPersonNameController.text = '${widget.address.contactPersonName}';
      _contactPersonNumberController.text = '${widget.address.phone}';
      if (widget.address.addressType == 'Home') {
        Provider.of<LocationProvider>(context, listen: false).updateAddressIndex(0, false);
      } else if (widget.address.addressType == 'Workplace') {
        Provider.of<LocationProvider>(context, listen: false).updateAddressIndex(1, false);
      } else {
        Provider.of<LocationProvider>(context, listen: false).updateAddressIndex(2, false);
      }
    }else {
      if(Provider.of<ProfileProvider>(context, listen: false).userInfoModel!=null){
        _contactPersonNameController.text = '${Provider.of<ProfileProvider>(context, listen: false).userInfoModel.fName ?? ''}'
            ' ${Provider.of<ProfileProvider>(context, listen: false).userInfoModel.lName ?? ''}';
        _contactPersonNumberController.text = Provider.of<ProfileProvider>(context, listen: false).userInfoModel.phone ?? '';
      }

    }
  }

  @override
  Widget build(BuildContext context) {

    // print('====selected shipping or billing==>${_address.toString()}');
    Provider.of<ProfileProvider>(context, listen: false).initAddressList(context);
    Provider.of<ProfileProvider>(context, listen: false).initAddressTypeList(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller:  _scrollController,
          child: Column(
            children: [
              CustomAppBar(title: widget.isEnableUpdate ? getTranslated('update_address', context) : widget.isCont ||widget.isCheckout?getTranslated('add_new_address_for_cont', context): getTranslated('add_new_address', context)),
              Consumer<LocationProvider>(
                builder: (context, locationProvider, child) {
                  return Container(
                    padding: getPadding(bottom:
                    widget.isCheckout?0 : 10),
             //       height: MediaQuery.of(context).size.height,
                    child: Column(

                      children: [
                        Scrollbar(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                            child: Center(
                              child: SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 120,
                                      width: MediaQuery.of(context).size.width,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                                        child: Stack(
                                          clipBehavior: Clip.none, children: [
                                          GoogleMap(
                                            mapType: MapType.normal,
                                            initialCameraPosition: CameraPosition(
                                              target: widget.isEnableUpdate
                                                  ? LatLng(double.parse(widget.address.latitude) ?? 0.0, double.parse(widget.address.longitude) ?? 0.0)
                                                  : LatLng(locationProvider.position.latitude ?? 0.0, locationProvider.position.longitude ?? 0.0),
                                              zoom: 17,
                                            ),
                                            onTap: (latLng) {
                                              Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => SelectLocationScreen(googleMapController: _controller)));
                                            },
                                            zoomControlsEnabled: false,
                                            compassEnabled: false,
                                            indoorViewEnabled: true,
                                            mapToolbarEnabled: false,
                                            onCameraIdle: () {
                                              if(_updateAddress) {
                                                locationProvider.updatePosition(_cameraPosition, true, null, context);
                                              }else {
                                                _updateAddress = true;
                                              }
                                            },
                                            onCameraMove: ((_position) => _cameraPosition = _position),
                                            onMapCreated: (GoogleMapController controller) {
                                              _controller = controller;
                                              if (!widget.isEnableUpdate && _controller != null) {
                                                Provider.of<LocationProvider>(context, listen: false).getCurrentLocation(context, true, mapController: _controller);
                                              }
                                            },
                                          ),
                                          locationProvider.loading ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme
                                              .of(context).primaryColor))) : SizedBox(),
                                          Container(
                                              width: MediaQuery.of(context).size.width,
                                              alignment: Alignment.center,
                                              height: MediaQuery.of(context).size.height,
                                              child: Icon(
                                                Icons.location_on,
                                                size: 40,
                                                color: Theme.of(context).primaryColor,
                                              )),
                                          Positioned(
                                            bottom: 10,
                                            right: 0,
                                            child: InkWell(
                                              onTap: () {
                                                _checkPermission(() => locationProvider.getCurrentLocation(context, true, mapController: _controller),context);
                                              },
                                              child: Container(
                                                width: 30,
                                                height: 30,
                                                margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_LARGE),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                                                  color: ColorResources.getChatIcon(context),
                                                ),
                                                child: Icon(
                                                  Icons.my_location,
                                                  color: Theme.of(context).primaryColor,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 10,
                                            right: 0,
                                            child: InkWell(
                                              onTap: () {

                                                Navigator.of(context).push(CupertinoPageRoute(
                                                    builder: (BuildContext context) => SelectLocationScreen(googleMapController: _controller)));
                                              },
                                              child: Container(
                                                width: 30,
                                                height: 30,
                                                margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_LARGE),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                                                  color: Colors.white,
                                                ),
                                                child: Icon(
                                                  Icons.fullscreen,
                                                  color: Theme.of(context).primaryColor,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                        ),
                                      ),
                                    ),
                                  ///add the location correctly
                                    Padding(
                                      padding:  EdgeInsets.only(top: 10,bottom: widget.isCheckout ? 5:15 ),
                                      child: Center(
                                          child: Text(
                                            getTranslated('add_the_location_correctly', context),
                                            style: robotoBold,
                                          )),
                                    ),


                                    /// rename with
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                                      child: Text(
                                        getTranslated('label_us', context),
                                        style:
                                       robotoBold
                                        // Theme.of(context).textTheme.headline3.copyWith(color: ColorResources.getHint(context), fontSize: Dimensions.FONT_SIZE_LARGE),
                                      ),
                                    ),
                                    Container(
                                      height:widget.isCheckout?42: 50,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        physics: BouncingScrollPhysics(),
                                        //Todo : make the horizntal scrollable
                                        itemCount: locationProvider.getAllAddressType.length-1,
                                        itemBuilder: (context, index) => InkWell(
                                          onTap: () {
                                            locationProvider.updateAddressIndex(index, true);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL, horizontal: Dimensions.PADDING_SIZE_LARGE),
                                            margin: EdgeInsets.only(right: 17),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(
                                                  Dimensions.PADDING_SIZE_SMALL,
                                                ),
                                                border: Border.all(
                                                    color: locationProvider.selectAddressIndex == index
                                                        ? Theme.of(context).primaryColor : ColorResources.getHint(context)),
                                                color: locationProvider.selectAddressIndex == index
                                                    ? Theme.of(context).primaryColor : ColorResources.getChatIcon(context)),
                                            child: Text(
                                              getTranslated(locationProvider.getAllAddressType[index].toLowerCase(), context),
                                              style: robotoBold.copyWith(
                                                  color: locationProvider.selectAddressIndex == index
                                                      ? Theme.of(context).cardColor : ColorResources.getHint(context)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    ///the type of the location
                                    Container(
                                      padding: EdgeInsets.only(top: widget.isCheckout?5:10),
                                      height: widget.isCheckout?40 : 50,
                                      child: Row(children: <Widget>[
                                        Row(
                                          children: [
                                            Radio<Address>(

                                              activeColor: Colors.red,
                                              value: Address.shipping,
                                              groupValue: _address,
                                              onChanged: (Address value) {
                                                setState(() {
                                                  _address = value;
                                                });
                                              },
                                            ),
                                            Text(getTranslated('shipping_address', context),style :robotoBold),

                                          ],
                                      ),
                                      //   Row(
                                      //     children: [
                                      //       Radio<Address>(
                                      //         activeColor:Colors.red ,
                                      //         value: Address.billing,
                                      //         groupValue: _address,
                                      //         onChanged: (Address value) {
                                      //           setState(() {
                                      //             _address = value;
                                      //           });
                                      //         },
                                      //       ),
                                      //       Text(getTranslated('billing_address', context),style :robotoBold,),
                                      //
                                      //
                                      //     ],
                                      // ),
                                  ],
                                ),
                                    ),

                                    // nearest place to the delivery place
                                    /// the example of the validating
                                    SingleChildScrollView(
                                      child: Form(
                                        key: _formKey1,
                                        child: Column(
                                          children: [

                                             SizedBox(
                                              height:  widget.isCheckout?5 :0,
                                            ),

                                            /// for Contact Person Number
                                            CustomTextField(
                                             // isCheckOut: widget.isCheckout,
                                              isAdressScreen: true,
                                              isValidator: true,
                                              // validatorMessage: getTranslated('enter_contact_person_name_message', context),

                                              labelText: getTranslated('enter_contact_person_name', context),
                                              validatorMessage: 'يرجى ادخال اسم المستخدم / العميل',
                                              textInputType: TextInputType.name,
                                              controller: _contactPersonNameController,
                                              focusNode: _nameNode,
                                              nextNode: _numberNode,
                                              textInputAction: TextInputAction.next,
                                              capitalization: TextCapitalization.words,
                                            ),
                                            SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT_ADDRESS),

                                            CustomTextField(
                                              isAdressScreen: true,
                                              isValidator: true,
                                              // validatorMessage: getTranslated('enter_contact_person_number_message', context),
                                              validatorMessage: 'يرجى ادخال رقم الهاتف اذا كان هناك مشكلة في التوصيل',
                                              labelText: getTranslated('enter_contact_person_number', context),
                                              textInputType: TextInputType.phone,
                                              textInputAction: TextInputAction.done,
                                              focusNode: _numberNode,
                                              controller: _contactPersonNumberController,
                                              nextNode: _addressNode,
                                            ),
                                            // Padding(
                                            //   padding: const EdgeInsets.only(top: 5,),
                                            //   child: Text(
                                            //     getTranslated('delivery_address', context),
                                            //     style: Theme.of(context).textTheme.headline3.copyWith(color: ColorResources.getHint(context), fontSize: Dimensions.FONT_SIZE_LARGE),
                                            //   ),
                                            // ),
                                            // for Address Field
                                            SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT_ADDRESS),

                                            /// City
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    // Expanded(
                                                    //   flex:7,
                                                    //   child: CustomTextField(
                                                    //     isAdressScreen: true,
                                                    //     validatorMessage: 'يرجى ادخال اسم المدينة',
                                                    //     hintText: _cityController.text,
                                                    //     isValidator: true,
                                                    //     //
                                                    //     // isValidator:true,
                                                    //     // validatorMessage: 'please',
                                                    //
                                                    //     //  onTap:_saveForm ,
                                                    //     readonly: false,
                                                    //
                                                    //
                                                    //     labelText:
                                                    //     getTranslated('city', context),
                                                    //     textInputType: TextInputType.streetAddress,
                                                    //     textInputAction: TextInputAction.next,
                                                    //     focusNode: _cityNode,
                                                    //     nextNode: _zipNode,
                                                    //     controller: _cityController,
                                                    //   ),
                                                    // ),
                                                    Expanded(

                                                      child:



                                          Consumer<LocationProvider>(
                                                        builder: (context, locationProvider, child) => CustomTextField(
                                                          prefixIcon: Padding(
                                                            padding:getPadding(left: 30),
                                                            child: Icon(Icons.keyboard_arrow_down_sharp),
                                                          ),
                                                          isAdressScreen: true,
                                                          validatorMessage: 'يرجى ادخال اسم المدينة',
                                                          hintText: _cityController.text,
                                                          isValidator: true,
                                                          readonly: true,
                                                          labelText: getTranslated('city', context),
                                                          textInputType: TextInputType.streetAddress,
                                                          textInputAction: TextInputAction.next,
                                                          focusNode: _cityNode,
                                                          nextNode: _zipNode,
                                                          controller: _cityController,

                                                          onTap: () {
                                                            showDialog(
                                                              context: context,
                                                              builder: (BuildContext context) {
                                                                return AlertDialog(
                                                                  title: Center(child: Text(getTranslated('choose_city', context,),style: robotoBold.copyWith(fontSize: 20),)),
                                                                  content:  SizedBox(
                                                                    height: 200,
                                                                    child: Stack(
                                                                      children: [
                                                                        SingleChildScrollView(
                                                                          child: Column(

                                                                            children: cityList.map((city) {
                                                                              return Column(
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsets.symmetric(vertical: 2.0), // Adjust the vertical padding here
                                                                                    child: CustomListTile(
                                                                                      title: city,
                                                                                      onTap: () {
                                                                                        _cityController.text = city;
                                                                                        Navigator.of(context).pop();
                                                                                      },
                                                                                    ),
                                                                                  ),


                                                                                ],
                                                                              );
                                                                            }).toList(),
                                                                          ),
                                                                        ),
                                                                        Align(
                                                                          alignment: Alignment.bottomCenter,
                                                                          child: Icon(
                                                                            Icons.keyboard_arrow_down,
                                                                            size: 36,
                                                                            color: Colors.grey,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      ),

                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT_ADDRESS),

                                            //Todo ; add the validaion on tap or whenever is empty
                                            CustomTextField(
                                              isAdressScreen: true,
                                              // onTap: (){
                                              //   print(locationProvider.locationController.text);
                                              // },
                                              isValidator: true,
                                              // validatorMessage: getTranslated('delivery_address_message', context) ,
                                              validatorMessage: 'يرجى ادخال عنوان التوصيل',

                                              labelText: getTranslated('delivery_address', context)+': '+ getTranslated('address_line_02', context),


                                              textInputType: TextInputType.streetAddress,
                                              textInputAction: TextInputAction.next,
                                              focusNode: _addressNode,
                                              nextNode: _zip2Node,
                                              controller: locationProvider.locationController,
                                            ),

                                            // Text(
                                            //   getTranslated('city', context),
                                            //   style: robotoRegular.copyWith(color: ColorResources.getHint(context)),
                                            // ),
                                            SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT_ADDRESS),

                                            // Text(
                                            //   getTranslated('zip', context),
                                            //   style: robotoRegular.copyWith(color: ColorResources.getHint(context)),
                                            // ),
                                            // SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                                            ///zip2 changed to neearest
                                            CustomTextField(

                                              isAdressScreen: true,
                                              validatorMessage: 'يرجى ادخال اقرب معلم بارز لمكان التوصيل',
                                              isValidator: true,
                                              labelText:'ادخل اقرب معلم لمكان التوصيل',
                                              textInputType: TextInputType.text,
                                              textInputAction: TextInputAction.next,
                                              focusNode: _zip2Node,
                                              nextNode: _zipNode,
                                              controller: _zip2CodeController,
                                            ),

                                            SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT_ADDRESS),
                                            /// zip the alternative ph
                                            CustomTextField(
                                              isAdressScreen: false,
                                              isValidator: false,
                                              //validatorMessage: 'يرجى ادخال رقم هاتف احتياطhي في حال عدم توفر الهاتف الاساسي',
                                              labelText: getTranslated('zip', context),
                                              textInputType: TextInputType.number,
                                              textInputAction: TextInputAction.next,
                                              focusNode: _zipNode,
                                              // nextNode: _nameNode,
                                              controller: _zipCodeController,
                                            ),
                                         //   SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT_ADDRESS),
                                            locationProvider.addressStatusMessage != null ? Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                locationProvider.addressStatusMessage.length > 0 ? CircleAvatar(backgroundColor: Colors.green, radius: 5) : SizedBox.shrink(),
                                                SizedBox(width: 8),
                                                Expanded(
                                                  child: Text(locationProvider.addressStatusMessage ?? "",
                                                    style: Theme.of(context).textTheme.headline2.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: Colors.green, height: 1),
                                                  ),
                                                )
                                              ],
                                            ) : Row(crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                locationProvider.errorMessage.length > 0
                                                    ? CircleAvatar(backgroundColor: Theme.of(context).primaryColor, radius: 5) : SizedBox.shrink(),
                                                SizedBox(width: 8),
                                                Expanded(
                                                  child: Text(locationProvider.errorMessage ?? "",
                                                    style: Theme.of(context).textTheme.headline2.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: Theme.of(context).primaryColor, height: 1),
                                                  ),
                                                )
                                              ],
                                            ),

                                            Container(
                                              height: 50.0,
                                              margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                                              child: !locationProvider.isLoading ?
                                              CustomButton(

                                                buttonText: widget.isEnableUpdate ? getTranslated('update_address', context) : widget.isCheckout?getTranslated('save_location1', context): getTranslated('save_location', context),
                                                onTap:


                                                locationProvider.loading ? null : () async{
                                                  _saveForm();
                                                  locationProvider.loading = true;
                                                  AddressModel addressModel = AddressModel(
                                                    zip2: _zip2CodeController.text,
                                                    addressType: locationProvider.getAllAddressType[locationProvider.selectAddressIndex],
                                                    contactPersonName: _contactPersonNameController.text ?? '',
                                                    phone: _contactPersonNumberController.text ?? '',
                                                    city: _cityController.text ?? '',
                                                    zip: _zipCodeController.text?? '',
                                                    isBilling: _address == Address.billing ? 1:0,
                                                    address: locationProvider.locationController.text ?? '',
                                                    latitude: widget.isEnableUpdate ? locationProvider.position.latitude.toString() ?? widget.address.latitude : locationProvider.position.latitude.toString() ?? '',
                                                    longitude: widget.isEnableUpdate ? locationProvider.position.longitude.toString() ?? widget.address.longitude
                                                        : locationProvider.position.longitude.toString() ?? '',
                                                  );
                                                  if (widget.isEnableUpdate) {

                                                    addressModel.id = widget.address.id;
                                                    addressModel.id = widget.address.id;
                                                    // addressModel.method = 'put';
                                                    locationProvider.updateAddress(context, addressModel: addressModel, addressId: addressModel.id).then((value) {});
                                                  }
                                                  else {
                                                    locationProvider.addAddress(addressModel, context).then((value) {
                                                      if (value.isSuccess) {
                                                        Provider.of<ProfileProvider>(context, listen: false).initAddressList(context);
                                                        Navigator.pop(context);
                                                        if (widget.isCheckout) {
                                                          Provider.of<ProfileProvider>(context, listen: false).initAddressList(context);

                                                          Provider.of<OrderProvider>(context, listen: false).setAddressIndex(Provider.of<ProfileProvider>(context, listen: false).addressList.length );
                                                          Provider.of<ProfileProvider>(context, listen: false).isExpanded = false ;
                                                        } else {
                                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.message), duration: Duration(milliseconds: 600), backgroundColor: Colors.green));
                                                        }
                                                      } else {
                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.message), duration: Duration(milliseconds: 600), backgroundColor: Colors.red));
                                                      }
                                                    });
                                                  }
                                                  // if (widget.isCheckout) {
                                                  //   Provider.of<ProfilePro     Provider.of<ProfileProvider>(context, listen: false).isExpanded = false ;vider>(context, listen: false).initAddressList(context);
                                                  //
                                                  //   Provider.of<OrderProvider>(context, listen: false).setAddressIndex(Provider.of<ProfileProvider>(context, listen: false).addressList.length );
                                                  //
                                                  //   // int index = Provider.of<ProfileProvider>(context, listen: false).addressList.length  ;
                                                  //   // Provider.of<OrderProvider>(context, listen: false).setAddressIndex(index);
                                                  //   Provider.of<ProfileProvider>(context, listen: false).isExpanded = false ;
                                                  //
                                                  // }

                                                  },
                                              )
                                                  : Center(
                                                  child: CircularProgressIndicator(
                                                    valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                                                  )),
                                            )

                                          ],
                                        ),
                                      ),
                                    ),



                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
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
enum Address { shipping, billing }
final GlobalKey<FormState> _formKey1 = GlobalKey();
void _saveForm() {
  final bool isValid = _formKey1.currentState.validate();
  if (isValid) {
    if (kDebugMode) {
      print('Got a valid input');
    }
    // And do something here
  }
}


//
// class YourWidget extends StatelessWidget {
//   final TextEditingController _cityController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     List<String> cityList = [
//       'Sana\'a',
//       'Aden',
//       'Al-hodidah',
//       'Dhamar',
//       'ta\'ez',
//       'Ibb',
//     ];
//
//     return Consumer<LocationProvider>(
//       builder: (context, locationProvider, child) =>
//  DropdownButton<String>(
//         value: locationProvider.selectedCity,
//         hint: Text(getTranslated('city', context)),
//         onChanged: (String newValue) {
//           locationProvider.setSelectedCity(newValue);
//           _cityController.text = newValue;
//         },
//         items: cityList.map<DropdownMenuItem<String>>((String value) {
//           return DropdownMenuItem<String>(
//             value: value,
//             child: Text(value),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }


class CustomListTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const CustomListTile({
    @required this.title,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(

        width: double.maxFinite,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Center(
          child: Text(
            title,
            style: robotoBold.copyWith(fontSize: 16)
          ),
        ),
      ),
    );
  }
}
