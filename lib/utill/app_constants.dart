
import 'package:flutter/material.dart';

import '../../../../data/model/response/language_model.dart';
import '../data/model/response/product_model.dart';
import 'dimensions.dart';

class AppConstants {


  static const String APP_NAME = 'Aosan online';
  // static const String BASE_URL = 'http://192.168.1.134/Admin';
  static const String TOPIC = 'Jwaher';
  // static  String BASE_URL = 'https://aosan.co';
  static  String BASE_URL = 'https://jwaher.co';
  // static  String BASE_URL -= 'https://aosantest.info/';
  // static  String BASE_URL = 'http://s955305333.onlinehome.us';
  static const String USER_ID = 'userId';
  static const String NAME = 'name';
  static const String CATEGORIES_URI = '/api/v1/categories';
  static const String Filter_CATEGORIES_URI = '/api/v1/attributes';
  static const String ATTRBUITES_CATEGORIES_URI = '/api/v1/products/attrbuites';
  static const String BRANDS_URI = '/api/v1/brands?category_id=';
  static const String BRAND_PRODUCT_URI = '/api/v1/brands/products/';
  static const String CATEGORY_PRODUCT_URI = '/api/v1/categories/products/';
  static const String REGISTRATION_URI = '/api/v1/auth/register';
  static const String LOGIN_URI = '/api/v1/auth/login';
  static const String DELETE_ACCOUNT = '/api/v1/auth/delete_account';
  static const String LATEST_PRODUCTS_URI = '/api/v1/products/latest?';
  static const String NEW_ARRIVAL_PRODUCTS_URI = '/api/v1/products/latest?';
  static const String TOP_PRODUCTS_URI = '/api/v1/products/top-rated?';
  static const String BEST_SELLING_PRODUCTS_URI = '/api/v1/products/best-sellings?';
  static const String DISCOUNTED_PRODUCTS_URI = '/api/v1/products/discounted-product?';
  static const String FEATURED_PRODUCTS_URI = '/api/v1/products/featured?';
  static const String HOME_CATEGORY_PRODUCTS_URI = '/api/v1/products/home-categories';
  static const String PRODUCT_DETAILS_URI = '/api/v1/products/details/';
  static const String PRODUCT_REVIEW_URI = '/api/v1/products/reviews/';
  static const String SEARCH_URI = '/api/v1/products/search?';
  static const String CONFIG_URI = '/api/v1/config';
  static const String ADD_WISH_LIST_URI = '/api/v1/customer/wish-list/add?product_id=';
  static const String REMOVE_WISH_LIST_URI = '/api/v1/customer/wish-list/remove?product_id=';
  static const String UPDATE_PROFILE_URI = '/api/v1/customer/update-profile';
  static const String CUSTOMER_URI = '/api/v1/customer/info';
  static const String ADDRESS_LIST_URI = '/api/v1/customer/address/list';
  static const String REMOVE_ADDRESS_URI = '/api/v1/customer/address?address_id=';
  static const String ADD_ADDRESS_URI = '/api/v1/customer/address/add';
  static const String WISH_LIST_GET_URI = '/api/v1/customer/wish-list';
  static const String SUPPORT_TICKET_URI = '/api/v1/customer/support-ticket/create';
  static const String MAIN_BANNER_URI = '/api/v1/banners?banner_type=main_banner&category_id=';
  static const String FOOTER_BANNER_URI = '/api/v1/banners?banner_type=footer_banner&category_id=';
  static const String MAIN_SECTION_BANNER_URI = '/api/v1/banners?banner_type=main_section_banner&category_id=';
  static const String SECOND_SECTION_BANNER_URI = '/api/v1/banners?banner_type=sec_section_banner&category_id=';
  static const String RELATED_PRODUCT_URI = '/api/v1/products/related-products/';
  static const String ORDER_URI = '/api/v1/customer/order/list';
  static const String ORDER_DETAILS_URI = '/api/v1/customer/order/details?order_id=';
  static const String ORDER_PLACE_URI = '/api/v1/customer/order/place';
  static const String SELLER_URI = '/api/v1/seller?seller_id=';
  static const String SELLER_PRODUCT_URI = '/api/v1/seller/';
  static const String TOP_SELLER = '/api/v1/seller/top';
  static const String TRACKING_URI = '/api/v1/order/track?order_id=';
  static const String FORGET_PASSWORD_URI = '/api/v1/auth/forgot-password';
  static const String SUPPORT_TICKET_GET_URI = '/api/v1/customer/support-ticket/get';
  static const String SUPPORT_TICKET_CONV_URI = '/api/v1/customer/support-ticket/conv/';
  static const String SUPPORT_TICKET_REPLY_URI = '/api/v1/customer/support-ticket/reply/';
  static const String SUBMIT_REVIEW_URI = '/api/v1/products/reviews/submit';
  static const String FLASH_DEAL_URI = '/api/v1/flash-deals?category_id=';
  static const String FEATURED_DEAL_URI = '/api/v1/deals/featured?category_id=';
  static const String FLASH_DEAL_PRODUCT_URI = '/api/v1/flash-deals/products/';
  static const String COUNTER_URI = '/api/v1/products/counter/';
  static const String SOCIAL_LINK_URI = '/api/v1/products/social-share-link/';
  static const String SHIPPING_URI = '/api/v1/products/shipping-methods';
  static const String CHOSEN_SHIPPING_URI = '/api/v1/shipping-method/chosen';
  static const String COUPON_URI = '/api/v1/coupon/apply?code=';
  static const String MESSAGES_URI = '/api/v1/customer/chat/messages?shop_id=';
  static const String CHAT_INFO_URI = '/api/v1/customer/chat';
  static const String SEND_MESSAGE_URI = '/api/v1/customer/chat/send-message';
  static const String TOKEN_URI = '/api/v1/customer/cm-firebase-token';
  static const String NOTIFICATION_URI = '/api/v1/notifications';
  static const String GET_CART_DATA_URI = '/api/v1/cart';
  static const String ADD_TO_CART_URI = '/api/v1/cart/add';
  static const String UPDATE_CART_QUANTITY_URI = '/api/v1/cart/update';
  static const String REMOVE_FROM_CART_URI = '/api/v1/cart/remove';
  static const String GET_SHIPPING_METHOD = '/api/v1/shipping-method/by-seller';
  static const String CHOOSE_SHIPPING_METHOD = '/api/v1/shipping-method/choose-for-order';
  static const String CHOSEN_SHIPPING_METHOD_URI = '/api/v1/shipping-method/chosen';
  static const String GET_SHIPPING_INFO = '/api/v1/shipping-method/detail/1';
  static const String CHECK_PHONE_URI = '/api/v1/auth/check-phone';
  static const String VERIFY_PHONE_URI = '/api/v1/auth/verify-phone';
  static const String SOCIAL_LOGIN_URI = '/api/v1/auth/social-login';
  static const String SOCIAL_LOGIN_APPLE_URI = '/api/v1/auth/login-apple';
  static const String CHECK_EMAIL_URI = '/api/v1/auth/check-email';
  static const String VERIFY_EMAIL_URI = '/api/v1/auth/verify-email';
  static const String RESET_PASSWORD_URI = '/api/v1/auth/reset-password';
  static const String VERIFY_OTP_URI = '/api/v1/auth/verify-otp';
  static const String REFUND_REQUEST_URI = '/api/v1/customer/order/refund-store';
  static const String REFUND_REQUEST_PRE_REQ_URI = '/api/v1/customer/order/refund';
  static const String REFUND_RESULT_URI = '/api/v1/customer/order/refund-details';
  static const String CANCEL_ORDER_URI = '/api/v1/order/cancel-order';
  static const String GET_SELECTED_SHIPPING_TYPE_URI = '/api/v1/shipping-method/check-shipping-type';
  static const String DEAL_OF_THE_DAY_URI = '/api/v1/dealsoftheday/deal-of-the-day';
  static const String WALLET_TRANSACTION_URI = '/api/v1/customer/wallet/list?limit=10&offset=';
  static const String LOYALTY_POINT_URI = '/api/v1/customer/loyalty/list?limit=20&offset=';
  static const String LOYALTY_POINT_CONVERT_URI = '/api/v1/customer/loyalty/loyalty-exchange-currency';

