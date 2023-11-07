import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:bottom_bar_matu/bottom_bar_matu.dart';
import 'package:thedipaar/view/category_screen.dart';
import 'package:thedipaar/view/home_screen.dart';
import 'package:thedipaar/view/offers_screen.dart';
import 'package:thedipaar/view/profile_screen.dart';



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
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2),
            label: 'Profile',
          ),
        ],
      )
    );
  }

   _getPage(int index) {
  
    switch (index) {
      case 0:
      return const HomeScreen();
      case 1:
       return const Events();
      case 2:
         return const OffersScreen();
      case 3:
       return const ProfileScreen();
      default:
        return Container();
    }
  }
}