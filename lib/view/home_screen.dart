import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thedipaar/modal/newsCategoryModal.dart';
import 'package:thedipaar/modal/newsListModal.dart';
import 'package:thedipaar/service/web_service.dart';
import 'package:thedipaar/utils/appBarUtils.dart';
import 'package:thedipaar/utils/carousalBanner.dart';
import 'package:thedipaar/utils/carousalBannerView.dart';
import 'package:thedipaar/utils/customAd.dart';
import 'package:thedipaar/utils/floatingActionUtils.dart';
import 'package:thedipaar/utils/loaderUtils.dart';
import 'package:thedipaar/utils/newsItemContainer.dart';
import 'package:thedipaar/utils/sideDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {

  

  int currentTabIndex = 0;

  List<NewsListModal> _newsList = [];
  List<NewsCategory> _newsCategory = [];



  bool isLoading = false;

  int _selectedTabIndex = 0;
  int switcherIndex3 = 0;

  int _adCount = 0;
  bool _adShown = false;

  int _backButtonPressedCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchNewsList("Cinema");
   
  }


  Future<void> _fetchNewsList(String name) async {
    setState(() {
      isLoading = true;
    });
    try {
      final news = await webservice.fetchNewsList(name,true);
    

      setState(() {
        _newsList = news;
        isLoading = false;
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
    if (!adPreviouslyShown) {
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

    void _showExitConfirmationDialog() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      headerAnimationLoop: true,
            borderSide: const BorderSide(
        color: Color(0xFFE93314),
        width: 2,
      ),
      width: 400,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(2),
      ),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      animType: AnimType.topSlide,
      showCloseIcon: true,
      titleTextStyle: GoogleFonts.roboto(),
      title: 'Exit',
      desc: 'Are you sure you want to exit?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
       SystemNavigator.pop();// Close the app
      },
    ).show();
  }




  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
            onWillPop: () async {
        if (_backButtonPressedCount == 1) {
          _showExitConfirmationDialog();
          return false;
        } else {
          _backButtonPressedCount++;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Press back again to exit'),
              duration: Duration(seconds: 1),
            ),
          );
          Future.delayed(Duration(seconds: 2), () {
            _backButtonPressedCount = 0;
          });
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(),
                   floatingActionButton: CircularMenuFAB(),

        body: !isLoading
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ListView(
                  children: [
                    const SponsorView(),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Latest news',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _newsList.length,
                          itemBuilder: (context, index) {
                            return NewsItem(
                              id: _newsList[index].id,
                              img: _newsList[index].img,
                              cat_name: _newsList[index].cat_name,
                              title: _newsList[index].title,
                              created_date: _newsList[index].created_date,
                              shorts: _newsList[index].shorts,
                            );
                          },
                        ),
                      ],
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Sponsers',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const BannerView(),
                  ],
                ),
              )
            : const Center(
                child: CommonLoader(),
              ),
      
        drawer: MyDrawer(),
        // floatingActionButton: CircularMenuFAB(),
      ),
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
