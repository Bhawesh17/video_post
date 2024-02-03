import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:video_player/video_player.dart';
import 'package:video_post/features/app/router_constants.dart';
import 'package:video_post/widgets/like_button.dart';

class VideoPostScreen extends StatefulWidget {
  const VideoPostScreen({super.key});

  @override
  State<VideoPostScreen> createState() => _VideoPostScreenState();
}

class _VideoPostScreenState extends State<VideoPostScreen> with SingleTickerProviderStateMixin {

  late final AnimationController _controller;

  final VideoPlayerController _videoController = VideoPlayerController.network(
    Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4').toString(),
  );

  // final Uri videoUri = Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
  // final VideoPlayerController _videoController = VideoPlayerController.networkUri(videoUri);
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _videoController.initialize().then((_) {
      // Set the video to start at 10 seconds
      _videoController.seekTo(Duration(seconds: 15));
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _toggleRotation() {
    if (_controller.isAnimating) {
      _controller.stop();
    } else {
      _controller.repeat();
      Future.delayed(Duration(seconds: 2), () {
        _controller.stop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
           CustomAppBar(),
          SizedBox(
            height: 40,
          ),
      Card(
        child: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: _toggleRotation,
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        height: 50,
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (_, child) {
                            return Transform.rotate(
                              angle: _controller.value * 2 * math.pi,
                              child: child,
                            );
                          },
                          child: Image.asset('assets/logo2.png'),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    const   Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Bhawesh Deshmukh',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Some additional information',
                            style:
                            TextStyle(fontSize: 12, color: Colors.grey),
                          ),

                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Vasco, Goa',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '12:00 am',
                            style:
                            TextStyle(fontSize: 12, color: Colors.grey),
                          ),

                        ],
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  // Navigate to video screen
                  Navigator.pushNamed(context, RouterConstants.VideoScreen);
                },
                child: Container(
                  height: 250,
                  child: Stack(
                    children: [
                      VideoPlayer(_videoController),
                      Center(
                        child: IconButton(
                          icon: Icon(Icons.play_arrow, size: 48),
                          onPressed: () {
                            // Play video when clicked
                            _videoController.play();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: LikeButton(isLiked: true, onTap: (){

                  })),
                  Expanded(child: TextButton(onPressed: (){}, child: Text("Watch Full Video")))
                ],
              )
            ],
          ),
        ),
      )
        ],
      ),
    );
  }

  // Card VideoPostCard(BuildContext context) {
  //   return Card(
  //     child: Container(
  //       margin: EdgeInsets.all(5),
  //       decoration: BoxDecoration(
  //         border: Border.all(color: Colors.black),
  //       ),
  //       child: Column(
  //         children: [
  //           Container(
  //             child: Row(
  //               children: [
  //                 GestureDetector(
  //                   onTap: _toggleRotation,
  //                   child: Container(
  //                     padding: EdgeInsets.only(left: 10),
  //                     height: 50,
  //                     child: AnimatedBuilder(
  //                       animation: _controller,
  //                       builder: (_, child) {
  //                         return Transform.rotate(
  //                           angle: _controller.value * 2 * math.pi,
  //                           child: child,
  //                         );
  //                       },
  //                       child: Image.asset('assets/logo2.png'),
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   width: 20,
  //                 ),
  //                 const   Expanded(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Text(
  //                         'Bhawesh Deshmukh',
  //                         style: TextStyle(fontWeight: FontWeight.bold),
  //                       ),
  //                       Text(
  //                         'Some additional information',
  //                         style:
  //                         TextStyle(fontSize: 12, color: Colors.grey),
  //                       ),
  //
  //                     ],
  //                   ),
  //                 ),
  //                 Container(
  //                   margin: const EdgeInsets.only(right: 5),
  //                   child: const Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Text(
  //                         'Vasco, Goa',
  //                         style: TextStyle(fontWeight: FontWeight.bold),
  //                       ),
  //                       Text(
  //                         '12:00 am',
  //                         style:
  //                         TextStyle(fontSize: 12, color: Colors.grey),
  //                       ),
  //
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //           InkWell(
  //             onTap: () {
  //               // Navigate to video screen
  //               Navigator.pushNamed(context, RouterConstants.VideoScreen);
  //             },
  //             child: Container(
  //               height: 250,
  //               child: Stack(
  //                 children: [
  //                   VideoPlayer(_videoController),
  //                   Center(
  //                     child: IconButton(
  //                       icon: Icon(Icons.play_arrow, size: 48),
  //                       onPressed: () {
  //                         // Play video when clicked
  //                         _videoController.play();
  //                       },
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: [
  //               Expanded(child: LikeButton(isLiked: true, onTap: (){
  //
  //               })),
  //               Expanded(child: TextButton(onPressed: (){}, child: Text("Watch Full Video")))
  //             ],
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Container CustomAppBar() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      height: 70,
      child: Row(
        children: [
          GestureDetector(
            onTap: _toggleRotation,
            child: Container(
              padding: EdgeInsets.only(left: 10),
              height: 50,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (_, child) {
                  return Transform.rotate(
                    angle: _controller.value * 2 * math.pi,
                    child: child,
                  );
                },
                child: Image.asset('assets/logo2.png'),
              ),
            ),
          ),
          SizedBox(
            width: 50,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              //  width: 100,
              child: Image.asset(
                'assets/header.png',
                height: 50  ,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
