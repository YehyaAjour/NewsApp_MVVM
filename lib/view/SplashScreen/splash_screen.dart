import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/view/HomeScreen/home_screen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        splashIconSize: 200,
        splash: Image.asset(
          'assets/images/news.gif',
          fit: BoxFit.cover,
        ),
        nextScreen: HomeScreen(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.rightToLeftWithFade,
        animationDuration: const Duration(seconds: 3),
        duration: 3000,
        backgroundColor:  const Color(0xffFFCB00),
      ),
    );
  }
}
