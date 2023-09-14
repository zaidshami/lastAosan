import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../utill/app_constants.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig;

  RemoteConfigService(this._remoteConfig);

  static Future<RemoteConfigService> init() async {
    await fetchAndActivateRemoteConfig();
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(hours: 1),
    ));

    await remoteConfig.setDefaults(<String, dynamic>{
      'baseUrlZ': AppConstants.BASE_URL,
      'showAndHideSocial':  AppConstants.showAndHideSocial,
      'showAndHideSocialApple': AppConstants.showAndHideSocialApple,
      'showAndHideSocialAppleInside': AppConstants.showAndHideSocialAppleInside,
      'textScaleFactor' : 1.0,
      'categoryType' :   AppConstants.categoryType,
      'categoryType1' :   AppConstants.categoryType1,
      'bannerFirst' :   AppConstants.bannerFirst,
      'showFooterBanner' :   AppConstants.showFooterBanner,
      'bannersView': AppConstants.bannersView,
      'showBrand': AppConstants.showBrand,
      'brandShowType': AppConstants.brandShowType,
      'showBrandPro': AppConstants.showBrandPro,
      'showTopSeller':  AppConstants.showTopSeller,
      'showSellerInfo':  AppConstants.showSellerInfo,
      'showNewArrival': AppConstants.showNewArrival,
      'showFeaturedProducts':AppConstants.showFeaturedProducts,
      'showFeaturedDeals':AppConstants.showFeaturedDeals,


    });
    await remoteConfig.getAll();
    await remoteConfig.fetchAndActivate();
    // AppConstants.BASE_URL = remoteConfig.getString('baseUrlZ');
    AppConstants.showLogin = remoteConfig.getBool('showAndHideSocial');
    AppConstants.showBrand = remoteConfig.getBool('showBrand');
    AppConstants.brandShowType = remoteConfig.getBool('brandShowType');
    AppConstants.showBrandPro = remoteConfig.getBool('showBrandPro');
    AppConstants.showTopSeller = remoteConfig.getBool('showTopSeller');
    AppConstants.showSellerInfo = remoteConfig.getBool('showSellerInfo');
    AppConstants.showLoginApple = remoteConfig.getBool('showAndHideSocialApple');
    AppConstants.showNewArrival = remoteConfig.getBool('showNewArrival');
    AppConstants.showFeaturedProducts = remoteConfig.getBool('showFeaturedProducts');
    AppConstants.showFeaturedDeals = remoteConfig.getBool('showFeaturedDeals');
    AppConstants.showFooterBanner = remoteConfig.getBool('showFooterBanner');
    AppConstants.showLoginAppleInside = remoteConfig.getBool('showAndHideSocialAppleInside');
    AppConstants.textScaleFactior = remoteConfig.getDouble('textScaleFactor');
    AppConstants.categoryType = remoteConfig.getBool('categoryType');
    AppConstants.bannerFirst = remoteConfig.getBool('bannerFirst');
    AppConstants.bannersView = remoteConfig.getBool('bannersView');
    AppConstants.categoryType1 = remoteConfig.getString('categoryType1');
    return RemoteConfigService(remoteConfig);
  }

  String get baseUrlZ => _remoteConfig.getString('baseUrlZ');
}
Future<void> fetchAndActivateRemoteConfig() async {
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  try {
    // Enable developer mode to allow for frequent refreshes of the config.
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: Duration.zero,
    ));

    // Set default values for your remote config variables.
    await remoteConfig.setDefaults(<String, dynamic>{
      'BASE_URL': 'https://your.default.base.url',
    });

    // Fetch and activate the remote config.
    await remoteConfig.fetchAndActivate();
  } catch (e) {
    print('Error fetching remote config: $e');
  }
}
