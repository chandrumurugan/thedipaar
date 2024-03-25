import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thedipaar/constants/imageConstants.dart';
import 'package:thedipaar/modal/eventDetailModal.dart';
import 'package:thedipaar/service/web_service.dart';
import 'package:thedipaar/utils/loaderUtils.dart';
import 'package:thedipaar/utils/shareUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

class EventsDetailScreen extends StatefulWidget {
  final String? id;
  final String? map;
  const EventsDetailScreen({super.key, this.id, this.map});

  @override
  State<EventsDetailScreen> createState() => _EventsDetailScreenState();
}

class _EventsDetailScreenState extends State<EventsDetailScreen> {
  bool isLoading = false;
  EventDetails? _eventsDetail;
  String formattedDate = '';
  String? shareBaseURL;
  String? formattedendDate;
  String? formattedstartDate;
  int currentIndex = 0;
  bool showPreview = false;
  String? eventId;
    WebViewController? controller;
  bool showActionButton = true;

  @override
  void initState() {
    super.initState();
    debugPrint("====?${widget.id}");


    setState(() {
      eventId = widget.id!;
    });
    _fetchNews(widget.id!);
    _getconfig();
  }

  _getconfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      shareBaseURL = prefs.getString('share_baseurl');
    });
   
  }

  Future<void> _fetchNews(String eventId) async {
    setState(() {
      isLoading = true;
    });
    try {
      EventDetails news = await webservice.fetchEventsDetail(eventId);
      setState(() {
        _eventsDetail = news;

        isLoading = false;
            controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.dataFromString('''<html>

            <iframe src="${_eventsDetail!.gmap}" 
            style="width:100%; height:100%;" frameborder="0"></iframe>
           
            </html>''', mimeType: 'text/html'),
      );
        DateTime start1Date =
            DateTime.parse(_eventsDetail!.startDate.toString());

        formattedstartDate = DateFormat('dd-MM-yyyy').format(start1Date);
        DateTime end1Date = DateTime.parse(_eventsDetail!.endDate.toString());

        formattedendDate = DateFormat('dd-MM-yyyy').format(end1Date);
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle error
      print('Error: $e');
    }
  }

  final List<String> imageUrls = [
    'https://picsum.photos/200/300.jpg',
    'https://picsum.photos/200/301.jpg',
    'https://picsum.photos/200/302.jpg',
    'https://picsum.photos/200/303.jpg',
    'https://picsum.photos/200/304.jpg',
    // Add more image URLs as needed
  ];

  Widget buildIndicator(int index) {
    return Container(
      width: 8.0,
      height: 8.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFE93314)
            .withOpacity(index == currentIndex ? 1.0 : 0.2),
      ),
    );
  }

  Future<void> _fetchNewsByDirection(String direction) async {
    String newId = eventId!;
    if (direction == 'next' && _eventsDetail!.next != null) {

      newId = _eventsDetail!.next!.id;
    } else if (direction == 'previous' && _eventsDetail!.previous != null) {

       newId = _eventsDetail!.previous!.id;
    }

    setState(() {
      eventId = newId;
    });
    _fetchNews(newId);
  }

  Future<void> _fetchNextNews() async {
    await _fetchNewsByDirection('next');
  }

  Future<void> _fetchPreviousNews() async {
    await _fetchNewsByDirection('previous');
  }

  @override
  Widget build(BuildContext context) {
    var submitTextStyle = TextStyle(
        fontSize: 12,
        // letterSpacing: 5,
        color: Colors.white,
        fontWeight: FontWeight.bold);
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
      body: isLoading
          ? const CommonLoader()
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _eventsDetail!.gallery.isEmpty ?
                      SizedBox(
                        // color: Colors.amber,
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width,
                        child: CachedNetworkImage(imageUrl:"http://thedipaar.com/uploads/events/${_eventsDetail!.heroImage}" ,
                        fit: BoxFit.fill,
                        placeholder: (context, url) =>
                    CircularProgressIndicator(color: const Color(0xFFE93314),),
                                    errorWidget: (context, url, error) => Image.network(
                  'https://www.shutterstock.com/image-photo/concept-image-business-acronym-eod-260nw-332349266.jpg',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                ), 


                        ),
                        // child: Image.network(
                        
                        //   "http://thedipaar.com/uploads/events/${_eventsDetail!.heroImage}",
                        //   fit: BoxFit.fill,
                          // errorBuilder: (BuildContext context, Object exception,
                          //     StackTrace? stackTrace) {
                        //     // Return a default image or placeholder widget when an error occurs
                        //     return Image.network(
                        //       'https://www.shutterstock.com/image-photo/concept-image-business-acronym-eod-260nw-332349266.jpg',
                        //       width: MediaQuery.of(context).size.width,
                        //       fit: BoxFit.fill,
                        //     );
                        //   },
                        // ),
                      ):
                      CarouselSlider.builder(
                        itemCount: _eventsDetail!.gallery.length,
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.25,
                            width: MediaQuery.of(context).size.width,
                             child: CachedNetworkImage(imageUrl:"https://thedipaar.com/uploads/event-gallery/${_eventsDetail!.gallery[index]}" ,
                        fit: BoxFit.fill,
                        placeholder: (context, url) =>
                    CircularProgressIndicator(color: const Color(0xFFE93314),),
                                    errorWidget: (context, url, error) => Image.network(
                  'https://www.shutterstock.com/image-photo/concept-image-business-acronym-eod-260nw-332349266.jpg',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                ), 


                        ),

                            // child: Image.network(
                            //   "https://torontotamilshop.com/uploads/event-gallery/${_eventsDetail!.gallery[index]}",
                            //   fit: BoxFit.fill,
                            //   errorBuilder: (BuildContext context,
                            //       Object exception, StackTrace? stackTrace) {
                            //     return Image.network(
                            //       'https://www.shutterstock.com/image-photo/concept-image-business-acronym-eod-260nw-332349266.jpg',
                            //       width: MediaQuery.of(context).size.width,
                            //       fit: BoxFit.fill,
                            //     );
                            //   },
                            // ),
                          );
                        },
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height * 0.25,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1.0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.easeInOutBack,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      if(_eventsDetail!.gallery.isNotEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          imageUrls.length,
                          (index) => buildIndicator(index),
                        ),
                      ),
                       if(_eventsDetail!.gallery.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: AnimatedButton(
                            animatedOn: AnimatedOn.onTap,
                            borderRadius: 10,
                            onPress: () {_showImagePreviewDialog(0);
                            
                            setState(() {
                              showActionButton = false;
                            });
                            } ,
                            // onChanges: (change) {},
                            height: 40,
                            width: 100,
                            text: 'View Gallery',
                            isReverse: true,
                            selectedTextColor: Colors.white,
                            transitionType: TransitionType.RIGHT_TOP_ROUNDER,
                            textStyle: submitTextStyle,
                            backgroundColor: Color(0xFFE93314),
                            selectedBackgroundColor: Color(0xff23527C),
                            borderColor: Colors.white,
                            borderWidth: 1,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _eventsDetail!.heading, //_eventsDetail!.heading
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      // const SizedBox(
                      //   height: 20,
                      // ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  color: Color(0xFFE93314),
                                  size: 18,
                                ), // Start date icon
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                    'Start Date : ${formattedstartDate!}', //formattedstartDate
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight
                                            .normal)), // Start date text
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  color: Color(0xFFE93314),
                                  size: 18,
                                ), // End date icon
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                    'End Date : ${formattedendDate}', //formattedendDate
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight
                                            .normal)), // End date text
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (_eventsDetail!.venue != "")
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment
                                        .topCenter, // Adjust the alignment as needed
                                    child: const Column(
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Icon(
                                          Icons.place_rounded,
                                          color: Color(0xFFE93314),
                                          size: 18,
                                        ),
                                      ],
                                    ), // End date icon
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),

                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.88,
                                    child: Text(
                                      _eventsDetail!.venue,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ), // End date text
                                ],
                              ),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(
                            //     horizontal: 12,
                            //   ),
                            //   child: Container(
                            //     width: MediaQuery.sizeOf(context).width,
                            //     height: 100,
                            //     // decoration: BoxDecoration(
                            //     //   border: Border.all(
                            //     //     color: Color(
                            //     //         0xFFE93314), // You can change the border color
                            //     //     width: 1.0, // You can change the border width
                            //     //   ),
                            //     //   borderRadius: BorderRadius.circular(12.0),
                            //     // ),
                            //     child: Image.network(
                            //       "https://maps.googleapis.com/maps/api/staticmap?center=51.477222,0&zoom=14&size=400x400&key=AIzaSyA3kg7YWugGl1lTXmAmaBGPNhDW9pEh5bo&signature=ciftxSv4681tGSAnes7ktLrVI3g=",
                            //       // height: 100.0,
                            //       // width: 100.0,
                            //       fit: BoxFit.fill,
                            //     ),
                            //   ),
                            // ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 200, // Set the desired height
                                child: WebViewWidget(
                                  controller: controller!,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment
                                      .topCenter, // Adjust the alignment as needed
                                  child: const Column(
                                    children: [
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Icon(
                                        Icons.comment,
                                        color: Color(0xFFE93314),
                                        size: 18,
                                      ),
                                    ],
                                  ), // End date icon
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.88,
                                  child: Text(
                                    "Discription : ${_eventsDetail!.content}", //_eventsDetail!.content
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    // maxLines: 2,
                                  ),
                                ), // End date text
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.18,
                  right: 30,
                  child: GestureDetector(
                    onTap: () async {
                      // Add share functionality here
                      await ShareUtils.share(
                          _eventsDetail!.heading,
                         "http://thedipaar.com/uploads/events/${_eventsDetail!.heroImage}",
                          "https://thedipaar.com/detailevents/${widget.id}");
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE93314),
                        borderRadius: BorderRadius.circular(
                            20), // Adjust the radius as needed
                      ),
                      child: const Icon(
                        Icons.share,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                if (showPreview)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.8),
                      child: PhotoViewGallery.builder(
                        itemCount: _eventsDetail!.gallery.length,
                        builder: (context, index) {
                          return PhotoViewGalleryPageOptions(
                            imageProvider: NetworkImage("http://thedipaar.com/uploads/events/${_eventsDetail!.gallery[index]}"),
                            minScale: PhotoViewComputedScale.contained,
                            maxScale: PhotoViewComputedScale.covered * 2,
                            heroAttributes: PhotoViewHeroAttributes(tag: index),
                          );
                        },
                        backgroundDecoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        pageController:
                            PageController(initialPage: currentIndex),
                        onPageChanged: (index) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                      ),
                    ),
                  ),
                if (showPreview)
                  Positioned(
                    bottom: 30, // Adjust the bottom position as needed
                    left: MediaQuery.of(context).size.width *
                        0.45, // Adjust the left position as needed
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showPreview = false;
                          showActionButton = true;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE93314),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Close',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
        
        child: showActionButton ?  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if(_eventsDetail != null && _eventsDetail!.previous != null) ...[
                               FloatingActionButton(
              backgroundColor: const Color(0xFFE93314),
              onPressed: () {
                _fetchPreviousNews();
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            ],
              if (_eventsDetail != null && _eventsDetail!.next != null && _eventsDetail!.previous != null) ...[
            const SizedBox(width: 16), // Add spacing between buttons
          ],
                    if (_eventsDetail != null && _eventsDetail!.next != null) ...[
              FloatingActionButton(
              backgroundColor: const Color(0xFFE93314),
              onPressed: () {
                _fetchNextNews();
              },
              child: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
          ],
          ],
        ) : SizedBox(),
      ),
    );
  }

  void _showImagePreviewDialog(int initialIndex) {
    setState(() {
      currentIndex = initialIndex;
      showPreview = true;
    });
  }
}
