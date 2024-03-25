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
import 'package:thedipaar/utils/shareUtils.dart';
import 'package:thedipaar/utils/sideDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  int currentPage = 1;
  int totalPages = 1;
  ScrollController scrollController = ScrollController();
  String? shareBaseURL;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchNewsList(currentPage);
    _getconfig();
  }

  _getconfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      shareBaseURL = prefs.getString('share_baseurl');
    });
  }

  Future<List<NewsListModal>> fetchNewsListAll(int page) async {
    final response = await http.get(
      Uri.parse("https://thedipaar.com/api/frontend/news/all?page=$page"),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> dataList = jsonData['data']['posts'];
      final pagerData = jsonData['data']['pager'];
      totalPages = pagerData['pageCount'];

      List<NewsListModal> newsList =
          dataList.map((item) => NewsListModal.fromJson(item)).toList();
      newsList.sort((a, b) => DateTime.parse(b.created_date)
          .compareTo(DateTime.parse(a.created_date)));
      return newsList;
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<void> _fetchNewsList(int page) async {
    setState(() {
      isLoading = true;
    });
    try {
      final news = await fetchNewsListAll(page);

      setState(() {
        _newsList.addAll(news); // Append new news to the list
        isLoading = false;
      });
    } catch (e) {
      print("Exception occurs while fetching news: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _loadMoreData() async {
    if (!isLoading && currentPage < totalPages) {
      currentPage++; // Increment page number
      await _fetchNewsList(currentPage); // Fetch news for the next page
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
            child: const Align(
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
      // title: 'Exit',
      desc: 'Are you sure you want to exit?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        SystemNavigator.pop(); // Close the app
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
            const SnackBar(
              content: Text('Press back again to exit'),
              duration: Duration(seconds: 1),
            ),
          );
          Future.delayed(const Duration(seconds: 2), () {
            _backButtonPressedCount = 0;
          });
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(),
        // floatingActionButton: CircularMenuFAB(),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  const SizedBox(height: 125, child: SponsorView()),
                  const SizedBox(
                    height: 12,
                  ),
                  Visibility(
                    visible: !isLoading,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Latest news',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index < _newsList.length) {
                        return NewsItem(
                          id: _newsList[index].id,
                          img: _newsList[index].img,
                          cat_name: _newsList[index].cat_name,
                          title: _newsList[index].title,
                          created_date: _newsList[index].created_date,
                          shorts: _newsList[index].shorts,
                          onShare: () async {
                            // Add share functionality here
                            await ShareUtils.share(
                                _newsList[index].title,
                                "http://thedipaar.com/uploads/news/${_newsList[index].img}",
                                "${shareBaseURL}${_newsList[index].id}");
                          },
                        );
                      } else if (index == _newsList.length && isLoading) {
                        return const SizedBox(
                          height: 50.0,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (index == _newsList.length &&
                          !isLoading &&
                          currentPage < totalPages) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: InkWell(
                            onTap: _loadMoreData,
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFE93314),
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Center(
                                child: Text(
                                  'Load More',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox(); // Return an empty SizedBox for separator
                      }
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox();
                    },
                    itemCount:
                        _newsList.length + 1, // +1 for the "Load More" button
                  ),
                ],
              ),
            )
          ],
        ),

        // body: SingleChildScrollView(
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 16),
        //     child: Column(
        //       children: [
        //         const SizedBox(height: 125, child: SponsorView()),
        //         const SizedBox(
        //           height: 12,
        //         ),
        //         Column(
        //           children: [
        // const Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 16.0),
        //   child: Align(
        //     alignment: Alignment.centerLeft,
        //     child: Text(
        //       'Latest news',
        //       style: TextStyle(
        //           fontSize: 18, fontWeight: FontWeight.bold),
        //     ),
        //   ),
        // ),
        //             SizedBox(
        //               // color: Colors.amber,
        //               height: 600,
        //               child: ListView.separated(

        //                 shrinkWrap: true,
        //                 // physics: const NeverScrollableScrollPhysics(),
        //                 itemBuilder: (context, index) {
        //                   if (index < _newsList.length) {
        //                     return NewsItem(
        //                       id: _newsList[index].id,
        //                       img: _newsList[index].img,
        //                       cat_name: _newsList[index].cat_name,
        //                       title: _newsList[index].title,
        //                       created_date: _newsList[index].created_date,
        //                       shorts: _newsList[index].shorts,     onShare: () async {
        //   // Add share functionality here
        //   await ShareUtils.share(
        //       _newsList[index].title,
        //       "http://thedipaar.com/uploads/news/${_newsList[index].img}",
        //       "${shareBaseURL}${_newsList[index].id}");
        // },
        //                     );
        //                   } else if (index == _newsList.length && isLoading) {
        //                     return const SizedBox(
        //                       height: 50.0,
        //                       child: Center(
        //                         child: CircularProgressIndicator(),
        //                       ),
        //                     );
        //                   } else if (index == _newsList.length &&
        //                       !isLoading &&
        //                       currentPage < totalPages) {
        //                     return Padding(
        //                       padding: const EdgeInsets.symmetric(horizontal: 40),
        //                       child: InkWell(
        //                         onTap: _loadMoreData,
        //                         child: Container(
        //                           height: 60,
        //                           decoration: BoxDecoration(
        //                               color: const Color(0xFFE93314),
        //                               borderRadius: BorderRadius.circular(8)),
        //                           child: const Center(
        //                             child: Text(
        //                               'Load More',
        //                               style: TextStyle(
        //                                   color: Colors.white, fontSize: 18),
        //                             ),
        //                           ),
        //                         ),
        //                       ),
        //                     );
        //                   } else {
        //                     return const SizedBox(); // Return an empty SizedBox for separator
        //                   }
        //                 },
        //                 separatorBuilder: (context, index) {
        //                   return SizedBox();

        //                 },
        //                 itemCount:
        //                     _newsList.length + 1, // +1 for the "Load More" button
        //               ),
        //             ),
        //           ],
        //         ),
        //       ],
        //     ),
        //   ),
        // ),

        // body: !isLoading
        //     ? SizedBox(
        //       // height: MediaQuery.of(context).size.height * 0.5,
        //       child: Column(
        //               children: [
        //                 Expanded(
        //       child: Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 18),
        //         child: ListView(
        //            shrinkWrap: true,

        //           children: [
        //             const SizedBox(height: 10), // Add space at the top
        //             const SponsorView(), // Display SponsorView first
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //   child: Text(
        //     'Latest news',
        //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        //   ),
        // ),
        //             const SizedBox(height: 10),
        //             ListView.builder(
        //               shrinkWrap: true,
        //               physics: const NeverScrollableScrollPhysics(),
        //               itemCount: _newsList.length,
        // itemBuilder: (context, index) {
        //   return NewsItem(
        //     id: _newsList[index].id,
        //     img: _newsList[index].img,
        //     cat_name: _newsList[index].cat_name,
        //     title: _newsList[index].title,
        //     created_date: _newsList[index].created_date,
        //     shorts: _newsList[index].shorts,
        //   );
        // },
        //             ),
        // const SizedBox(height: 20),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //   child: Text(
        //     'Sponsors',
        //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        //   ),
        // ),
        // const SizedBox(height: 10),
        // const BannerView(), // Display BannerView at the bottom
        // const SizedBox(height: 10), // Add space at the bottom
        //           ],
        //         ),
        //       ),
        //                 ),
        //               ],
        //             ),
        //     )
        // : const Center(
        //     child: CommonLoader(),
        //   ),

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
