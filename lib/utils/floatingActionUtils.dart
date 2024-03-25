

import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:thedipaar/utils/samplePlugins.dart';
import 'package:thedipaar/view/Directory.dart';




class CircularMenuFAB extends StatefulWidget {
  @override
  _CircularMenuFABState createState() => _CircularMenuFABState();
}

class _CircularMenuFABState extends State<CircularMenuFAB> with SingleTickerProviderStateMixin {
  Color _color = Colors.pink;
  String _colorName = 'Pink';

    Animation<double>? _animation;
  AnimationController? _animationController;
    bool _isDragging = false;
  Offset _position = Offset(0, 0);

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
    return GestureDetector(
              onPanStart: (details) {
          setState(() {
            _isDragging = true;
          });
        },
        onPanUpdate: (details) {
          setState(() {
            _position += details.delta;
          });
        },
        onPanEnd: (details) {
          setState(() {
            _isDragging = false;
          });
        },
      child: FloatingActionBubble(
          // Menu items
          items: <Bubble>[
      
            // Floating action menu item
            Bubble(
              title:"Directory",
              iconColor :Colors.white,
              bubbleColor : Color(0xff23527C),
              icon:Icons.contacts_outlined,
              titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
              onPress: () {
                _animationController!.reverse();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DirectoryScreen()));
              },
            ),
            // Floating action menu item
            // Bubble(
            //   title:"News bits",
            //   iconColor :Colors.white,
            //   bubbleColor : Color(0xff23527C),
            //   icon:Icons.people,
            //   titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
            //   onPress: () {
            //     _animationController!.reverse();
            //   },
            // ),
            //Floating action menu item
            Bubble(
              title:"TV",
              iconColor :Colors.white,
              bubbleColor : Color(0xff23527C),
              icon:Icons.tv,
              titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
              onPress: () {
                // Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => Homepage()));
                _animationController!.reverse();
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewExample(loadUrl: 'http://thedipar.com/tv/',)));
              },
            ),
              Bubble(
              title:"E-Book",
              iconColor :Colors.white,
              bubbleColor : Color(0xff23527C),
              icon:Icons.book_rounded,
              titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
              onPress: () {
                // Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => Homepage()));
                _animationController!.reverse();
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewExample(loadUrl: 'https://ebook.thedipaar.ca/',)));
              },
            ),
              Bubble(
              title:"FM",
              iconColor :Colors.white,
              bubbleColor : Color(0xff23527C),
              icon:Icons.radio,
              titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
              onPress: () {
                // Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => Homepage()));
                _animationController!.reverse();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewExample(loadUrl: 'https://zeno.fm/radio/thedipaar/',)));
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
          iconColor: Color(0xff23527C),
      
          // Flaoting Action button Icon 
          iconData: Icons.ac_unit, 
          backGroundColor: Colors.white,
        ),
    );
    
  }
}