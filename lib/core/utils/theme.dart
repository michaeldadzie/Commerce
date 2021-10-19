import 'package:flutter/material.dart';
import 'package:shop_app/core/route/custom_route.dart';

class Constants {
  static String appName = "Shop App";

  //Colors for theme
  static Color lightPrimary = Color(0xfffcfcff);
  static Color darkPrimary = Colors.black;
  static Color lightAccent = Colors.blueGrey[900];
  static Color darkAccent = Colors.white;
  static Color lightBG = Color(0xfffcfcff);
  static Color darkBG = Colors.black;
  static Color badgeColor = Colors.red;

  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor: lightAccent,
    cursorColor: lightAccent,
    cardColor: Color(0xfffcfcff),
    hintColor: Colors.grey.shade300,
    // pageTransitionsTheme: PageTransitionsTheme(
    //   builders: {
    //     TargetPlatform.android: CustomPageTransitionBuilder(),
    //     TargetPlatform.iOS: CustomPageTransitionBuilder(),
    //   },
    // ),
    pageTransitionsTheme: PageTransitionsTheme(builders: {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        headline6: TextStyle(
          color: darkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    cardColor: darkPrimary,
    hintColor: Colors.grey.shade50,
    // pageTransitionsTheme: PageTransitionsTheme(
    //   builders: {
    //     TargetPlatform.android: CustomPageTransitionBuilder(),
    //     TargetPlatform.iOS: CustomPageTransitionBuilder(),
    //   },
    // ),
    pageTransitionsTheme: PageTransitionsTheme(builders: {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
    scaffoldBackgroundColor: darkBG,
    cursorColor: darkAccent,
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        headline6: TextStyle(
          color: lightBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );
}
