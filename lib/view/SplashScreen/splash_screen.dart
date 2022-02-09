
import 'package:flutter/material.dart';
import 'package:newsapp/view/CustomWidget/custom_image.dart';
import 'package:newsapp/view/HomeScreen/home_screen.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void navigatToPage() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );

    });
  }

  @override
  void initState() {
    navigatToPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CustomSvgImage(imageName: 'logo',width: 100,height: 100,)),
    );
  }
}
