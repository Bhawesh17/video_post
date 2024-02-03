import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:video_player/video_player.dart';

class VideoUploadScreen extends StatefulWidget {
  const VideoUploadScreen({Key? key}) : super(key: key);

  @override
  State<VideoUploadScreen> createState() => _VideoUploadScreenState();
}

class _VideoUploadScreenState extends State<VideoUploadScreen> {
  Color myColor = const Color(0xFF471AA0);

  XFile? _videoFile;
  VideoPlayerController? _videoController;
  String? Name;
  String? streetName;
  String? Country;


  Future<void> getVideoFile(ImageSource sourceImg) async {
    final videoFile = await ImagePicker().pickVideo(source: sourceImg);
    setState(() {
      _videoFile = videoFile;
      if (_videoFile != null) {
        _videoController = VideoPlayerController.file(File(_videoFile!.path))
          ..initialize().then((_) {
            setState(() async{
            }); // Update the state after initialization
          });
      }
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> GetAddressFromLatlong(Position position) async{
    List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    print(placemark);
    Name = place.name; streetName= place.street; Country= place.country;

  }

  @override
  Widget build(BuildContext context) {
    return _videoFile != null && _videoController != null
        ? Container(
            margin: EdgeInsets.only(right: 10, left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 250,
                  child: Stack(
                    children: [
                      _videoController!.value.isInitialized
                          ? Center(
                              child: AspectRatio(
                                aspectRatio:
                                    _videoController!.value.aspectRatio,
                                child: VideoPlayer(_videoController!),
                              ),
                            )
                          : CircularProgressIndicator(),
                      Center(
                        child: IconButton(
                          icon: Icon(
                            _videoController!.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            size: 48,
                          ),
                          onPressed: () {
                            // Play/pause video when clicked
                            _videoController!.value.isPlaying
                                ? _videoController!.pause()
                                : _videoController!.play();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Location : $Name , $streetName , $Country",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Text(
                      "Title",
                      style: TextStyle(fontSize: 20),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Enter Title",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Text(
                      "Category",
                      style: TextStyle(fontSize: 20),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Enter Title",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Implement post functionality
                  },
                  child: Text("Post"),
                ),
              ],
            ),
          )
        : Center(
            child: TextButton(
              onPressed: () async {
                Position position = await _determinePosition();
                print(position.latitude);
                await GetAddressFromLatlong(position);
                // Permission granted, navigate to home page
                getVideoFile(ImageSource.camera);
              },
              child: Text(
                "Start Recording",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(myColor),
              ),
            ),
          );
  }

  void _showLocationPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Location Permission Required"),
          content: Text("Please enable location services to use this app."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
