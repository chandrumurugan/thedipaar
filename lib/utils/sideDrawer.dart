import 'package:flutter/material.dart';
import 'package:thedipaar/constants/imageConstants.dart';
import 'package:thedipaar/utils/samplePlugins.dart';
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
            // child: Row(
            //   children: [
            //     CircleAvatar(
            //       radius: 30,
            //       backgroundColor: Colors.grey[600],
            //     ),
            //     const SizedBox(
            //       width: 10,
            //     ),
            //     const Text(
            //       'NAME',
            //       style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
            //     )
            //   ],
            // ),
            child: Image.asset(AppImages.app_logo,height: 80,width: 120,),
          ),
          ListTile(
            leading: const Icon(Icons.list,color:Colors.white ,), // Replace with your icon
            title: const Text('Home',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Colors.white)),
            onTap: () {
              // Handle list item 1 tap
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
              // Navigator.pop(context);
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => DashBoard()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.list,color: Colors.white), // Replace with your icon
            title: const Text('News',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Colors.white)),
            onTap: () {
              // Handle list item 2 tap
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => NewsList()));
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.list,color: Color(0xFFE93314)), // Replace with your icon
          //   title: const Text('events',
          //       style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xFFE93314))),
          //   onTap: () {
          //     // Handle list item 3 tap
          //     Navigator.push(
          //         context, MaterialPageRoute(builder: (context) => Events(back: true,)));
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.list,color: Colors.white), // Replace with your icon
            title: const Text('About us',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Colors.white)),
            onTap: () {
              // Handle list item 4 tap
               Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewExample(loadUrl: aboutUsURL!,)));
            },
          ),
           ListTile(
            leading: const Icon(Icons.list,color: Colors.white), // Replace with your icon
            title: const Text('Contact us',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Colors.white)),
            onTap: () {
              // Handle list item 4 tap
              // print('test');
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ContactUs()));
              //  Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewExample(loadUrl: contactUsURL!,)));
          
            },
          ),
            ListTile(
            leading: const Icon(Icons.list,color: Colors.white), // Replace with your icon
            title: const Text('Directory',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Colors.white)),
            onTap: () {
              // Handle list item 4 tap
              //  Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewExample(loadUrl: 'https://www.thedipaar.com/about1.php#bypass-sw',)));
            },
          ),
            ListTile(
            leading: const Icon(Icons.list,color:Colors.white), // Replace with your icon
            title: const Text('News bits',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Colors.white)),
            onTap: () {
              // Handle list item 4 tap
              //  Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewExample(loadUrl: 'https://www.thedipaar.com/about1.php#bypass-sw',)));
            },
          ),
            ListTile(
            leading: const Icon(Icons.list,color: Colors.white), // Replace with your icon
            title: const Text('TV',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Colors.white)),
            onTap: () {
              // Handle list item 4 tap
               Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewExample(loadUrl: 'http://thedipar.com/tv/',)));
            },
          ),
            ListTile(
            leading: const Icon(Icons.list,color: Colors.white), // Replace with your icon
            title: const Text('E-Book',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Colors.white)),
            onTap: () {
              // Handle list item 4 tap
               Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewExample(loadUrl: 'https://ebook.thedipaar.ca/',)));
             
            },
          ),
            ListTile(
            leading: const Icon(Icons.list,color: Colors.white), // Replace with your icon
            title: const Text('FM',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Colors.white)),
            onTap: () {
              // Handle list item 4 tap
               Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewExample(loadUrl: 'https://zeno.fm/radio/thedipaar/',)));
             
            },
          ),
        ],
      ),
    );
  }
}

