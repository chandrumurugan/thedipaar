import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thedipaar/utils/loaderUtils.dart';
import 'package:thedipaar/view/contactUs.dart';
import 'package:thedipaar/view/dashboard.dart';
import 'package:thedipaar/view/dashboardNew.dart';
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
    _controller = VideoPlayerController.networkUrl(
        Uri.parse('http://52.77.122.228/native/assets/videos/loader.mp4'))
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
      MaterialPageRoute(builder: (BuildContext context) => DashBoardNew()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 202, 43),
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
        body: SafeArea(
          child: Stack(
            children: [
              _controller.value.isInitialized
                  ? Container(
                      height: MediaQuery.of(context).size.height  * 0.92,
                      color: Colors.amber,
                      child: VideoPlayer(_controller),
                    )
                  : Center(child: CommonLoader()),
            ],
          ),
        ),
      ),
    );
  }
}

//logincode
class LoginSignupScreen extends StatefulWidget {
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  bool _isLoginSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login / Sign Up"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isLoginSelected = true;
                    });
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: _isLoginSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isLoginSelected = false;
                    });
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: !_isLoginSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: _isLoginSelected ? LoginForm() : SignUpForm(),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey('login'),
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Username'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          SizedBox(height: 20),
          OutlinedButton(
            onPressed: () {
              // Login logic
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey('signup'),
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Username'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          SizedBox(height: 20),
          OutlinedButton(
            onPressed: () {
              // Sign up logic
            },
            child: Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}
