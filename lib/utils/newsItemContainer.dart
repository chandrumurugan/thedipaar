import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:thedipaar/utils/dateChangeUtils.dart';
import 'package:thedipaar/utils/shareUtils.dart';
import 'package:thedipaar/view/newsDetailPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsItem extends StatefulWidget {
  final String id;
  final String img;
  final String cat_name;
  final String title;
  final String created_date;
  final String shorts;
  final VoidCallback onShare;

  NewsItem({
    Key? key,
    required this.id,
    required this.img,
    required this.cat_name,
    required this.title,
    required this.created_date,
    required this.shorts,
    required this.onShare,
  }) : super(key: key);

  @override
  State<NewsItem> createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
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

  _getconfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      shareBaseURL = prefs.getString('share_baseurl');
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewsDetail(
        id: widget.id,
        img: widget.img,
                    )));

        // Navigator.push(
        //   context,
        //   PageRouteBuilder(
        //     transitionDuration:
        //         Duration(milliseconds: 800), // Adjust duration as needed
        //     pageBuilder: (context, animation, secondaryAnimation) {
        //       return FadeThroughTransition(
        //         animation: animation,
        //         secondaryAnimation: secondaryAnimation,
        //         child: NewsDetail(
        //           id: widget.id,
        //           img: widget.img,
        //         ),
        //       );
        //     },
        //   ),
        // );
      },
      child: SizedBox(
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
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 140,
                        width: MediaQuery.of(context).size.width,
                        child: Hero(
                          tag: 'newsImage${widget.id}',
                          child: CachedNetworkImage(
                            imageUrl:
                                "http://thedipaar.com/uploads/news/${widget.img}",
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(color: const Color(0xFFE93314),), // Placeholder widget while loading
                            errorWidget: (context, url, error) => Image.network(
                              'https://euaa.europa.eu/sites/default/files/styles/width_600px/public/default_images/news-default-big.png?itok=NNXAZZTc',
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.fill,
                            ), // Widget to display if image fails to load
                          ),
                        ),
                        // color: Colors.amberAccent,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          height: 20,
                          // width: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE93314),
                            borderRadius: BorderRadius.circular(
                                10), // Adjust the radius as needed
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
                        child: Container(
                          // height: 40,
                          child: Text(
                            widget.title,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
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
                                  style: TextStyle(
                                      color: Color(0xFFE93314), fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ]),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.15,
              right: MediaQuery.of(context).size.width * 0.06,
              child: GestureDetector(
             onTap: widget.onShare,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE93314),
                    borderRadius: BorderRadius.circular(
                        15), // Adjust the radius as needed
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
      ),
    );
  }
}

// class NewsItem extends StatefulWidget {
  // final String id;
  // final String img;
  // final String cat_name;
  // final String title;
  // final String created_date;
  // final String shorts;
  // final VoidCallback onShare;

  // NewsItem({
  //   Key? key,
  //   required this.id,
  //   required this.img,
  //   required this.cat_name,
  //   required this.title,
  //   required this.created_date,
  //   required this.shorts,
  //   required this.onShare,
  // }) : super(key: key);

//   @override
//   State<NewsItem> createState() => _NewsItemState();
// }

// class _NewsItemState extends State<NewsItem> {
//   DateTime? providedDateTime;
//   String? timeAgo;
//   String? shareBaseURL;

//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       providedDateTime = DateTime.parse(widget.created_date.toString());
//       timeAgo = DateDayConverter.getTimeDifference(providedDateTime!);
//     });
//     _getconfig();
//   }

//   _getconfig() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       shareBaseURL = prefs.getString('share_baseurl');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {

//     return InkWell(
//       onTap: () {
//         if(mounted)
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>        NewsDetail(
//                 id: widget.id,
//                 img: widget.img,
//               )));
//         // Navigator.push(
//         //   context,
//         //   PageRouteBuilder(
//         //     transitionDuration: Duration(milliseconds: 800),
//         //     pageBuilder: (context, animation, secondaryAnimation) {
//               // return NewsDetail(
//               //   id: widget.id,
//               //   img: widget.img,
//               // );
//         //     },
//         //   ),
//         // );
//       },
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 10),
//         width: MediaQuery.of(context).size.width,
//         color: Colors.white,
//         child: Stack(
//           children: [
//             Card(
//               color: Colors.white,
//               shadowColor: const Color(0xFFE93314),
//               surfaceTintColor: Colors.white,
//               elevation: 5.0,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: 140,
//                     width: MediaQuery.of(context).size.width,
//                     child: CachedNetworkImage(
//                       imageUrl:
//                           "http://thedipaar.com/uploads/news/${widget.img}",
//                       width: MediaQuery.of(context).size.width,
//                       fit: BoxFit.cover,
//                       placeholder: (context, url) =>
//                           CircularProgressIndicator(),
//                       errorWidget: (context, url, error) => Image.network(
//                         'https://euaa.europa.eu/sites/default/files/styles/width_600px/public/default_images/news-default-big.png?itok=NNXAZZTc',
//                         width: MediaQuery.of(context).size.width,
//                         fit: BoxFit.fill,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 12, vertical: 5),
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 8),
//                       height: 20,
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFE93314),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Text(
//                         widget.cat_name,
//                         style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 12,
//                     ),
//                     child: Container(
//                       child: Text(
//                         widget.title,
//                         style: TextStyle(
//                             fontSize: 14, fontWeight: FontWeight.bold),
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 3,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 12),
//                     child: SizedBox(
//                       height: 34,
//                       child: Text(
//                         widget.shorts,
//                         style: TextStyle(
//                           fontSize: 10,
//                           color: Color(0xFFAAAAAA),
//                           fontWeight: FontWeight.bold,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 2,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.timelapse_outlined,
//                               color: Color(0xFFE93314),
//                             ),
//                             SizedBox(
//                               width: 6,
//                             ),
//                             Text(
//                               timeAgo!,
//                               style: TextStyle(
//                                   color: Color(0xFFE93314), fontSize: 12),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               top: 0,
//               right: 0,
//               child: GestureDetector(
//                 onTap: widget.onShare,
//                 child: Container(
//                   height: 40,
//                   width: 40,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFE93314),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: const Icon(
//                     Icons.share,
//                     color: Colors.white,
//                     size: 25,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
