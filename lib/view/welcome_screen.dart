import 'package:flutter/material.dart';
import 'package:thedipaar/utils/loaderUtils.dart';
import 'package:thedipaar/view/contactUs.dart';
import 'package:thedipaar/view/dashboard.dart';
import 'package:thedipaar/view/dashboardNew.dart';
import 'package:thedipaar/view/sample_work.dart';
import 'package:video_player/video_player.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late VideoPlayerController _controller;
   bool _videoFinishedPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
        Uri.parse('http://thedipaar.com/native/assets/videos/loader.mp4'))
      ..initialize().then((_) {
          _controller.addListener(videoPlayerListener);
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller.play();
        });
      });
  }

    void videoPlayerListener() {
    if (_controller.value.position >= _controller.value.duration) {
      setState(() {
        _videoFinishedPlaying = true;
      });
      if (_videoFinishedPlaying) {
        _navigate();
      }
    }
  }


 void _navigate() {
    _controller.pause();
    if (mounted)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => DashBoardNew()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 202, 43),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Center(child: CommonLoader()),
      ),
       floatingActionButton: Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton.extended(
                backgroundColor: const Color(0xFFE93314),
                highlightElevation: 5.0,
                onPressed: () {
                  // _fetchPreviousNews();
                   Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ContactUs()));
                },
                tooltip: "Contact Us",
                label: Text('Contact Us', style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold)),
                icon: Icon(Icons.contact_emergency_rounded, color: Colors.white),
              ),
              // SizedBox(width: 16),
                 FloatingActionButton.extended(
                backgroundColor: const Color(0xFFE93314),
                 highlightElevation: 5.0,
                onPressed: _navigate,
                tooltip: "Skip",
                 icon: Icon(Icons.skip_next_rounded, color: Colors.white),
                label: Text('Skip', style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold)),
               
              ),
          
            ],
          ),
        ),
    );
  }
}
