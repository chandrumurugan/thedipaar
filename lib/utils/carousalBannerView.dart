import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:thedipaar/constants/imageConstants.dart';
import 'package:thedipaar/modal/sponserListModal.dart';
import 'package:thedipaar/service/web_service.dart';
import 'package:url_launcher/url_launcher.dart';

class SponsorView extends StatefulWidget {
  const SponsorView({Key? key});

  @override
  State<SponsorView> createState() => _SponsorViewState();
}

class _SponsorViewState extends State<SponsorView> {
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

  int _currentSlider = 0;
  Future<void> _launchUrl(String _url) async {
    if (!await launchUrl(Uri.parse(_url))) {
      throw Exception('Could not launch $_url');
    }
  }

  List<Widget> _sponsorViewWidgets() {
    List<Widget> list = [];
    for (int i = 0; i < _sponsers.length; i += 2) {
      list.add(Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Handle sponsor tap
                print('========>${_sponsers[i].link}');
                _launchUrl(_sponsers[i].link);
              },
              child: CachedNetworkImage(
                imageUrl:
                    "http://thedipaar.com/uploads/sponsor/${_sponsers[i].image}",
                fit: BoxFit.fill,
                placeholder: (context, url) =>
                    CircularProgressIndicator(color: const Color(0xFFE93314),), // Placeholder widget
                errorWidget: (context, url, error) => Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                ), // Error widget
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: i + 1 < _sponsers.length
                ? GestureDetector(
                    onTap: () {
                      // Handle sponsor tap
                      _launchUrl(_sponsers[i + 1].link);
                    },
                    child: CachedNetworkImage(
                      imageUrl:
                          "http://thedipaar.com/uploads/sponsor/${_sponsers[i + 1].image}",
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(color: const Color(0xFFE93314),), // Placeholder widget
                      errorWidget: (context, url, error) => Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,
                      ), // Error widget
                    ),
                  )
                : Container(), // Handles the case when the number of images is odd
          ),
        ],
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
      child: _sponsers.isNotEmpty
          ? CarouselSlider(
              items: _sponsorViewWidgets(),
              options: CarouselOptions(
                viewportFraction: 1.0, // Show one item at a time
                initialPage: 0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentSlider = index;
                  });
                },
                enableInfiniteScroll: _sponsers.length <= 1 ? false : true,
                reverse: false,
                autoPlay: _sponsers.length <= 1 ? false : true,
                autoPlayInterval: Duration(seconds: 5),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
            )
          : null,
    );
  }
}
