import 'package:flutter/material.dart';
//final originalTextTheme = ThemeData.light().textTheme;
//final newTextTheme = originalTextTheme.apply(fontSizeFactor: 1.0);
ThemeData light = ThemeData(
  //textTheme: newTextTheme,
  fontFamily: 'TitilliumWeb',
  primaryColor: Colors.black,
  brightness: Brightness.light,
  highlightColor: Colors.white,
  hintColor: Color(0xFF9E9E9E),
  pageTransitionsTheme: PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);