import 'package:flutter/material.dart';
import 'package:thedipaar/constants/imageConstants.dart';
import 'package:thedipaar/utils/samplePlugins.dart';
import 'package:thedipaar/view/Directory.dart';
import 'package:thedipaar/view/contactUs.dart';
import 'package:thedipaar/view/dashboard.dart';
import 'package:thedipaar/view/news_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';



class MyDrawer extends StatefulWidget {

  MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String? aboutUsURL;

  String? contactUsURL;

  @override
  void initState() { 
    super.initState();
_getConfig();
  }
  _getConfig()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
          aboutUsURL = prefs.getString('aboutus_url');
 contactUsURL = prefs.getString('contactus_url');
    });

 
  }

  @override
Widget build(BuildContext context) {
  return Drawer(
    backgroundColor: Color(0xff23527C),
    width: MediaQuery.of(context).size.width * 0.55,
    child: Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Image.asset(AppImages.app_logo,height: 80,width: 120,),
        ),
        buildListTile(Icons.list, 'Home', () {
          navigateWithAnimation(context, DashBoard());
        }),
        buildListTile(Icons.list, 'News', () {
          navigateWithAnimation(context, NewsList());
        }),
        buildListTile(Icons.list, 'About us', () {
          navigateWithAnimation(context, WebViewExample(loadUrl: aboutUsURL!));
        }),
        buildListTile(Icons.list, 'Contact us', () {
          navigateWithAnimation(context, ContactUs());
        }),
        buildListTile(Icons.list, 'Directory', () {
          navigateWithAnimation(context, DirectoryScreen());
        }),
        buildListTile(Icons.list, 'TV', () {
          navigateWithAnimation(context, WebViewExample(loadUrl: 'http://thedipar.com/tv/'));
        }),
        buildListTile(Icons.list, 'E-Book', () {
          navigateWithAnimation(context, WebViewExample(loadUrl: 'https://ebook.thedipaar.ca/'));
        }),
        buildListTile(Icons.list, 'FM', () {
          navigateWithAnimation(context, WebViewExample(loadUrl: 'https://zeno.fm/radio/thedipaar/'));
        }),
      ],
    ),
  );
}

Widget buildListTile(IconData icon, String title, void Function()? onTap) {
  return ListTile(
    leading: Icon(icon, color: Colors.white),
    title: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Colors.white)),
    onTap: onTap,
    selectedTileColor: Color(0xFFE93314),
  );
}

void navigateWithAnimation(BuildContext context, Widget page) {
  Navigator.of(context).push(PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: Duration(milliseconds: 600),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Scale animation
      var scaleTween = Tween(begin: 0.5, end: 1.0).animate(
        CurvedAnimation(
          parent: animation,
          curve: Interval(0.0, 0.5, curve: Curves.easeInOut),
        ),
      );

     

      return Stack(
        children: [
          ScaleTransition(
            scale: scaleTween,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          ),
        ],
      );
    },
  ));
}


}

