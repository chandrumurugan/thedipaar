import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:thedipaar/constants/imageConstants.dart';
import 'package:thedipaar/constants/imageConstants.dart';

class BannerView extends StatefulWidget {
  const BannerView({super.key});

  @override
  State<BannerView> createState() => _BannerViewState();
}

class _BannerViewState extends State<BannerView> {

    List slideImages = [
    {
      "id" : 1,
      "bannerView" : AppImages.banner1
    },
     {
      "id" : 2,
      "bannerView" : AppImages.banner2
    },
     {
      "id" : 3,
      "bannerView" : AppImages.banner3
    },
     {
      "id" : 4,
      "bannerView" : AppImages.banner4
    }

  ];
  int _currendSlider = 0;


 List<Widget> _bannerViewView() {
    List<Widget> list = [];
    for (int i = 0; i < slideImages!.length; i++) {
      list.add(GestureDetector(
        onTap: () {
      
        },
        child: Image.asset(slideImages[i]["bannerView"],fit: BoxFit.fill,),
      ));
    }
    return list;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
                      width: double.infinity,
                      height: 125,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        // color: Colors.amber
                      ),
                      child: slideImages.length > 0
                          ? CarouselSlider(
                              items: _bannerViewView(),
                              options: CarouselOptions(
                                // viewportFraction: 0.89,
                                viewportFraction: 1.00,
                                initialPage: 0,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _currendSlider = index;
                                  });
                                },
                                enableInfiniteScroll:
                                    slideImages!.length <= 1 ? false : true,
                                reverse: false,
                                autoPlay:
                                    slideImages!.length <= 1 ? false : true,
                                autoPlayInterval: Duration(seconds: 5),
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                scrollDirection: Axis.horizontal,
                              ))
                          : null,
                    );
  }
}