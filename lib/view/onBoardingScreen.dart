import 'package:flutter/material.dart';
import 'package:thedipaar/utils/loaderUtils.dart';
import 'package:thedipaar/view/dashboard.dart';
import 'package:video_player/video_player.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late VideoPlayerController _controller;
  bool _videoFinishedPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse('http://52.77.122.228/native/assets/videos/loader.mp4'))
      ..initialize().then((_) {
        _controller.addListener(videoPlayerListener);

        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => DashBoard()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 202, 43),
      body: SafeArea(
        child: Stack(
          children: [
            _controller.value.isInitialized
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.90,
                    color: Colors.amber,
                    child: VideoPlayer(_controller),
                  )
                : Center(child: CommonLoader()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          height: 60,
                          // width: 80,
                          decoration: BoxDecoration(
                            color: Color(0xff23527C),
                            borderRadius: BorderRadius.circular(
                                10), // Adjust the radius as needed
                          ),
                          child: Center(
                            child: Text(
                              "Contact Us",
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: _navigate,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          height: 60,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Color(0xff23527C),
                            borderRadius: BorderRadius.circular(
                                10), // Adjust the radius as needed
                          ),
                          child: Center(
                            child: Text(
                              "Skip",
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
