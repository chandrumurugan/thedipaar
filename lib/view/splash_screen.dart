import 'dart:async';

import 'package:flutter/material.dart';
import 'package:thedipaar/constants/imageConstants.dart';
import 'package:thedipaar/view/dashboard.dart';
import 'package:circular_bottom_navigation/tab_item.dart';

import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
   @override
  void initState() {
    super.initState();
    // Add a delay of 5 seconds before navigating to the home screen
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  DashBoard()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      
       backgroundColor: Colors.white,
      body: Center(
        // Replace 'your_image_path' with the path to your image asset
        child: Image.asset(AppImages.app_logo,height: 250,width: 250,),
      ),
    );
  }
}