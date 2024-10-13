import 'package:bloc/bloc.dart';
import 'package:ecommerce/layout/layout_cubit/layout_cubit.dart';
import 'package:ecommerce/layout/layout_screen.dart';
import 'package:ecommerce/modules/auth_screens/auth_cubit/auth_cubit.dart';
import 'package:ecommerce/modules/auth_screens/login.dart';
import 'package:ecommerce/modules/home_screen.dart';
import 'package:ecommerce/modules/on_boarding.dart';
import 'package:ecommerce/modules/profile_screen.dart';
import 'package:ecommerce/shared/bloc_observer/bloc_observer.dart';
import 'package:ecommerce/shared/components/constants.dart';
import 'package:ecommerce/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  Widget widget;
  token = CacheHelper.getData(key: 'token');
  currentPassword = CacheHelper.getData(key: 'password');
  debugPrint('password now :$currentPassword');
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');

  if(onBoarding != null)
    {
      if(token != null) widget =LayoutScreen();
      else widget = LoginScreen();
    }else
      {
        widget = OnBoardingScreen();
      }

  runApp(
      MyApp(startWidget: widget,)
  );
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;

  MyApp({this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
        providers:
        [
          BlocProvider(create: (context)=>AuthCubit()),
          BlocProvider(create: (context)=>LayoutCubit()..getBannerData()..getCategoryData()..getProductData()..getFavorites()..getCart()),

        ],
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: startWidget
          ),
        ),
    );
  }
}