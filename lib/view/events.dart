import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thedipaar/constants/imageConstants.dart';
import 'package:thedipaar/modal/eventsListModal.dart';
import 'package:thedipaar/service/web_service.dart';
import 'package:thedipaar/utils/appBarUtils.dart';
import 'package:thedipaar/utils/shareUtils.dart';
import 'package:thedipaar/utils/sideDrawer.dart';
import 'package:thedipaar/view/eventsDetail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Events extends StatefulWidget {
  bool? back;
  Events({super.key, this.back});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  bool isLoading = false;
  List<EventsList> _events = [];
   String? shareBaseURL;

  @override
  void initState() {
    super.initState();
  
 
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
      final news = await webservice.fetchEventList();
      setState(() {
        _events = news;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              // child: ListView.builder(itemBuilder: (context,index)=>eventsView(),itemCount: 3,),
              child: ListView.separated(
                  itemBuilder: (context, index) => eventsView(_events[index]),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemCount: _events.length),
            )),
      ),
      drawer: MyDrawer(),
    );
  }

  Widget eventsView(EventsList events) {
            DateTime start1Date = DateTime.parse(events.start_date);

   
  var  formattedstartDate = DateFormat('MM-dd-yyyy').format(start1Date);
              DateTime end1Date = DateTime.parse(events.start_date);

   
  var  formattedendDate = DateFormat('MM-dd-yyyy').format(end1Date);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EventsDetailScreen(
                      id: events.id,
                    )));
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            // height: 380,
            width: MediaQuery.of(context).size.width,
            // padding: EdgeInsets.symmetric(horizontal: 12,),
            // decoration: BoxDecoration(
            //   color: const Color.fromARGB(255, 240, 239, 239),
            //   borderRadius: BorderRadius.circular(6), // Adjust the radius as needed
            //   border: Border.all(
            //     color:  const Color(0xff23527C), // Set the border color here
            //     width: 1, // Set the border width here
            //   ),
            // ),
            // color: const Color(0xFFF7F7F7),
            color: Colors.white,
            child: Card(
              color: Colors.white,
              shadowColor: const Color(0xFFE93314),
              elevation: 5.0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 140,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        "http://52.77.122.228/uploads/events/${events.heroImage}",
                        width: MediaQuery.of(context).size.width,
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
                      // color: Colors.amberAccent,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      child: Text(
                        events.metaTitle,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      child: Text(
                        events.metaDescription,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.normal),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 10,
                    // ),

                     Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: Color(0xFFE93314),
                                size: 14,
                              ), // Start date icon
                              Text('Start Date: ${formattedstartDate.toString()}',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight:
                                          FontWeight.bold)), // Start date text
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: Color(0xFFE93314),
                                size: 14,
                              ), // End date icon
                              Text('End Date: ${formattedendDate.toString()}',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight:
                                          FontWeight.bold)), // End date text
                            ],
                          )
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            right: MediaQuery.of(context).size.width * 0.06,
            child: GestureDetector(
              onTap: () async {
                // Add share functionality here
                await ShareUtils.share(
                  events.metaTitle,
                  "http://52.77.122.228/uploads/events/${events.heroImage}","${shareBaseURL}${events.id}"
                );
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFE93314),
                  borderRadius:
                      BorderRadius.circular(15), // Adjust the radius as needed
                ),
                child: const Icon(
                  Icons.share,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
