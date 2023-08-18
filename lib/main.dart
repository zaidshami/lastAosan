// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_Aosan_ecommerce/provider/attributes_provider.dart';
import 'package:flutter_Aosan_ecommerce/provider/change_notifier_base.dart';
import 'package:flutter_Aosan_ecommerce/provider/filter_provider.dart';
import 'package:flutter_Aosan_ecommerce/provider/remote_config_service.dart';
import 'package:flutter_Aosan_ecommerce/view/screen/cart/cart_screen.dart';
import 'package:flutter_Aosan_ecommerce/view/screen/product/brand_and_category_product_screen.dart';
import 'package:flutter_Aosan_ecommerce/view/screen/profile/profile_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'di_container.dart' as di;
import 'helper/custom_delegate.dart';
import 'localization/app_localization.dart';
import 'notification/my_notification.dart';
import 'provider/auth_provider.dart';
import 'provider/brand_provider.dart';
import 'provider/cart_provider.dart';
import 'provider/category_provider.dart';
import 'provider/chat_provider.dart';
import 'provider/coupon_provider.dart';
import 'provider/facebook_login_provider.dart';
import 'provider/featured_deal_provider.dart';
import 'provider/google_sign_in_provider.dart';
import 'provider/home_category_product_provider.dart';
import 'provider/localization_provider.dart';
import 'provider/location_provider.dart';
import 'provider/notification_provider.dart';
import 'provider/onboarding_provider.dart';
import 'provider/order_provider.dart';
import 'provider/product_details_provider.dart';
import 'provider/banner_provider.dart';
import 'provider/flash_deal_provider.dart';
import 'provider/product_provider.dart';
import 'provider/profile_provider.dart';
import 'provider/search_provider.dart';
import 'provider/seller_provider.dart';
import 'provider/splash_provider.dart';
import 'provider/support_ticket_provider.dart';
import 'provider/theme_provider.dart';
import 'provider/top_seller_provider.dart';
import 'provider/wallet_transaction_provider.dart';
import 'provider/wishlist_provider.dart';
import 'theme/dark_theme.dart';
import 'theme/light_theme.dart';
import 'utill/app_constants.dart';
import 'view/screen/order/order_details_screen.dart';
import 'view/screen/splash/splash_screen.dart';




final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = new MyHttpOverrides();

  print('the baseurl before is : ' + AppConstants.BASE_URL);
  print('the categoryType before is : ' + AppConstants.categoryType.toString());
  print('the showBrandType before is : ' + AppConstants.brandShowType.toString());

  try {
    await RemoteConfigService.init().timeout(Duration(seconds: 10));
  } catch (e) {
    print('Failed to fetch remote config: $e');
    // Handle network errors here.
  }
  print('the brandShowType after is : ' + AppConstants.showBrand.toString());
  print('the baseurl after is : ' + AppConstants.BASE_URL);



  await di.init();
  final NotificationAppLaunchDetails notificationAppLaunchDetails =
  await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  int _orderID;
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    _orderID = (notificationAppLaunchDetails.payload != null && notificationAppLaunchDetails.payload.isNotEmpty)
        ? int.parse(notificationAppLaunchDetails.payload) : null;
  }
  await MyNotification.initialize(flutterLocalNotificationsPlugin);
  FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);

  try {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {


        // Extract the variables from the message and perform navigation based on them
        String pageToNavigate = message.data['page']; // Replace 'page' with the key for your specific variable
        String id = message.data['id']; // Replace 'page' with the key for your specific variable
        if (id != null) {
          print("myID: " + id);
          Navigator.of(MyApp.navigatorKey.currentContext).push(
            MaterialPageRoute(builder: (context) =>    BrandAndCategoryProductScreen(
              isBrand: false,
              id:id.toString(),
              name: pageToNavigate,

            )),
          );


        }
        else if (pageToNavigate == 'page2') {
        }
        else   if (pageToNavigate == 'page1') {
          Navigator.of(MyApp.navigatorKey.currentContext).push(
            MaterialPageRoute(builder: (context) => CartScreen()),
          );
        }

        // Add more conditions based on your requirements

      }
    });
  } catch (e) {
    print('Failed to fetch remote config: $e');
    // Handle network errors here.
  }


  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    RemoteNotification notification = message.notification;
    AndroidNotification android = message.notification?.android;
