import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Config {
 static MediaQueryData _mediaQueryData;
 static double screenWidth;
 static double screenHeight;
 static double screenPadding;
 static double blockSizeVertical;
 static double fontSize;
 static Color appBarColor;
 static Color textColor;
 static Color buttonColor;
 static Color splashColor;
 static Color bottomBarColor;
 
 void init(BuildContext context) {
  _mediaQueryData = MediaQuery.of(context);
  screenWidth = _mediaQueryData.size.width;
  screenHeight = _mediaQueryData.size.height;
  screenPadding = screenWidth / 50;
  blockSizeVertical = screenHeight / 50;
  fontSize=screenHeight/25;
  textColor = Colors.grey[600];
  buttonColor = Colors.orangeAccent;
  splashColor = Colors.orange;
  bottomBarColor = Colors.white;//Colors.lime[300];
  appBarColor= Color.fromRGBO(0, 154, 214, 1);
 }
}