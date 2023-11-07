import 'package:flutter/material.dart';
import 'package:thedipaar/constants/imageConstants.dart';
import 'package:thedipaar/utils/newsItemContainer.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Events',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        // automaticallyImplyLeading: true,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            // child: ListView.builder(itemBuilder: (context,index)=>eventsView(),itemCount: 3,),
            child: ListView.separated(
                itemBuilder: (context, index) => eventsView(),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: 3),
          )),
    );
  }

 Widget eventsView() {
  return Container(
    height: 150,
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
     decoration: BoxDecoration(
      color: Color(0xFFE1E1E1),
      borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
      border: Border.all(
        color: Colors.black, // Set the border color here
        width: 2, // Set the border width here
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: 160,
          child: Image.asset(AppImages.newsSample, fit: BoxFit.fill),
        ),
        const SizedBox(width: 5,),
        const Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'குட்வின் கிளார்க்சனின் பிடியை முறியடிக்க வேண்டும்',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                overflow: TextOverflow.visible,
              ),
              SizedBox(
                height: 8,
              ),
               Row(
                children: [
                  Icon(Icons.calendar_month, color: Color(0xFFE93314),size: 14,), // Start date icon
                  Text('Start Date: 10-11-2023', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)), // Start date text
                ],
              ),
              Row(
                children: [
                  Icon(Icons.calendar_month, color: Color(0xFFE93314),size: 14,), // End date icon
                  Text('End Date: 10-11-2023', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)), // End date text
                ],
              )
            ],
          ),
        )
      ],
    ),
  );
}

}
