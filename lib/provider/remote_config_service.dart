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
      'showAndHideSocial': true,
      'showAndHideSocialApple': true,
      'showAndHideSocialAppleInside': true,
      'textScaleFactor' : 1.0,
      'categoryType' :   AppConstants.categoryType,
      'categoryType1' :   AppConstants.categoryType1,
      'bannerFirst' :   AppConstants.bannerFirst,
      'bannersView': AppConstants.bannersView,
      'showBrand': AppConstants.showBrand,
      'showTopSeller': AppConstants.showTopSeller,


    });
    await remoteConfig.getAll();
    await remoteConfig.fetchAndActivate();
    // AppConstants.BASE_URL = remoteConfig.getString('baseUrlZ');
    AppConstants.showLogin = remoteConfig.getBool('showAndHideSocial');
    AppConstants.showBrand = remoteConfig.getBool('showBrand');
    AppConstants.showTopSeller = remoteConfig.getBool('showTopSeller');
    AppConstants.showLoginApple = remoteConfig.getBool('showAndHideSocialApple');
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
