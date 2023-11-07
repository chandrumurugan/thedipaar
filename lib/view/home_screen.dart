import 'package:flutter/material.dart';
// import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:thedipaar/constants/imageConstants.dart';
import 'package:thedipaar/utils/carousalBanner.dart';
import 'package:thedipaar/utils/newsItemContainer.dart';
import 'package:thedipaar/utils/sponserCarousal.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:scrollable_list_tab_scroller/scrollable_list_tab_scroller.dart';
import 'package:thedipaar/view/category_screen.dart';
import 'package:thedipaar/view/news_screen.dart';
import 'package:thedipaar/view/search_screen.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  ScrollController _scrollController1 = ScrollController();
  ScrollController _scrollController2 = ScrollController();

  int _selectedTab = 2;
  TabController? _tabController;

  int currentTabIndex = 0;

   final data = {
    "All": [
      "Item 1 (A)",
      "Item 2 (A)",
      "Item 3 (A)",
      "Item 4 (A)",
    ],
    "World": [
      "Item 1 (B)",
      "Item 2 (B)",
    ],
    "Technology": [
      "Item 1 (C)",
      "Item 2 (C)",
      "Item 3 (C)",
      "Item 4 (C)",
      "Item 5 (C)",
    ],
    "Business": [
      "Item 1 (D)",
      "Item 2 (D)",
      "Item 3 (D)",
      "Item 4 (D)",
      "Item 5 (D)",
      "Item 6 (D)",
      "Item 7 (D)",
      "Item 8 (D)",
      "Item 9 (D)",
    ],
    "Sports": [
      "Item 1 (E)",
      "Item 2 (E)",
      "Item 3 (E)",
      "Item 4 (E)",
      "Item 5 (E)",
      "Item 6 (E)",
      "Item 7 (E)",
      "Item 8 (E)",
      "Item 9 (E)",
    ],
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      double minScrollExtent1 = _scrollController1.position.minScrollExtent;
      double maxScrollExtent1 = _scrollController1.position.maxScrollExtent;
       double minScrollExtent2 = _scrollController2.position.minScrollExtent;
      double maxScrollExtent2 = _scrollController2.position.maxScrollExtent;

      //
      // animateToMaxMin(maxScrollExtent1, minScrollExtent1, maxScrollExtent1, 30,
      //     _scrollController1);
      //     animateToMaxMin(maxScrollExtent2, minScrollExtent2, maxScrollExtent2, 30,
      //     _scrollController2);
    });
    _tabController = TabController(length: 5, vsync: this);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Color(0xFFE93314),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: SizedBox(
            height: 50, width: 150, child: Image.asset(AppImages.app_logo)),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFFE93314)),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Search()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Color(0xFFE93314)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Sponsers(
                  scrollController: _scrollController1,
                   items: false,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Latest news',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
  SizedBox(
            height: 500,
            child: ScrollableListTabScroller(
              itemCount: data.length,
              tabBuilder: (BuildContext context, int index, bool active) {
                final tabName = data.keys.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    tabName,
                    style: active && index == currentTabIndex
                        ? const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFE93314))
                        : null,
                  ),
                );
              },
              itemBuilder: (BuildContext context, int index) => NewsItem(),
              tabChanged: (int newIndex) {
                setState(() {
                  currentTabIndex = newIndex;
                });
              },
            ),
          ),    

          // SizedBox(
          //   height: 500,
          //   child: ScrollableListTabScroller(
          //         itemCount: data.length,
          //         tabBuilder: (BuildContext context, int index, bool active) => Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10),
          //   child: Text(
          //     data.keys.elementAt(index),
          //     style: !active
          //         ? null
          //         : const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFE93314)),
          //   ),
          //         ),
          //         itemBuilder: (BuildContext context, int index) => NewsItem()
          
          //       ),
          // ),
                // SizedBox(
                //   height: 500,
                //   child: ListView.separated(
                //       itemBuilder: (context, index) => NewsItem(),
                //       separatorBuilder: (context, index) => SizedBox(
                //             height: 10,
                //           ),
                //       itemCount: 3),
                // ),
                const SizedBox(
                  height: 10,
                ),
                 const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Products',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              
                 SizedBox(
                  height: 130,
                   child: Sponsers(
                    scrollController: _scrollController2,
                    items: true,
                                 ),
                 ),
                const SizedBox(
                  height: 20,
                ),
                 const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sponsers',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                  const BannerView(),
              ],
            ),
          ),
        ),
      ),
      drawer:MyDrawer(),
      // floatingActionButton: CircularMenuFAB(),
    );
  }


}

class Category {
  final int id;
  final String title;

  Category({
    required this.id,
    required this.title,
  });
}



class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // UserAccountsDrawerHeader(
          //   accountName: Text('Your Name'),
          //   accountEmail: Text('Your Subtitle'),
          //   currentAccountPicture: CircleAvatar(
          //     backgroundImage: AssetImage('your_image.jpg'), // Replace with your image path
          //   ),
          // ),
          const SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                CircleAvatar(radius: 30,backgroundColor: Colors.grey[600],),const SizedBox(width: 10,),const Text('NAME',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w900),)
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.list), // Replace with your icon
            title: const Text('Home',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
            onTap: () {
              // Handle list item 1 tap
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.list), // Replace with your icon
            title: const Text('News',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
            onTap: () {
              // Handle list item 2 tap
              Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsList()));
              
            },
          ),
          ListTile(
            leading: const Icon(Icons.list), // Replace with your icon
            title: const Text('events',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
            onTap: () {
              // Handle list item 3 tap
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>Events()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.list), // Replace with your icon
            title: const Text('About us',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
            onTap: () {
              // Handle list item 4 tap
            },
          ),
        ],
      ),
    );
  }
}