  //address
  static const String UPDATE_ADDRESS_URI = '/api/v1/customer/address/update/';
  static const String GEOCODE_URI = '/api/v1/mapapi/geocode-api';
  static const String SEARCH_LOCATION_URI = '/api/v1/mapapi/place-api-autocomplete';
  static const String PLACE_DETAILS_URI = '/api/v1/mapapi/place-api-details';
  static const String DISTANCE_MATRIX_URI = '/api/v1/mapapi/distance-api';
  // sharePreference
  static const String TOKEN = 'token';
  static const String USER = 'user';
  static const String USER_EMAIL = 'user_email';
  static const String USER_PASSWORD = 'user_password';
  static const String HOME_ADDRESS = 'home_address';
  static const String SEARCH_ADDRESS = 'search_address';
  static const String OFFICE_ADDRESS = 'office_address';
  static const String CART_LIST = 'cart_list';
  static const String CONFIG = 'config';
  static const String GUEST_MODE = 'guest_mode';
  static const String CURRENCY = 'currency';
  static const String LANG_KEY = 'lang';
  static const String INTRO = 'intro';

  // order status
  static const String PENDING = 'pending';
  static const String CONFIRMED = 'confirmed';
  static const String PROCESSING = 'processing';
  static const String PROCESSED = 'processed';
  static const String DELIVERED = 'delivered';
  static const String FAILED = 'failed';
  static const String RETURNED = 'returned';
  static const String CANCELLED = 'canceled';
  static const String OUT_FOR_DELIVERY = 'out_for_delivery';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String THEME = 'theme';

