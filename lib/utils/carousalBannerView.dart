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
                _launchUrl(_sponsers[i].link);
              },
              child: Image.network(
                "http://52.77.122.228/uploads/sponsor/${_sponsers[i].image}",
                fit: BoxFit.fill,
                  errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          // Return a default image or placeholder widget when an error occurs
                          return Image.network(
                            'https://media.gettyimages.com/id/1352266790/vector/sponsor-stamp-imprint-seal-template-grunge-effect-vector-stock-illustration.jpg?s=612x612&w=gi&k=20&c=zE27klszgZg_N_xgAplSLRpb8YEa81pOoIDbZ9N2rec=',
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fill,
                          );
                        },
              ),
            ),
          ),
          SizedBox(width: 8), // Adjust the spacing between sponsors
          Expanded(
            child: i + 1 < _sponsers.length
                ? GestureDetector(
                    onTap: () {
                      // Handle sponsor tap
                      _launchUrl(_sponsers[i + 1].link);
                    },
                    child: Image.network(
                      "http://52.77.122.228/uploads/sponsor/${_sponsers[i + 1].image}",
                      fit: BoxFit.fill,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          // Return a default image or placeholder widget when an error occurs
                          return Image.network(
                            'https://media.gettyimages.com/id/1352266790/vector/sponsor-stamp-imprint-seal-template-grunge-effect-vector-stock-illustration.jpg?s=612x612&w=gi&k=20&c=zE27klszgZg_N_xgAplSLRpb8YEa81pOoIDbZ9N2rec=',
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fill,
                          );
                        },
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
