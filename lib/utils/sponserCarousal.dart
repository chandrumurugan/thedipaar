
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:thedipaar/constants/imageConstants.dart';


class Sponsers extends StatefulWidget {
  final ScrollController? scrollController;
  final bool? items;


   Sponsers({Key? key, this.scrollController,  this.items, })
      : super(key: key);

  @override
  State<Sponsers> createState() => _SponsersState();
}

class _SponsersState extends State<Sponsers> {

  Timer? _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    // Start a timer to automatically scroll the ListView
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentIndex < 2) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      widget.scrollController!.animateTo(
        _currentIndex * 120.0, // Adjust this value as needed
        duration: Duration(milliseconds: 500),
        curve: Curves.linear,
      );
    });
  }

  @override
  void dispose() {
    // Don't forget to cancel the timer when the widget is disposed
    _timer!.cancel();
    super.dispose();
  }

      List sampleSponsers = [
       AppImages.Sample1, AppImages.Sample2, AppImages.Sample3, AppImages.Sample4, AppImages.Sample5, AppImages.Sample6,
      ];

      List sampleProducts = [
        AppImages.product1,
         AppImages.product2,
          AppImages.product3,
           AppImages.product4,
            AppImages.product5,
             AppImages.product6,
              AppImages.product7,
               AppImages.product8,
      ];

      List productsTitle = [
        'Thedipaar',
        'Pasi 247',
        'Anuthaapam',
        "Tamil Shop",
        "Thedipaar TV",
        "Thedipaar FM",
        "Estate",
        "Foundation"

      ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListView.builder(
          controller: widget.scrollController,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: widget.items! ? sampleProducts .length : sampleSponsers.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: CircleAvatar(
                    radius: 40,backgroundColor: Colors.grey[200],
                    child: Image.asset(
                      
                     widget.items! ? sampleProducts[index]:
                      sampleSponsers[index], fit: BoxFit.fill,
                      height: 100,width:widget.items! ? 80 : 60,
                      ),
                  ),
                ),
                Visibility(
                  visible: widget.items!,
                  child: Text(productsTitle[index],style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)))
              ],
            );
          }),
    );
  }
}