import 'package:flutter/material.dart';

import 'package:video_post/features/app/router_constants.dart';
import 'package:video_post/features/homepage/home_page.dart';
import 'package:video_post/features/login&singup/login_page.dart';
import 'package:video_post/features/splash_screen/splash_screen.dart';



  Route<dynamic> generateRoute(RouteSettings settings) {
    var arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            settings: settings, builder: (context) => SplashScreen());
      case 'HomeScreen':
        return MaterialPageRoute(
            settings: settings, builder: (context) => HomeScreen());
      // case 'VideoScreen':
      //   return MaterialPageRoute(
      //       settings: settings, builder: (context) => ViewCardDetails());
      default:
    }
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        body: Text('no route defined'),
      );
    });
  }

