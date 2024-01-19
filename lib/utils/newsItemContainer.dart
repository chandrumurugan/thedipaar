import 'package:flutter/material.dart';
import 'package:thedipaar/constants/imageConstants.dart';
import 'package:simple_share_native/simple_share_native.dart';
import 'package:thedipaar/utils/dateChangeUtils.dart';
import 'package:thedipaar/utils/homeTabs.dart';
import 'package:thedipaar/utils/shareUtils.dart';
import 'package:thedipaar/view/newsDetailPage.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsItem extends StatefulWidget {
  final String id;
  final String img;
  final String cat_name;
  final String title;
  final String created_date;
  final String shorts;

  NewsItem({
    super.key,
    required this.id,
    required this.img,
    required this.cat_name,
    required this.title,
    required this.created_date, required this.shorts,
  });

  @override
  State<NewsItem> createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  final _simpleShareNativePlugin = SimpleShareNative();
  DateTime? providedDateTime;
  String? timeAgo;
  String? shareBaseURL;
  @override
  void initState() {
    super.initState();
    setState(() {
   
      providedDateTime = DateTime.parse(widget.created_date.toString());

      timeAgo = DateDayConverter.getTimeDifference(providedDateTime!);
    

    });
     _getconfig();
  }
  _getconfig()async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   setState(() {
       shareBaseURL = prefs.getString('share_baseurl');
   });
  }

//  Future<void> shareText(String title) async {
//     // final String message = textController.text.trim();
//     // await _simpleShareNativePlugin.shareMessage('SAMPLE TEXT');
//     // await Share.share('check out my website https://example.com', subject: 'Look what I made!');
//     await Share.shareXFiles([XFile(AppImages.app_logo)], text: title);
//     //Share.shareXFiles([XFile('${directory.path}/image.jpg')], text: 'Great picture')
//   }

  @override
  Widget build(BuildContext context) {
    // final bool isSports = widget.currentTabIndex == widget.dataLen - 1;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewsDetail(
                      id: widget.id,
                    ))); //NewsTab
        //  Navigator.push(context, MaterialPageRoute(builder: (context)=> NewsTab()));
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            // padding: EdgeInsets.only(bottom: 10),
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Card(
              color: Colors.white,
              shadowColor: const Color(0xFFE93314),
              surfaceTintColor: Colors.white,
              elevation: 5.0,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    "http://52.77.122.228/uploads/news/${widget.img}",
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  // color: Colors.amberAccent,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    height: 20,
                    // width: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE93314),
                      borderRadius:
                          BorderRadius.circular(10), // Adjust the radius as needed
                    ),
                    child: Text(
                      widget.cat_name,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Text(
                    widget.title,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: SizedBox(
                    height: 34,
                    child: Text(
                      widget.shorts,
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFFAAAAAA),
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.timelapse_outlined,
                            color: Color(0xFFE93314),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            timeAgo!,
                            style: TextStyle(color: Color(0xFFE93314), fontSize: 12),
                          ),
                        ],
                      ),
                    //   Container(
                    //        decoration: BoxDecoration(
                    //   color: Color(0xFFE93314), 
                    //   borderRadius:
                    //       BorderRadius.circular(10), // Adjust the radius as needed
                    // ),
                    //     child: Row(
                    //       children: [
                    //         IconButton(
                    //           onPressed: () async {
                    //             await ShareUtils.share(
                    //               widget.title,
                    //               "https://thedipaar.ca/shortadmin/admin-news/23-10-2023-1698060667.jpg",
                    //             );
                    //           },
                    //           icon: const Icon(
                    //             Icons.share,
                    //             size: 18,
                    //             color: Colors.white, // Color(0xff23527C)
                    //           ),
                    //         ),
                    //         const Text(
                    //           'Share',
                    //           style: TextStyle(
                    //             fontSize: 12,
                    //             color: Color(0xFFAAAAAA),
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   )
                    ],
                  ),
                ),  const SizedBox(
                  height: 15,
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
                  print("${shareBaseURL}${widget.id}");
                     await ShareUtils.share(
                         widget.title,
                          "http://52.77.122.228/uploads/news/${widget.img}","${shareBaseURL}${widget.id}"
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
