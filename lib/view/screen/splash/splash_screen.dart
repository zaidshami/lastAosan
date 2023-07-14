import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../provider/auth_provider.dart';
import '../../../../provider/splash_provider.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/images.dart';
import '../../../../view/basewidget/no_internet_screen.dart';
import '../../../../view/screen/auth/auth_screen.dart';
import '../../../../view/screen/dashboard/dashboard_screen.dart';
import '../../../../view/screen/home/home_screens.dart';
import '../../../../view/screen/maintenance/maintenance_screen.dart';
import '../../../../view/screen/onboarding/onboarding_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();
  StreamSubscription<ConnectivityResult> _onConnectivityChanged;

  @override
  void initState() {
    super.initState();

    bool _firstTime = true;
    _onConnectivityChanged = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(!_firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
        isNotConnected ? SizedBox() : ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 5 : 2),
          content: Text(
            isNotConnected ? getTranslated('no_connection', context) : getTranslated('connected', context),
            textAlign: TextAlign.center,
          ),
        ));
        if(!isNotConnected) {
          _route();
        }
      }
      _firstTime = false;
    });

    _route();
  }

  @override
  void dispose() {
    super.dispose();

    _onConnectivityChanged.cancel();
  }

  void _route() {
    Provider.of<SplashProvider>(context, listen: false)
        .initConfig(context)
        .then((bool isSuccess) {
      //  print("hjjhhhh $isSuccess");
      if (isSuccess) {
        Provider.of<SplashProvider>(context, listen: false)
            .initSharedPrefData();
        Timer(Duration(seconds: 2), () {
          if (mounted) { // Add this check
            if (Provider.of<SplashProvider>(context, listen: false)
                .configModel
                .maintenanceMode) {
              Navigator.of(context).pushReplacement(CupertinoPageRoute(
                  builder: (BuildContext context) => MaintenanceScreen()));
            } else {
              if (Provider.of<AuthProvider>(context, listen: false)
                  .isLoggedIn()) {
                Provider.of<AuthProvider>(context, listen: false)
                    .updateToken(context);
                Navigator.of(context).pushReplacement(CupertinoPageRoute(
                    builder: (BuildContext context) => DashBoardScreen()));
              } else {
                if (Provider.of<SplashProvider>(context, listen: false)
                    .showIntro()) {
                  Navigator.of(context).pushReplacement(CupertinoPageRoute(
                      builder: (BuildContext context) => OnBoardingScreen(
                        indicatorColor: ColorResources.GREY,
                        selectedIndicatorColor:
                        Theme.of(context).primaryColor,
                      )));
                } else {
                  Navigator.of(context).pushReplacement(CupertinoPageRoute(
                      builder: (BuildContext context) => DashBoardScreen()));
                }
              }
            }
          }
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _globalKey,
      body: Provider.of<SplashProvider>(context).hasConnection ? Stack(
        clipBehavior: Clip.none, children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.black : ColorResources.getPrimary(context),
            // child: CustomPaint(
            //   painter: SplashPainter(),
            // ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(Images.awsan_splash, height: 550.0,
                  width: 250.0,),
              ],
            ),
          ),
        ],
      ) : NoInternetOrDataScreen(isNoInternet: true, child: SplashScreen()),
    );
  }

}
