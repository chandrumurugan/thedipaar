import 'package:flutter/material.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ContactUs',
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
      // body: ContactUsWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Center(
                child: Text(
                  'Get in Touch',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  'If you have any inquries get in touch with us\nWe will happy to help you',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              _buildContactRow(
                  Icons.phone, '416-635-0635 / 416-244-8818', context),
              SizedBox(
                height: 20,
              ),
              _buildContactRow(
                  Icons.location_on,
                  '2900 MARKHAM ROAD, Unit - U1 TORONTO, M1X 0C8,canada.',
                  context),
              SizedBox(
                height: 20,
              ),
              _buildContactRow(Icons.email, 'info@thedipaar.com', context),
              SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialIcon(Icons.facebook),
                  SizedBox(width: 20.0),
                  _buildSocialIcon(Icons.mail),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 60,
      decoration: BoxDecoration(
        // color: Color(0xFFE1E1E1),
        borderRadius: BorderRadius.circular(30), // Adjust the radius as needed
        border: Border.all(
          color: Colors.black, // Set the border color here
          width: 2, // Set the border width here
        ),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 30.0,
            color: Colors.blue,
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Flexible(
              child: Text(
                text,
                maxLines: 3,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return CircleAvatar(
      backgroundColor: Colors.blue,
      radius: 20.0,
      child: Icon(
        icon,
        color: Colors.white,
        size: 20.0,
      ),
    );
  }
}