//todo : i think here is the problem of the pic of the iphone
    if (notification != null && android != null) {
      await MyNotification.showNotification(
        message,
        flutterLocalNotificationsPlugin,
        notification.body != null,

      );
    }
  });

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => di.sl<CategoryProvider>()),
          ChangeNotifierProvider(create: (context) => di.sl<HomeCategoryProductProvider>()),
          ChangeNotifierProvider(create: (context) => di.sl<TopSellerProvider>()),
          ChangeNotifierProvider(create: (context) => di.sl<FlashDealProvider>()),
          ChangeNotifierProvider(create: (context) => di.sl<FeaturedDealProvider>()),
          ChangeNotifierProvider(create: (context) => di.sl<BrandProvider>()),
          ChangeNotifierProvider(create: (context) => di.sl<ProductProvider>()),
          ChangeNotifierProvider(create: (context) => di.sl<BannerProvider>()),
          ChangeNotifierProvider(create: (context) => di.sl<ProductDetailsProvider>()),
          ChangeNotifierProvider(create: (context) => di.sl<OnBoardingProvider>()),
          ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
          ChangeNotifierProvider(create: (context) => di.sl<SearchProvider>()),
          ChangeNotifierProvider(create: (context) => di.sl<SellerProvider>()),
          ChangeNotifierProvider(create: (context) => di.sl<CouponProvider>()),
          ChangeNotifierProvider(create: (context) => di.sl<ChatProvider>()),
          ChangeNotifierProvider(create: (context) => di.sl<OrderProvider>()),
          ChangeNotifierProvider(create: (context) => di.sl<NotificationProvider>()),
          ChangeNotifierProvider(create: (context) => di.sl<ProfileProvider>()),
          ChangeNotifierProvider(create: (context) => di.sl<WishListProvider>()),
          ChangeNotifierProvider(create: (context) => di.sl<SplashProvider>()),
          ChangeNotifierProvider(create: (context) => di.sl<CartProvider>()),
          ChangeNotifierProvider(create: (context) => di.sl<SupportTicketProvider>()),
          ChangeNotifierProvider(create: (context) => di.sl<LocalizationProvider>()),
          ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
          ChangeNotifierProvider(create: (context) => di.sl<GoogleSignInProvider>()),
          ChangeNotifierProvider(create: (context) => di.sl<FacebookLoginProvider>()),
          ChangeNotifierProvider(create: (context) => di.sl<LocationProvider>()),
          ChangeNotifierProvider(create: (context) => di.sl<WalletTransactionProvider>()),
          ChangeNotifierProvider(create: (context) => di.sl<FilterCategoryProvider>()),
          ChangeNotifierProvider(create: (context) => di.sl<AttributeProvider>()),
        ],
        child: MyApp(orderId: _orderID),
      ),


  ));

}


///the old main before the
/*class MyApp extends StatelessWidget {
  final int orderId;
  MyApp({@required this.orderId});

  static final navigatorKey = new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    List<Locale> _locals = [];
    AppConstants.languages.forEach((language) {
      _locals.add(Locale(language.languageCode, language.countryCode));
    });
    return MaterialApp(
      title: AppConstants.APP_NAME,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).darkTheme ? dark : light,
      locale: Provider.of<LocalizationProvider>(context).locale,
      localizationsDelegates: [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FallbackLocalizationDelegate()
      ],
      supportedLocales: _locals,
      home: orderId == null ? SplashScreen() : OrderDetailsScreen(orderModel: null,
        orderId: orderId,orderType: 'default_type',),



    );
  }
}*/
class MyApp extends StatefulWidget {
  final int orderId;

  MyApp({@required this.orderId});

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  AppLifecycleState _appLifecycleState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    setState(() {
      _appLifecycleState = state;
    });

    if (state == AppLifecycleState.paused) {
      // App is going into the background (Home button pressed)
      // Save current state or perform necessary actions
      print('App paused');
    } else if (state == AppLifecycleState.resumed) {
      // App is coming into the foreground (App is resumed)
      // Update state or perform necessary actions
      print('App resumed');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Locale> _locals = [];
    AppConstants.languages.forEach((language) {
      _locals.add(Locale(language.languageCode, language.countryCode));
    });

    return MaterialApp(
      title: AppConstants.APP_NAME,
      navigatorKey: MyApp.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).darkTheme ? dark : light,
      locale: Provider.of<LocalizationProvider>(context).locale,
      localizationsDelegates: [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FallbackLocalizationDelegate()
      ],
      supportedLocales: _locals,
      home: widget.orderId == null
          ? SplashScreen()
          : OrderDetailsScreen(
        orderModel: null,
        orderId: widget.orderId,
        orderType: 'default_type',
      ),
    );
  }
}


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true; }}
Future<void> _handleBackgroundMessage(RemoteMessage message) async {
  // Handle background message
}