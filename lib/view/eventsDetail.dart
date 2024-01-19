import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thedipaar/constants/imageConstants.dart';
import 'package:thedipaar/modal/eventDetailModal.dart';
import 'package:thedipaar/service/web_service.dart';
import 'package:thedipaar/utils/loaderUtils.dart';
import 'package:thedipaar/utils/shareUtils.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventsDetailScreen extends StatefulWidget {
  final String id;
  const EventsDetailScreen({super.key, required this.id});

  @override
  State<EventsDetailScreen> createState() => _EventsDetailScreenState();
}

class _EventsDetailScreenState extends State<EventsDetailScreen> {


bool isLoading = false;
 EventsDetails? _eventsDetail ;
  String formattedDate = '';
   String? shareBaseURL;
   String?  formattedendDate ;
   String?  formattedstartDate;

   @override
  void initState() {
    super.initState();
    print('id====>' + widget.id!);

   
    // setState(() {
    //   newsId = widget.id!;
    // });
    _fetchNews();
    _getconfig();
  }
   _getconfig()async{
  SharedPreferences prefs = await  SharedPreferences.getInstance();
    setState(() {
         shareBaseURL = prefs.getString('share_baseurl');
    });
  }

  Future<void> _fetchNews() async {
    setState(() {
      isLoading = true;
    });
    try {
      EventsDetails news = await webservice.fetchEventsDetail(widget.id);
      setState(() {
        _eventsDetail = news;


        isLoading = false;
            DateTime start1Date = DateTime.parse(_eventsDetail!.start_date);

   
   formattedstartDate = DateFormat('MM-dd-yyyy').format(start1Date);
              DateTime end1Date = DateTime.parse(_eventsDetail!.start_date);

   
   formattedendDate = DateFormat('MM-dd-yyyy').format(end1Date);
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle error
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: SizedBox(
          height: 50,
          width: 150,
          child: Image.asset(AppImages.app_logo),
        ),
      ),
      body:isLoading ? CommonLoader():
      
       Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  // color: Colors.amber,
                  height: MediaQuery.of(context).size.height * 0.36,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    "http://52.77.122.228/uploads/events/${_eventsDetail!.image}",
                    fit: BoxFit.fill,
                       errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          // Return a default image or placeholder widget when an error occurs
                          return Image.network(
                            'https://www.shutterstock.com/image-photo/concept-image-business-acronym-eod-260nw-332349266.jpg',
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fill,
                          );
                        },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Text(
                    _eventsDetail!.heading,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Column(
                    children: [
                     Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: Color(0xFFE93314),
                            size: 18,
                          ), // Start date icon
                           SizedBox(width: 4,),
                          Text('Start Date : $formattedstartDate',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)), // Start date text
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
                           SizedBox(width: 4,),
                          Text('End Date : $formattedendDate',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)), // End date text
                        ],
                      ),
                      const SizedBox(
                        height: 10,
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
                           const SizedBox(width: 4,),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.88,
                            child: const Text(
                              'Event Venue : 12 hst road 2nd stree canada 55056',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                            ),
                          ), // End date text
                        ],
                      ),
                      const SizedBox(height: 20,),
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
                        SizedBox(width: 4,),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.88,
                            child: Text(
                            "Discription : ${_eventsDetail!.content}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
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
              top: MediaQuery.of(context).size.height * 0.28,
              right: 30,
              child: GestureDetector(
                onTap: () async {
                  // Add share functionality here
                     await ShareUtils.share(
                        "குட்வின் கிளார்க்சனின் பிடியை முறியடிக்க வேண்டும்",
                          "https://thedipaar.ca/shortadmin/admin-news/23-10-2023-1698060667.jpg","${shareBaseURL}${widget.id}"
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
      ),
    );
  }
}
