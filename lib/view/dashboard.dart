// import 'package:flutter/material.dart';
// import 'package:thedipaar/utils/floatingActionUtils.dart';
// import 'package:thedipaar/view/Directory.dart';

// import 'package:thedipaar/view/eventsList.dart';
// import 'package:thedipaar/view/home_screen.dart';
// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';




// class DashBoard extends StatefulWidget {
//   const DashBoard({Key? key}) : super(key: key);

//   @override
//   State<DashBoard> createState() => _DashBoardState();
// }

// class _DashBoardState extends State<DashBoard> {
//   int _selectedIndex = 0;
//   late List<Widget> _pages;

//   @override
//   void initState() {
//     super.initState();
//     _pages = [
//       const HomeScreen(),
//       TableEventsExample(),
//       const DirectoryScreen(),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (_selectedIndex != 0) {
//           setState(() {
//             _selectedIndex = 0;
//           });
//           return false; // Prevent default back button behavior
//         }
//         return true; // Allow default back button behavior
//       },
//       child: Scaffold(
//         body: _pages[_selectedIndex],
//         bottomNavigationBar: BottomNavigationBar(
//           selectedItemColor: const Color(0xFFE93314), // Active item color
//           unselectedItemColor: Colors.grey, // Inactive item color
//           currentIndex: _selectedIndex,
//           type: BottomNavigationBarType.shifting,
//           backgroundColor: Color(0xff23527C).withOpacity(0.1),
//           elevation: 10.0,
//           onTap: (index) {
//             setState(() {
//               _selectedIndex = index;
//             });
//           },
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.category_rounded),
//               label: 'Events',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.local_offer_sharp),
//               label: 'Directory',
//             ),
//           ],
//         ),
//         floatingActionButton: CircularMenuFAB(),
//       ),
//     );
//   }
// }




