import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:url_launcher/url_launcher.dart';
import '../../../../data/model/response/address_model.dart';
import '../../../../data/model/response/base/api_response.dart';
import '../../../../data/model/response/base/error_response.dart';
import '../../../../data/model/response/response_model.dart';
import '../../../../data/model/response/user_info_model.dart';
import '../../../../data/repository/profile_repo.dart';
import '../../../../helper/api_checker.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'order_provider.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepo profileRepo;
  ProfileProvider({@required this.profileRepo});

  List<String> _addressTypeList = [];
  String _addressType = '';
  UserInfoModel _userInfoModel;
  bool _isLoading = false;
  List<AddressModel> _addressList =[];
  List<AddressModel> _billingAddressList = [];
  List<AddressModel> _shippingAddressList = [];
  bool _hasData;
  bool _isHomeAddress = true;
  bool _isExpanded =false ;

  String _addAddressErrorText;
  String userMedium;

  List<String> get addressTypeList => _addressTypeList;
  String get addressType => _addressType;
  UserInfoModel get userInfoModel => _userInfoModel;
  bool get isLoading => _isLoading;
  List<AddressModel> get addressList => _addressList;
  List<AddressModel> get billingAddressList => _billingAddressList;
  List<AddressModel> get shippingAddressList => _shippingAddressList;
  bool get hasData => _hasData;
  bool get isHomeAddress => _isHomeAddress;
  bool get isExpanded => _isExpanded;
  ValueNotifier<bool> expandNotifier = ValueNotifier<bool>(false);
  String get addAddressErrorText => _addAddressErrorText;



  void setAddAddressErrorText(String errorText) {
    _addAddressErrorText = errorText;
    // notifyListeners();
  }

  void openWhatsapp(
      {@required BuildContext context,
        @required String text,
        @required String number})
  async {
    var whatsapp = number; //+92xx enter like this
    var whatsappURlAndroid =
        "whatsapp://send?phone=" + '+967779922883' + "&text=$text";
    var whatsappURLIos = "https://wa.me/$whatsapp?text=${Uri.tryParse(text)}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
        await launchUrl(Uri.parse(
          whatsappURLIos,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Whatsapp not installed")));
      }
    } else {
      // android , web
      if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
        await launchUrl(Uri.parse(whatsappURlAndroid));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Whatsapp not installed")));
      }
    }
  }

  void openFacebook () async{
    String fbProtocolUrl;
    if (Platform.isIOS) {
      fbProtocolUrl = 'fb://profile/107840835521290';
    } else {
      fbProtocolUrl = 'fb://page/107840835521290';
    }

    String fallbackUrl = 'https://www.facebook.com/aosan.shop';

    try {
      bool launched = await launch(fbProtocolUrl, forceSafariVC: false);

      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false);
    }
  }
