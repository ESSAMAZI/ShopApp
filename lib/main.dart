// ignore_for_file: unused_local_variable, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, null_check_always_fails, non_constant_identifier_names, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/cubit.dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:shopapp/layout/shop_app/shop_layout.dart';
import 'package:shopapp/modules/login/cubit/cubit.dart';
import 'package:shopapp/modules/login/shop_login_Screen.dart';
import 'package:shopapp/modules/on_boarding/on_boarding_screen.dart';
import 'package:shopapp/shared/Bloc_obServer.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

import 'package:shopapp/shared/styles/themes.dart';

void main() async {
  //في حاله تحول الداله الماين الى  اسنك لابد من كتابه هذه الداله
  //لكي يتم تنفيذ هذه الاكواد اولا قبل ما يشتغل التطبيق
  //بيتاكد ان كل حاجه هنا في الميثود خلصت وبعدين يفتح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHeplper.init(); //الاتصال برابط  الموقع
  await CacheHelper.init();
  //حفظ تخطي القائمه الاولى
  // ignore: dead_code

//في حاله كانت القيمه فارغة
// او في حاله فتح التطبيق اول مره
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');

  //// onBoarding ??= false;

  //print('token == $token');

  ///print(onBoarding);
  ///نرن على تصميم
  Widget widget;
  // ignore: unnecessary_null_comparison
  if (onBoarding != null) {
    if (token != null) {
      widget = const ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = const OnBoadingScreen();
  }

  //اصلاح مشكله الاتصال في الاصدارات القديمة
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp(StartWidget: widget));
}

class MyApp extends StatelessWidget {
  final Widget? StartWidget;
  MyApp({this.StartWidget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ShopCubit()
              ..getHomeData()
              ..getCategories()
              ..getFavorites()
            //..getUserData(),
            ),
        BlocProvider(
          create: (context) => Shop_Login_Cubit()..getUserData(),
        )
      ],
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              // في حاله كانت القيمة تسوي ترو انتقل الى شاشة تسجيل الدخول
              //رح نشغل على حسب القيم المحفوظه
              home: StartWidget
              //? ShopLoginScreen() : const OnBoadingScreen(),
              );
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
