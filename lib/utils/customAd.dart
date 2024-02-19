import 'package:flutter/material.dart';
import 'package:thedipaar/constants/imageConstants.dart';

class CustomAdPopup extends StatelessWidget {
  const CustomAdPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      content: Container(
        height: 180,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Align(
            //     alignment: Alignment.center,
            //   child: Text('ad content!')),
            Image.asset(AppImages.banner11,fit: BoxFit.cover,),
             Align(
          alignment: Alignment.topRight,
          child: InkWell(
            onTap: (){
                 Navigator.of(context).pop();
            },
            child: Container(
                         
              height: 30,
              width: 30,
                decoration: BoxDecoration(
                  color: Color(0xFFE1E1E1),
                  borderRadius: BorderRadius.circular(
                      15), // Adjust the radius as needed
                  border: Border.all(
                    color:Color(
                                  0xff23527C), // Set the border color here
                    width: 1, // Set the border width here
                  ),
                ),
                child: Align(
                   alignment: Alignment.center,
                  child: Icon(Icons.close,size: 14,),
                )),
          ),
        )
          ],
        ),
      ),
    );
  }
}
