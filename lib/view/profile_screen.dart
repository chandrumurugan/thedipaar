import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
        title: Text('Profile'),
        // leading: IconButton(onPressed: (){
        //   Navigator.pop(context);
        // }, icon: Icon(Icons.arrow_back)),
        centerTitle: true,
      ),
      body: UserProfile(),
    );
  }
}



class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 20),
        CircleAvatar(
          radius: 60,
          // backgroundImage: AssetImage('assets/user_avatar.jpg'),
        ),
        SizedBox(height: 10),
        Text(
          'John Doe',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Web Developer',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 20),
        Align(
          alignment: Alignment.center,
          child: Text(
            'A passionate web developer with a love for Flutter.',
            style: TextStyle(fontSize: 16),
          ),
        ),
        SizedBox(height: 20),
        Text(
          'My Posts',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 10, // Replace with your actual post count
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Post $index'),
                subtitle: Text('This is the content of post $index.'),
                leading: Icon(Icons.article),
              );
            },
          ),
        ),
      ],
    );
  }
}