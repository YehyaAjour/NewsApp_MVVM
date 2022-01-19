import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/services/CacheHelper/cash_helper.dart';
import 'package:newsapp/services/DioHelper/dio_helper.dart';
import 'package:newsapp/view/HomeScreen/home_screen.dart';
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
            // theme: ThemeData(
            //     //scaffoldBackgroundColor: Colors.white,
            //     appBarTheme: const AppBarTheme(
            //         titleTextStyle: TextStyle(
            //             color: Colors.white,
            //             fontSize: 25,
            //             fontWeight: FontWeight.bold),
            //         backgroundColor: Color(0xff3EB489),
            //         elevation: 0,
            //         backwardsCompatibility: false,
            //         //for statusBar
            //         systemOverlayStyle: SystemUiOverlayStyle(
            //             statusBarColor: Color(0xff3EB489),
            //             statusBarIconBrightness: Brightness.light)),
            //     bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            //       backgroundColor: Color(0xff3EB489),
            //       type: BottomNavigationBarType.fixed,
            //       unselectedItemColor: Colors.black,
            //       selectedItemColor: Colors.white,
            //       selectedLabelStyle: TextStyle(fontSize: 18),
            //       unselectedLabelStyle: TextStyle(fontSize: 18),
            //
            //
            //
            //
            //     )),
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}

// CurvedNavigationBar(
// height: 60,
// animationDuration: Duration(milliseconds: 500),
// items: [
// Column(
// children: [
// SvgPicture.asset("assets/icons/education.svg",
// height: 30, width: 30, semanticsLabel: 'Acme Logo'),
// Text(
// "المحفظين",
// style: TextStyle(
// color: Colors.black, fontWeight: FontWeight.bold),
// )
// ],
// ),
// Column(
// children: [
// SvgPicture.asset("assets/icons/crowd.svg",
// height: 30, width: 30, semanticsLabel: 'yehya'),
// Text(
// "الحلقات",
// style: TextStyle(
// color: Colors.black, fontWeight: FontWeight.bold),
// ),
// ],
// ),
// Column(
// children: [
// SvgPicture.asset("assets/icons/reading.svg",
// height: 30, width: 30, semanticsLabel: 'yehya'),
// Text(
// "الطلاب",
// style: TextStyle(
// color: Colors.black, fontWeight: FontWeight.bold),
// )
// ],
// ),
// ],
// backgroundColor: Colors.white,
// color: Colors.green[400],
// buttonBackgroundColor: Colors.transparent,
// index: AppCubit.get(context).currentIndex,
// onTap: (int value) {
// AppCubit.get(context).changeIndex(value);
// },
// ),
