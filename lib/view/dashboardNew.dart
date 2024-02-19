import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:thedipaar/utils/floatingActionUtils.dart';
import 'package:thedipaar/view/Directory.dart';
import 'package:thedipaar/view/eventsList.dart';
import 'package:thedipaar/view/home_screen.dart';

class DashBoardNew extends StatefulWidget {
  const DashBoardNew({super.key});

  @override
  State<DashBoardNew> createState() => _DashBoardNewState();
}

class _DashBoardNewState extends State<DashBoardNew> {
  final _pageController = PageController(initialPage: 0);
  final _controller = NotchBottomBarController(index: 0);

  int maxCount = 5;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// widget list
  final List<Widget> bottomBarPages = [
    const HomeScreen(),
    TableEventsExample(),
    const DirectoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              /// Provide NotchBottomBarController
              notchBottomBarController: _controller,
              color: Colors.white,
              showLabel: true,
              shadowElevation: 5,
              kBottomRadius: 28.0,
              blurOpacity: 1.0,
              blurFilterX: 10.0,
              blurFilterY: 20.0,
              notchColor: Color(0xFFE93314).withOpacity(0.9),
              itemLabelStyle: TextStyle(
                  color: Color(0xFFE93314),
                  fontSize: 12,
                  fontWeight: FontWeight.bold),

              /// restart app if you change removeMargins
              removeMargins: false,
              bottomBarWidth: 500,
              // durationInMilliSeconds: 300,
              bottomBarItems: const [
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.home,
                    color: Color(0xFFE93314),
                  ),
                  activeItem: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  itemLabel: 'Home',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.category_rounded,
                    color: Color(0xFFE93314),
                  ),
                  activeItem: Icon(
                    Icons.category_rounded,
                    color: Colors.white,
                  ),
                  itemLabel: 'Events',
                ),

                ///svg example
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.local_offer_sharp,
                    color: Color(0xFFE93314),
                  ),
                  activeItem: Icon(
                    Icons.local_offer_sharp,
                    color: Colors.white,
                  ),
                  itemLabel: 'Directory',
                ),
              ],
              onTap: (index) {
                /// perform action on tab change and to update pages you can update pages without pages
                // log('current selected index $index');
                _pageController.jumpToPage(index);
              },
              kIconSize: 24.0,
            )
          : null,
             floatingActionButton: CircularMenuFAB(),
             floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop, 
    );
  }
}
