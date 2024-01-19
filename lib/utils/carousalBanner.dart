import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:thedipaar/constants/imageConstants.dart';
import 'package:thedipaar/modal/sponserListModal.dart';
import 'package:thedipaar/service/web_service.dart';

class BannerView extends StatefulWidget {
  const BannerView({super.key});

  @override
  State<BannerView> createState() => _BannerViewState();
}

class _BannerViewState extends State<BannerView> {

    bool isLoading = false;
  List<SponsorList> _sponsers = [];

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    setState(() {
      isLoading = true;
    });
    try {
      final news = await webservice.fetchSponserList();
      setState(() {
        _sponsers = news;

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


  int _currendSlider = 0;


 List<Widget> _bannerViewView() {
    List<Widget> list = [];
    for (int i = 0; i < _sponsers!.length; i++) {
      list.add(GestureDetector(
        onTap: () {
      
        },
        child: Image.network("http://52.77.122.228/uploads/sponsor/${_sponsers[i].image}",fit: BoxFit.fill,width: MediaQuery.of(context).size.width,),
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
                      child: _sponsers.length > 0
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
                                    _sponsers!.length <= 1 ? false : true,
                                reverse: false,
                                autoPlay:
                                    _sponsers!.length <= 1 ? false : true,
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