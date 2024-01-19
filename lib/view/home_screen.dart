import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:thedipaar/modal/newsCategoryModal.dart';
import 'package:thedipaar/modal/newsListModal.dart';
import 'package:thedipaar/service/web_service.dart';
import 'package:thedipaar/utils/appBarUtils.dart';
import 'package:thedipaar/utils/carousalBanner.dart';
import 'package:thedipaar/utils/carousalBannerView.dart';
import 'package:thedipaar/utils/customAd.dart';
import 'package:thedipaar/utils/newsItemContainer.dart';
import 'package:thedipaar/utils/sideDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  // ScrollController _scrollController1 = ScrollController();
  ScrollController _scrollController2 = ScrollController();

  int _selectedTab = 2;
  TabController? _tabController;

  int currentTabIndex = 0;

  // NewsListModal? _newsList;
  List<NewsListModal> _newsList = [];
  List<NewsCategory> _newsCategory = [];

  //  bool _isLoaded = false;
  // InterstitialAd? interstitialAd;
  // int counter = 0;

  bool isLoading = false;

  int _selectedTabIndex = 0;
  int switcherIndex3 = 0;
 
  int _adCount = 0;
bool _adShown = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchNewsList("Cinema");
    // requestNotificationPermission();
    // _fetchNewsList("Canada");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // showCustomAdPopup(context);
      // double minScrollExtent1 = _scrollController1.position.minScrollExtent;
      // double maxScrollExtent1 = _scrollController1.position.maxScrollExtent;
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

  Future<void> requestNotificationPermission() async {
    print('entering into getting the request===>');
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  // String? token = await messaging.getToken();
  // print('Token: $token');
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  print('message permission====>${settings.authorizationStatus}');
  print('User granted permission: ${settings.authorizationStatus}');
  final notificationSettings = await FirebaseMessaging.instance.requestPermission(provisional: true);
  final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
if (apnsToken != null) {
 // APNS token is available, make FCM plugin API requests...
}
}

  Future<void> _fetchNewsList(String name) async {
    setState(() {
      isLoading = true;
    });
    try {
      final news = await webservice.fetchNewsList(name);
    
      setState(() {
        _newsList = news;
      });
    } catch (e) {
      print("Exception occurs while fetching news: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }



 

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  if (!_adShown) {
    _adCount++;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showCustomAdPopup(context);
    });
  }
}

  void showCustomAdPopup(BuildContext context) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
  bool adPreviouslyShown = prefs.getBool('adShown') ?? false;
  if (!adPreviouslyShown){
     // ignore: use_build_context_synchronously
     await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // ignore: deprecated_member_use
        return WillPopScope(
          onWillPop: () async => false,
          child: Align(
            alignment: Alignment.topRight,
            child: CustomAdPopup(),
          ),
        );
      },
    );
        prefs.setBool('adShown', true);
    _adShown = true;
  }
   

  }

  @override
  Widget build(BuildContext context) {
    int currentTabIndex = 0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: ListView(
          children: [
            const SponsorView(),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Latest news',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10,),
            SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _newsList.length,
                  itemBuilder: (context, index) {
                    return NewsItem(
                      id: _newsList[index].id,
                      img: _newsList[index].img,
                      cat_name: _newsList[index].cat_name,
                      title: _newsList[index].title,
                      created_date: _newsList[index].created_date, shorts: _newsList[index].shorts,
                    );
                  },
                ),
              ],
            )),
              //          const SizedBox(
              //   height: 10,
              // ),
              // const Align(
              //   alignment: Alignment.centerLeft,
              //   child: Text(
              //     'Products',
              //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              //   ),
              // ),
              //               SizedBox(
              //   height: 130,
              //   child: Sponsers(
              //     scrollController: _scrollController2,
              //     items: true,
              //   ),
              // ),
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

      drawer: MyDrawer(),
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
