import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CommonLoader extends StatelessWidget {


  const CommonLoader({
    Key? key,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 150,
        width: 150,
        child: LoadingIndicator(
          indicatorType: Indicator.orbit,
          colors: const [Color(0xffCB2027),Color(0xff3B5998),Color(0xff5C4CFF),Color(0xffF37B23)], //5C4CFF //F37B23
          strokeWidth: 2,
          backgroundColor: Colors.transparent,
          pathBackgroundColor: Colors.amber,
        ),
      ),
    );
  }
}
