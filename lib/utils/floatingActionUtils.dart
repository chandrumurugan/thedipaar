

import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';




class CircularMenuFAB extends StatefulWidget {
  @override
  _CircularMenuFABState createState() => _CircularMenuFABState();
}

class _CircularMenuFABState extends State<CircularMenuFAB> with SingleTickerProviderStateMixin {
  Color _color = Colors.pink;
  String _colorName = 'Pink';

    Animation<double>? _animation;
  AnimationController? _animationController;

  @override
  void initState(){
        
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    
    
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionBubble(
        // Menu items
        items: <Bubble>[

          // Floating action menu item
          Bubble(
            title:"Directory",
            iconColor :Colors.white,
            bubbleColor : Colors.red.shade300,
            icon:Icons.contacts_outlined,
            titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
            onPress: () {
              _animationController!.reverse();
            },
          ),
          // Floating action menu item
          Bubble(
            title:"News bits",
            iconColor :Colors.white,
            bubbleColor : Colors.red.shade300,
            icon:Icons.people,
            titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
            onPress: () {
              _animationController!.reverse();
            },
          ),
          //Floating action menu item
          Bubble(
            title:"TV",
            iconColor :Colors.white,
            bubbleColor : Colors.red.shade300,
            icon:Icons.tv,
            titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
            onPress: () {
              // Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => Homepage()));
              _animationController!.reverse();
            },
          ),
            Bubble(
            title:"E-Book",
            iconColor :Colors.white,
            bubbleColor : Colors.red.shade300,
            icon:Icons.book_rounded,
            titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
            onPress: () {
              // Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => Homepage()));
              _animationController!.reverse();
            },
          ),
            Bubble(
            title:"FM",
            iconColor :Colors.white,
            bubbleColor : Colors.red.shade300,
            icon:Icons.radio,
            titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
            onPress: () {
              // Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => Homepage()));
              _animationController!.reverse();
            },
          ),
        ],

        // animation controller
        animation: _animation!,

        // On pressed change animation state
        onPress: () => _animationController!.isCompleted
              ? _animationController!.reverse()
              : _animationController!.forward(),
        
        // Floating Action button Icon color
        iconColor: Colors.red.shade300,

        // Flaoting Action button Icon 
        iconData: Icons.ac_unit, 
        backGroundColor: Colors.white,
      );
    
  }
}