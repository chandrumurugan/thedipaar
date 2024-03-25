import 'package:flutter/material.dart';
import 'package:thedipaar/constants/imageConstants.dart';
import 'package:flutter/foundation.dart' show kDebugMode;


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  const CustomAppBar({super.key,});

  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(
              Icons.menu,
              color: Color(0xFFE93314),
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      automaticallyImplyLeading: kDebugMode,
      title: SizedBox(
        height: 50,
        width: 150,
        child: Image.asset(AppImages.app_logo), // Replace 'assets/app_logo.png' with your actual logo path
      ),
      centerTitle: true,
      // actions: <Widget>[
      //   IconButton(
      //     icon: const Icon(Icons.search, color: Color(0xFFE93314)),
      //     onPressed: () {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => Search()), // Replace 'Search()' with your actual search screen
      //       );
      //     },
      //   ),
      // ],
    );
  }
}
