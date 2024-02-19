import 'package:flutter/material.dart';
import 'package:thedipaar/constants/imageConstants.dart';
import 'package:thedipaar/modal/NewsDetailModal.dart';
import 'package:thedipaar/service/web_service.dart';
import 'package:thedipaar/utils/carousalBannerView.dart';
import 'package:thedipaar/utils/dateChangeUtils.dart';
import 'package:thedipaar/utils/loaderUtils.dart';
import 'package:thedipaar/utils/shareUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animations/animations.dart';


class NewsDetail extends StatefulWidget {
  final String? id;
  final String? img;
  const NewsDetail({super.key, this.id, this.img});

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  Future<News>? _newsFuture;
  String? newsId; // Replace with your last ID
  News? _news;
  DateTime? providedDateTime;
  String? timeAgo;
  bool isLoading = false;
  String? shareBaseURL;

  @override
  void initState() {
    super.initState();
      
   
    setState(() {
      newsId = widget.id!;
      
    });
    _getConfig();
    _fetchNews();
  }

  void _getConfig()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
       shareBaseURL = prefs.getString('share_baseurl');
    });
  }

  Future<void> _fetchNews() async {
    setState(() {
      isLoading = true;
    });
    try {
      final news = await webservice.fetchNews(widget.id!);
      setState(() {
        _news = news;
        providedDateTime = DateTime.parse(news.createdDate.toString());

        timeAgo = DateDayConverter.getTimeDifference(providedDateTime!);

        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle error
      print('Error: $e');
    }
  }

Future<void> _fetchNewsByDirection(String direction) async {
  String newId = newsId!;
  if (direction == 'next') {
    int initialIntID = int.tryParse(newsId!) ?? 0;
    initialIntID++;
    newId = initialIntID.toString();
  } else if (direction == 'previous') {
    int initialIntID = int.tryParse(newsId!) ?? 0;
    initialIntID--;
    newId = initialIntID.toString();
  }

  setState(() {
    newsId = newId;
  });

  try {
    final news = await webservice.fetchNews(newId);
   
    setState(() {
      _news = news;
      providedDateTime = DateTime.parse(news.createdDate.toString());
      timeAgo = DateDayConverter.getTimeDifference(providedDateTime!);
    });
  
  } catch (e) {
    // Handle error
    print('Error: $e');
  }
}

Future<void> _fetchNextNews() async {
  await _fetchNewsByDirection('next');
}

Future<void> _fetchPreviousNews() async {
  await _fetchNewsByDirection('previous');
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
         appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: SizedBox(
          height: 50,
          width: 150,
          child: Image.asset(AppImages.app_logo),
        ),
      ),
      body: _news != null
          ? _newsContent()
          : const Center(
              child: CommonLoader(),
            ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              backgroundColor:const Color(0xFFE93314) ,
              onPressed: () {
                _fetchPreviousNews();
              },
              child: const Icon(Icons.arrow_back,color: Colors.white,),
            ),
            // SizedBox(width: 16),
            FloatingActionButton(
               backgroundColor:const Color(0xFFE93314) ,
              onPressed: () {
                _fetchNextNews();
              },
              child: const Icon(Icons.arrow_forward,color: Colors.white,),
            ),
          ],
        ),
      ),
    );
  }

  Widget _newsContent() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: SponsorView(),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.33,
                width: MediaQuery.of(context).size.width,
                child: Image.network("http://52.77.122.228/uploads/news/${_news!.img}", fit: BoxFit.cover),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.symmetric(horizontal: 14),
                    child: Container(
                      // alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      height: 30,
                      // width: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE93314),
                        borderRadius: BorderRadius.circular(
                            20), // Adjust the radius as needed
                      ),
                      child: Text(
                        _news!.catName,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.timelapse_outlined,
                        color: Color(0xFFE93314),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        '${timeAgo!}',
                        style:
                            const TextStyle(color: Color(0xFFE93314), fontSize: 18),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                ),
                child: Text(
                  _news!.title,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: SizedBox(
                  child: Text(_news!.description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFFAAAAAA),
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
            ],
          ),
        ),
        // Positioned(
        //   top: 40,
        //   left: 20,
        //   child: GestureDetector(
        //     onTap: () {
        //       Navigator.of(context).pop(); // Add navigation logic here
        //     },
        //     child: const Icon(
        //       Icons.arrow_back,
        //       color: Colors.white,
        //       size: 30,
        //     ),
        //   ),
        // ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.42,
          right: 30,
          child: GestureDetector(
            onTap: () async {
              // Add share functionality here
              await ShareUtils.share(
                _news!.title,
                "http://52.77.122.228/uploads/news/${_news!.img}","${shareBaseURL}${widget.id}"
              );
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFE93314),
                borderRadius:
                    BorderRadius.circular(20), // Adjust the radius as needed
              ),
              child: const Icon(
                Icons.share,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