void openDailPad()async{
  Uri phoneno = Uri.parse('tel:+967779922883');
  if (await launchUrl(phoneno)) {
    //dialer opened
  }else{
    //dailer is not opened
  }
}


  void openInstagram(BuildContext context, String username) async {
    String instagramUrl = 'https://www.instagram.com/$username';

    if (await canLaunch(instagramUrl)) {
      await launch(instagramUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Instagram not installed")));
    }
  }
  void updateAddressCondition(bool value) {
    _isHomeAddress = value;
    notifyListeners();
  }
  set isExpanded(bool value) {
    _isExpanded = value;
    expandNotifier.value = value;
    notifyListeners();
  }
  void updateExpandableAddress() {
    _isExpanded =! _isExpanded ;

    notifyListeners();

  }

  bool _checkHomeAddress=false;
  bool get checkHomeAddress=>_checkHomeAddress;

  bool _checkOfficeAddress=false;
  bool get checkOfficeAddress=>_checkOfficeAddress;

  void setHomeAddress() {
    _checkHomeAddress = true;
    _checkOfficeAddress = false;
    notifyListeners();
  }

  void setOfficeAddress() {
    _checkHomeAddress = false;
    _checkOfficeAddress = true;
    notifyListeners();
  }


  updateCountryCode(String value) {
    _addressType = value;
    notifyListeners();
  }

  Future<void> initAddressList(BuildContext context) async {
    ApiResponse apiResponse = await profileRepo.getAllAddress();
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _addressList = [];
      _billingAddressList =[];
      _shippingAddressList =[];
      apiResponse.response.data.forEach((address) {
        AddressModel addressModel = AddressModel.fromJson(address);
        if(addressModel.isBilling == 1){
          _billingAddressList.add(addressModel);
        }else if(addressModel.isBilling == 0){
          _addressList.add(addressModel);
        }
          _shippingAddressList.add(addressModel);


      });
     // apiResponse.response.data.forEach((address) => _addressList.add(AddressModel.fromJson(address)));
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  void removeAddressById(int id, int index, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await profileRepo.removeAddressByID(id);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _addressList.removeAt(index);
      Map map = apiResponse.response.data;
      String message = map["message"];
      initAddressList(context);
      Provider.of<OrderProvider>(context, listen: false).shippingAddressNull();
      Provider.of<OrderProvider>(context, listen: false).billingAddressNull();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.green));

      _isLoading = false;
    } else {
      _isLoading = false;
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  Future<String> getUserInfo(BuildContext context) async {
    String userID = '-1';
    ApiResponse apiResponse = await profileRepo.getUserInfo();
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _userInfoModel = UserInfoModel.fromJson(apiResponse.response.data);
      userID = _userInfoModel.id.toString();
      // print('===> nai keno==>${_userInfoModel.loyaltyPoint}');
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
    return userID;
  }
 void  getUsermedium(String pref) async {
    final prefs = await SharedPreferences.getInstance();
  if (prefs.getString('medium')== 'google') {
    print(prefs.getString('medium'));
    pref = 'google';
    userMedium =pref;
  }
    else if (prefs.getString('medium')== 'facebook') {
      print(prefs.getString('medium'));
      pref = 'facebook';
      userMedium =pref;
    } else if (prefs.getString('medium')== 'apple') {
      print(prefs.getString('medium'));
      pref = 'apple';
      userMedium =pref;
    }

  }
  Future<String>  getUsermedium1( ) async {

    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('medium')== 'google') {

      userMedium = prefs.getString('medium');
     print('the usermedium is '+ userMedium);
      return userMedium;
    }
    else
      if(prefs.getString('medium')== 'facebook'){

        userMedium = prefs.getString('medium');
        print('the usermedium is '+ userMedium);
        return userMedium;
      }

      else if(prefs.getString('medium')== 'apple'){
        userMedium = prefs.getString('medium');
        print('the usermedium is '+ userMedium);
        return userMedium;
      }
        print('email user');
        return userMedium;

  }
  void  removeUsermedium(BuildContext context) async {

    final prefs = await SharedPreferences.getInstance();
    // print( await prefs.getString('medium')+ userMedium);
    await prefs.remove('medium');
    userMedium = '';


  }

  void initAddressTypeList(BuildContext context) async {
    if (_addressTypeList.length == 0) {
      ApiResponse apiResponse = await profileRepo.getAddressTypeList();
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        _addressTypeList.clear();
        _addressTypeList.addAll(apiResponse.response.data);
        _addressType = apiResponse.response.data[0];
      } else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }
  }

  Future addAddress(AddressModel addressModel, Function callback) async {
    _isLoading = true;
    notifyListeners();

    ApiResponse apiResponse = await profileRepo.addAddress(addressModel);
    _isLoading = false;

    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      Map map = apiResponse.response.data;
      if(_addressList == null) {
        _addressList = [];
      }
      _addressList.add(addressModel);
      String message = map["message"];
      callback(true, message);
    } else {
      String errorMessage = apiResponse.error.toString();
      if (apiResponse.error is String) {
        // print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        // print(errorResponse.errors[0].message);
        errorMessage = errorResponse.errors[0].message;
      }
      callback(false, errorMessage);
    }
    notifyListeners();
  }

  Future<ResponseModel> updateUserInfo(UserInfoModel updateUserModel, String pass, File file, String token) async {
    _isLoading = true;
    notifyListeners();

    ResponseModel responseModel;
    http.StreamedResponse response = await profileRepo.updateProfile(updateUserModel, pass, file, token);
    _isLoading = false;
    if (response.statusCode == 200) {
      Map map = jsonDecode(await response.stream.bytesToString());
      String message = map["message"];
      _userInfoModel = updateUserModel;
      responseModel = ResponseModel(message, true);
      // print(message);
    } else {
      // print('${response.statusCode} ${response.reasonPhrase}');
      responseModel = ResponseModel('${response.statusCode} ${response.reasonPhrase}', false);
    }
    notifyListeners();
    return responseModel;
  }

  // save office and home address
  void saveHomeAddress(String homeAddress) {
    profileRepo.saveHomeAddress(homeAddress).then((_) {
      notifyListeners();
    });
  }

  void saveOfficeAddress(String officeAddress) {
    profileRepo.saveOfficeAddress(officeAddress).then((_) {
      notifyListeners();
    });
  }

  // for home Address Section
  String getHomeAddress() {
    return profileRepo.getHomeAddress();
  }

  Future<bool> clearHomeAddress() async {
    return await profileRepo.clearHomeAddress();
  }

  // for office Address Section
  String getOfficeAddress() {
    return profileRepo.getOfficeAddress();
  }

  Future<bool> clearOfficeAddress() async {
    return await profileRepo.clearOfficeAddress();
  }
}
