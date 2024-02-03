import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:video_post/features/video_post_screen/video_post_screen.dart';
import 'package:video_post/features/video_upload_screen/video_upload_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color myColor = const Color(0xFF471AA0);
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          child: getSelectedWidget(index: index),
        ),
        bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.white,
            color: myColor,
            index: index,
            onTap: (selectedIndex) {
              setState(() {
                index = selectedIndex;
              });
            },
            items: const [
           Icon(
                Icons.home,
                color: Colors.white,
              ),
              Icon(
                Icons.add,
                color: Colors.white,
              ),
              Icon(
                Icons.account_circle_outlined,
                color: Colors.white,
              ),
            ]),
      ),
    );
  }

  getSelectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = const VideoPostScreen();
        break;
      case 1:
        widget = const VideoUploadScreen();
        break;
      default:
        widget = const VideoPostScreen();
        break;
    }
    return widget;
  }
}
