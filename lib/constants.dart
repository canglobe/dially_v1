import 'package:flutter/cupertino.dart';

// when you use ios text
Widget textt(String label, Color color, {String size = '16'}) {
  return Text(
    label,
    style: TextStyle(
      color: color,
      fontSize: double.parse(size),
      fontFamily: 'SF Pro Display',
      fontWeight: FontWeight.w400,
    ),
  );
}

// Color bgcolor = Color.fromARGB(0, 161, 15, 15);
Color pmcolor = Color.fromARGB(255, 34, 34, 34);
Color textcolor = CupertinoColors.destructiveRed;
