import 'package:flutter/material.dart';

class DetailedVideoPostScreen extends StatefulWidget {
  const DetailedVideoPostScreen({super.key});

  @override
  State<DetailedVideoPostScreen> createState() => _DetailedVideoPostScreenState();
}

class _DetailedVideoPostScreenState extends State<DetailedVideoPostScreen> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Video Player
        Container(
          height: 200, // Adjust the height as needed
          color: Colors.grey[300], // Placeholder color for the video player
          child: Center(
            child: Icon(
              Icons.video_collection,
              size: 100,
              color: Colors.grey[600],
            ),
          ),
        ),
        SizedBox(height: 20),

        // Like, Dislike, Share icons row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.thumb_up),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.thumb_down),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.share),
            ),
          ],
        ),
        SizedBox(height: 10),

        // Viewers count and upload date row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('100 Viewers'),
            Text('Uploaded on: Jan 30, 2024'),
          ],
        ),
        SizedBox(height: 20),

        // User profile row
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey[400],
              // Add user profile image here
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'User Name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 5),
                GestureDetector(
                  onTap: () {
                    // View all option clicked
                  },
                  child: Text(
                    'View All',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            // Add more actions for the user profile here
          ],
        ),
        SizedBox(height: 20),

        // Comments section
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Add comments widgets here
              ],
            ),
          ),
        ),

        // Text field for replying to comments
        Container(
          margin: EdgeInsets.only(bottom: 10, left: 10),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Write a comment...',
                  ),
                ),
              ),
              SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  // Post button clicked
                },
                icon: Icon(Icons.send),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