  static const String USER_ADDRESS = 'user_address';

  //RemoteConfig
  static  bool showLogin = true;
  static  bool showBrand = false;
  static  bool showTopSeller = false;
  static  String categoryType1 = 'true';
  static  bool categoryType = true;
  static  bool bannerFirst = true;
  static  bool bannersView = true;
  static  bool showLoginApple = true;
  static  bool showLoginAppleInside = true;
  static double textScaleFactior = 1.0 ;



  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: '', languageName: 'Arabic', countryCode: 'SA', languageCode: 'ar'),
    LanguageModel(imageUrl: '', languageName: 'English', countryCode: 'US', languageCode: 'en'),
  ];
}
Map<String,List<String>> list_without_deplucate(List<Product> list){
  Map<String,List<String>> OptionsList={};

  // list.forEach((element) {
  //   element.choiceOptions.forEach((element) {
  //
  //     if(OptionsList.containsKey(element.title)) {
  //       OptionsList.update(element.title, (value) => value + element.options);
  //       OptionsList[element.title]=OptionsList[element.title].toSet().toList();
  //     }else{
  //       OptionsList[element.title]=element.options;
  //     }
  //   });
  //
  // });
  return OptionsList;


}

   var paddingRowTitle =  EdgeInsets.only(
  //  left: Dimensions.PADDING_SIZE_EXTRA_SMALL,0
    left: 15,
    right:25,
    bottom: Dimensions
        .PADDING_SIZE_EXTRA_SMALL) as Padding;

var shopWithUsDecoration =

BoxDecoration(
  border: Border.all(
    color: Colors.green.withOpacity(0.4),
    width:0.5 ,
  ),
);

var customDecoration =
BoxDecoration(
    color: Colors.transparent,
    boxShadow: [
      BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: Offset(0, 1)), // changes position of shadow
    ],

    borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL));

