import 'dart:async';

import 'package:flutter/material.dart';
import 'package:thedipaar/constants/imageConstants.dart';
import 'package:thedipaar/modal/appconfigModal.dart';
import 'package:thedipaar/service/web_service.dart';
import 'package:thedipaar/view/onBoardingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  Appconfig? config;

  @override
  void initState() {
    super.initState();
    // Add a delay of 5 seconds before navigating to the home screen

    _fetchAppconfig();
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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  OnBoardingScreen()),
      );
    });
    } catch (e) {
      // Handle error
      print('Error: $e');
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          AppImages.app_logo,
          height: 250,
          width: 250,
        ),
      ),
    );
  }
}
