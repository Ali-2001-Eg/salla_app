import 'package:ali/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme = ThemeData(
    primarySwatch: defaultColor,
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: HexColor('333739')),
    scaffoldBackgroundColor: HexColor('333739'),
    appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333739'),
          statusBarIconBrightness: Brightness.light),
      backgroundColor: HexColor('333739'),
      elevation: 0.0,
      titleTextStyle: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: HexColor('333739'),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      elevation: 20.0,
    ),
    textTheme: const TextTheme(
        bodyText1: TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white)));

ThemeData lightTheme = ThemeData(
    primarySwatch: defaultColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      // to control our status bar
      titleSpacing: 20.0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      backgroundColor: Colors.white,
      elevation: 0.0,
      titleTextStyle: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defaultColor,
        unselectedItemColor: Colors.grey,
        elevation: 20.0),
    textTheme: const TextTheme(
        bodyText1: TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black)));
