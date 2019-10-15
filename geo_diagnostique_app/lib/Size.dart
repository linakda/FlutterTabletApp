import 'package:flutter/widgets.dart';

class SizeConfig {
 static MediaQueryData _mediaQueryData;
 static double screenWidth;
 static double screenHeight;
 static double screenPadding;
 static double blockSizeVertical;
 static double fontSize;
 
 void init(BuildContext context) {
  _mediaQueryData = MediaQuery.of(context);
  screenWidth = _mediaQueryData.size.width;
  screenHeight = _mediaQueryData.size.height;
  screenPadding = screenWidth / 50;
  blockSizeVertical = screenHeight / 50;
  fontSize=screenHeight/25;
 }
}