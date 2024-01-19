import 'package:flutter/material.dart';
import 'package:thedipaar/utils/floatingActionUtils.dart';
import 'package:thedipaar/view/Directory.dart';
import 'package:thedipaar/view/events.dart';
import 'package:thedipaar/view/home_screen.dart';



class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
   int _selectedIndex = 0;
 
  Widget? _currentPage;
  double bottomNavBarHeight = 60;
    @override
  void initState() {
    super.initState();
    _currentPage = _getPage(_selectedIndex);
  }
  



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       body: _currentPage,
       bottomNavigationBar: 
       BottomNavigationBar(
        selectedItemColor: const Color(0xFFE93314), // Active item color
        unselectedItemColor: Colors.grey, // Inactive item color
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _currentPage = _getPage(index);
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_rounded),
            label: 'Events', // Assuming Events is renamed to Category
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer_sharp),
            label: 'Directory',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person_2),
          //   label: 'Profile',
          // ),
        ],
      ),
      floatingActionButton: CircularMenuFAB(),
    );
  }

   _getPage(int index) {
  
    switch (index) {
      case 0:
      return const HomeScreen();
      case 1:
       return  Events(back: false,);
      case 2:
         return const DirectoryScreen();
      // case 3:
      //  return const ProfileScreen();
      default:
        return Container();
    }
  }
}