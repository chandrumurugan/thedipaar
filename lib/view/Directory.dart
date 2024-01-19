import 'package:flutter/material.dart';
import 'package:thedipaar/constants/imageConstants.dart';
import 'package:thedipaar/utils/appBarUtils.dart';
import 'package:thedipaar/utils/carousalBannerView.dart';
import 'package:thedipaar/utils/searchBarUtils.dart';
import 'package:thedipaar/utils/sideDrawer.dart';
import 'package:thedipaar/view/searchDirectory.dart';
import 'package:url_launcher/url_launcher.dart';

class DirectoryScreen extends StatefulWidget {
  const DirectoryScreen({super.key});

  @override
  State<DirectoryScreen> createState() => _DirectoryScreenState();
}

class _DirectoryScreenState extends State<DirectoryScreen> {
  List products = [
    {"id": 1, "products": AppImages.thedipaarq},
    {"id": 2, "products": AppImages.pasi_thedipaarq},
    {"id": 3, "products": AppImages.anuthabam_thedipaarq},
    {"id": 4, "products": AppImages.fm_thedipaarq},
    {"id": 5, "products": AppImages.thedipaarq},
    {"id": 6, "products": AppImages.pasi_thedipaarq},
    {"id": 7, "products": AppImages.anuthabam_thedipaarq},
    {"id": 8, "products": AppImages.fm_thedipaarq}
  ];
  List socialIcons = [
    {"id": 1, "socialIcons": AppImages.whatsapp},
    {"id": 1, "socialIcons": AppImages.facebook},
    {"id": 1, "socialIcons": AppImages.google},
    {"id": 1, "socialIcons": AppImages.twitter},
    {"id": 1, "socialIcons": AppImages.pinterest},
    {"id": 1, "socialIcons": AppImages.linkedin},
  ];

  List sampleProducts = [
    {"id": 1, "products": AppImages.product1},
    {"id": 2, "products": AppImages.product2},
    {"id": 3, "products": AppImages.product3},
    {"id": 4, "products": AppImages.product4},
    {"id": 5, "products": AppImages.product5},
    {"id": 6, "products": AppImages.product6},
    {"id": 7, "products": AppImages.product7},
    {"id": 8, "products": AppImages.product8}
  ];


  void _productsLaunch(int index)async{
        List<Uri> urls = [
    Uri.parse('https://www.thedipaar.com/#bypass-sw'), // URL for the first item
    Uri.parse('https://play.google.com/store/apps/details?id=io.pasi247.com'), // URL for the second item
     Uri.parse('https://www.anuthaapam.com/'), 
      Uri.parse('http://torontotamilshop.com/'), 
       Uri.parse('http://thedipar.ca/tv'), 
        Uri.parse('https://zeno.fm/radio/thedipaar/'), 
         Uri.parse('https://allestatetips.com/'), 
          Uri.parse('https://thedipaarfoundation.org/'), 
    // Add more URLs as needed
  ];

  if (index >= 0 && index < urls.length) {
    await _launchInBrowser(urls[index]);
  }
  }

Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: ListView(
          children: [
            const SponsorView(),
            const SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const SearchDirectoryScreen()));
                },
                child: const SearchBarUtils(
                  isEdit: false,
                )),
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Our products',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Wrap(
            //   spacing: 10.0, // Spacing between avatars
            //   runSpacing: 20.0, // Spacing between rows
            //   children: sampleProducts.map((products) {
            //     return CircleAvatar(
            //       radius: 40, // Adjust as needed
            //        backgroundColor: Colors.white,
            //       child: Image.asset(
            //         products['products'],
            //         fit: BoxFit.fill,
            //       ),
            //     );
            //   }).toList(),
            // ),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 20.0,
              ),
              shrinkWrap: true,
              itemCount: sampleProducts.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: (){
                    _productsLaunch(index);
                  },
                  child: CircleAvatar(
                    radius: 40, // Adjust as needed
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      sampleProducts[index]['products'],
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Connect us',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: socialIcons.map((products) {
                  return CircleAvatar(
                    radius: 30, // Adjust as needed
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      products['socialIcons'],
                      fit: BoxFit.fill,
                    ),
                  );
                }).toList(),
              ),
            )
            //           Wrap(
            //   spacing: 8.0, // Spacing between avatars
            //   runSpacing: 20.0, // Spacing between rows
            // children: socialIcons.map((products) {
            //   return CircleAvatar(
            //     radius: 30, // Adjust as needed
            //     backgroundColor: Colors.white,
            //     child: Image.asset(
            //       products['socialIcons'],
            //       fit: BoxFit.fill,
            //     ),
            //   );
            // }).toList(),
            // ),
          ],
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}
