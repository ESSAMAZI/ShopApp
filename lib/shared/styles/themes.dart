// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.blue, //1
  //primarySwatch: Colors.deepOrange,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20,
    backwardsCompatibility: false,
    //اعطاء لون لقسم الذي عند البطارية
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    //لون الى الايقونة
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  //لون لافلوت اكشن بتون
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blue, //2
  ),
  //الالوان القائمة السفلية
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.blue, //3
    //unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
      bodyText1: TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  )),
);
//الثيم الابيض
ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.deepOrange,
  //primarySwatch: Colors.deepOrange,
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    backwardsCompatibility: false,
    //اعطاء لون لقسم الذي عند البطارية
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    //الشريط العلوي الاب بار
    backgroundColor: HexColor('333739'),
    elevation: 0.0,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    //لون في الابار الايقونة
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),
  //لون لافلوت اكشن بتون
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange,
  ),
  //الالوان القائمة السفلية
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: HexColor('333739'),
  ),
  //التعامل مع النصوص
  textTheme: const TextTheme(
      //التعامل مع االنص محدد المساحه
      bodyText1: TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  )),
);
