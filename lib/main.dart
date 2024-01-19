
import 'package:flutter/material.dart';
import 'package:thedipaar/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // print('message sendere ID=======>${Firebase.apps.isEmpty}');

  //   try {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );

  //   String messagingSenderId = '1017496235042'; // Assign a default sender ID

  //   // Check if Firebase has been initialized and retrieve the sender ID
  //   if (Firebase.apps.isNotEmpty) {
  //     messagingSenderId =
  //         Firebase.apps.first.options.messagingSenderId ?? '1017496235042';
  //   }

  //   runApp(const MyApp());
  // } catch (e) {
  //   print('Error initializing Firebase: $e');
  //   // Handle the error accordingly, e.g., show an error screen, retry initialization, etc.
  // }
  // for(var res in Firebase.apps){
  // print('message sendere ID=======>${res.toString()}');
  // }
 

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SpalshScreen(),
    );
  }
}
