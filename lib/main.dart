import 'dart:io';

import 'package:ali/layout/shop_app/shop_cubit/cubit.dart';
import 'package:ali/layout/shop_app/shop_layout.dart';
import 'package:ali/modules/shop_app/login_screen%20_shop_app/login-screen_shopapp.dart';
import 'package:ali/modules/shop_app/onboarding/on_boarding_screen.dart';
import 'package:ali/shared/components/bloc_Observer.dart';

import 'package:ali/shared/network/local/cache_helper.dart';
import 'package:ali/shared/network/remote/dio_helpers.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  HttpOverrides.global = MyHttpOverrides();
  BlocOverrides.runZoned(
    () async {
      // Use blocs...
      bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
      String? token = CacheHelper.getData(key: 'token');

      // print(token);
      Widget widget;
      //to determine which widget will start the app
      if (onBoarding != null) {
        if (token != null) {
          widget = ShopLayout();
        } else {
          widget = ShopLoginSreen();
        }
      } else {
        widget = OnBoardingScreen();
      }
      runApp(MyApp(
        startWidget: widget,
      ));
      DioHelpers.init();
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({required this.startWidget});

  //constructor
  //build
  @override
  Widget build(BuildContext context)
  {
    //the mother widget of runApp widget and styling our page
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavouritesData()
            ..getUserData(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}

//if there  is security issue with api
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
