import 'package:flutter/material.dart';
import 'package:thedipaar/constants/imageConstants.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {

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
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
   body: Padding(
     padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
     child: Column(
     children: [
      SizedBox(height: 20,),
      SearchBar(),
      Expanded(child: ListView.separated(
        padding: EdgeInsets.zero,
        itemBuilder:  (context,index)=>Container(
        color: Colors.amber,
        height: 250,
        width: MediaQuery.of(context).size.width,
        child: Image.asset(slideImages[index]['bannerView'],fit: BoxFit.fill,),
      ), separatorBuilder:(context,index)=>SizedBox(height: 10,) , itemCount: slideImages.length))
     ],
     ),
   ),
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}