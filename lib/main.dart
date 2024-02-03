import 'dart:io';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_post/features/app/providers.dart';
import 'package:video_post/features/splash_screen/splash_screen.dart';
import 'features/app/router.dart' as router;
import 'features/app/router_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyAFmLXwfRyj7ona0763-P3F66IF3EUvVGs',
              appId: '1:864341362523:android:fd670d722aa2539fa7fc7e',
              messagingSenderId: '864341362523',
              projectId: 'clip-up'),
        )
      : await Firebase.initializeApp(
          //  options: DefaultFirebaseOptions.currentPlatform,
          );
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.debug,
  );

  runApp(const VideoPost());
}

class VideoPost extends StatefulWidget {
  const VideoPost({super.key});

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Providers.getAllProviders(),
      // child: CatcherScreenshot(
      //   catcher: Catcher.getInstance(),
      child: const MaterialApp(
        //themeMode: ThemeMode.light,
        // navigatorKey: Catcher.navigatorKey,
        //color: Palette.primary,
        debugShowCheckedModeBanner: false,
        // home: SplashScreen(),
        onGenerateRoute: router.generateRoute,
        initialRoute: RouterConstants.MainRoute,
        // ),
      ),
    );
  }
}
