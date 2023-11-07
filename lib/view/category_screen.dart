import 'package:flutter/material.dart';
import 'package:thedipaar/utils/newsItemContainer.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Events',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        // automaticallyImplyLeading: true,
        centerTitle: true,
        leading:IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)) ,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(itemBuilder: (context,index)=>NewsItem(showTime: true,),itemCount: 3,),
        )),
    );
  }
}