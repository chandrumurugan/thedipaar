import 'package:flutter/material.dart';
import 'package:thedipaar/constants/imageConstants.dart';

class NewsItem extends StatefulWidget {
  bool? showTime;
  NewsItem({super.key, this.showTime});

  @override
  State<NewsItem> createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        height: 450,
        width: MediaQuery.of(context).size.width,
        // padding: EdgeInsets.symmetric(horizontal: 12,),
        color: const Color(0xFFF7F7F7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
          SizedBox(
            height: 240,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              AppImages.newsSample,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
            // color: Colors.amberAccent,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
  height: 20,
  // width: 60,
  decoration: BoxDecoration(
    color: Color(0xFFE93314),
    borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
  ),
  child: Text('World',style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.white),),
),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Text(
              'குட்வின் கிளார்க்சனின் பிடியை முறியடிக்க வேண்டும்',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
                'லோரெம் இப்சம் டோஸ்செக்டெர் அடிபிசிசிங் எலிட், செட் டூ. லோரெம் இப்சம் டோலர் சிட் அமெட், கன்செக்டெர் நல்லா ஃப்ரிங்கில்லா புருஸ் அட் லியோ டிக்னிசிம் காங்கு. மாரிஸ் எலிமெண்டம் அகும்சன் லியோ வெல் டெம்பர்.',
                style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFAAAAAA),
                    fontWeight: FontWeight.bold)),
          ),
          const Visibility(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      color: Color(0xFFE93314),
                      size: 12,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text('12 Jun',
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFFAAAAAA),
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(width: 10,),
                 Row(
                  children: [
                    Icon(
                      Icons.punch_clock,
                      color: Color(0xFFE93314),
                      size: 12,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text('3.00 PM',
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFFAAAAAA),
                            fontWeight: FontWeight.bold)),
                  ],
                )
              ],
            ),
          ))
        ]),
      ),
    );
  }
}
