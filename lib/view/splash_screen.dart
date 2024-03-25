import 'dart:async';

import 'package:flutter/material.dart';
import 'package:thedipaar/constants/imageConstants.dart';
import 'package:thedipaar/modal/appconfigModal.dart';
import 'package:thedipaar/service/web_service.dart';
import 'package:thedipaar/utils/loaderUtils.dart';
import 'package:thedipaar/view/onBoardingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thedipaar/view/welcome_screen.dart';
import 'package:video_player/video_player.dart';

// class SpalshScreen extends StatefulWidget {
//   const SpalshScreen({super.key});

//   @override
//   State<SpalshScreen> createState() => _SpalshScreenState();
// }

// class _SpalshScreenState extends State<SpalshScreen> {
//   Appconfig? config;
//    late VideoPlayerController _controller;
//    bool _apiCallCompleted = false;

//   @override
//   void initState() {
//     super.initState();
//     // _controller = VideoPlayerController.asset('assets/videos/logo.mp4')..initialize().then((_){
//     //      _controller.play();
      
//     // });
//     // Add a delay of 5 seconds before navigating to the home screen

//     //    _fetchAppconfig().then((_) {
//     //   setState(() {
//     //     _apiCallCompleted = true;
//     //   });
//     // });
//     _fetchAppconfig();
//   }

  // Future<void> _fetchAppconfig() async {
  //   try {
  //     Appconfig news = await webservice.fetchAppconfig();
      
  //     setState(() {
  //       config = news;
  //     });
  //           SharedPreferences prefs = await SharedPreferences.getInstance();
  //     prefs.setString('aboutus_url', config!.aboutus_url);
  //     prefs.setString('contactus_url', config!.contactus_url);
  //     prefs.setString('share_baseurl', config!.share_baseurl);
  //          Timer(Duration(seconds: 5), () {
  //         // if (_apiCallCompleted) {
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => OnBoardingScreen()),
  //       );
  //     // }
  //   });
  //   } catch (e) {
  //     // Handle error
  //     print('Error: $e');
  //   } 
  // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
      // body: Center(
      //   // child:  _controller.value.isInitialized ? SizedBox(
      //   //   height: 200,width: 300,
      //   //   child: VideoPlayer(_controller)) : null
      //   child: Image.asset(
      //     AppImages.app_logo,
      //     height: 250,
      //     width: 250,
      //   ),
      // ),
//     );
//   }
// }

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
   Appconfig? config;
    VideoPlayerController? _controller ;
  bool _isLoading = true;


    @override
  void initState() {
    super.initState();
    _initializeVideo();
    _fetchAppconfig();
  }

  void _initializeVideo() {
    _controller = VideoPlayerController.asset('assets/videos/logo.mp4')
      ..initialize().then((_) {
        setState(() {
          _isLoading = false;
          _controller!.play();
        });
      });
  }


    Future<void> _fetchAppconfig() async {
    try {
      Appconfig news = await webservice.fetchAppconfig();
      
      setState(() {
        config = news;
      });
            SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('aboutus_url', config!.aboutus_url);
      prefs.setString('contactus_url', config!.contactus_url);
      prefs.setString('share_baseurl', config!.share_baseurl);
           Timer(Duration(seconds: 5), () {
          // if (_apiCallCompleted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
        );
      // }
    });
    } catch (e) {
      // Handle error
      print('Error: $e');
    } 
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(_controller!),
              ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }
}
