import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:video_post/features/homepage/home_page.dart';
import 'package:video_post/features/login&singup/login_page.dart';
import 'package:video_post/features/login&singup/login_page_provider.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var prov;


  @override
  Widget build(BuildContext context) {
     prov = Provider.of<SplashScreeProvider>(context , listen: false);

    return Scaffold(
        body: AnimatedSplashScreen(
          duration: 30,
          splash: Image.asset('assets/logo.png'),
          nextScreen: LoginScreen(),
          splashTransition: SplashTransition.fadeTransition,
          splashIconSize: double.infinity,
          backgroundColor: Color(0xFFFFFFFF),
          // pageTransitionType: PageTransitionType.scale,
        ));

  }

  Widget determineNextScreen() {
    bool isLoggedIn = prov.checkIfUserIsLoggedIn();

    if (isLoggedIn) {
      return HomeScreen();
    } else {
      return LoginScreen();
    }
  }

}
