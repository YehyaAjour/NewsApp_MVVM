import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/services/CacheHelper/cash_helper.dart';
import 'package:newsapp/services/DioHelper/dio_helper.dart';
import 'package:newsapp/view/HomeScreen/home_screen.dart';
import 'package:newsapp/view/SplashScreen/splash_screen.dart';
import 'package:newsapp/view_model/AppCubit/app_cubit.dart';
import 'package:newsapp/view_model/AppStates/app_states.dart';
import 'package:newsapp/view_model/bloc_observer.dart';

//baseurl="https://newsapi.org/"
//methodUrl='v2/top-headlines?'
//queries='country=us&apiKey=d4026a9324cf4415a67a049318928dad'
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  BlocOverrides.runZoned(() {
    runApp(const MyApp());
  }, blocObserver: MyBlocObserver());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..getGeneral()
        ..getBusinessNew()
        ..getEntertainment()
        ..getHealth()
        ..getScience()
        ..getSport()
        ..getTechnology(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: child,
              );
            },
           initialRoute: '/',
            routes: {
              '/':(context) => SplashScreen(),
            },

          );
        },
      ),
    );
  }
}

