  import 'package:flutter/material.dart';


  class FTextStyle {
    static TextStyle custom({
      String fontFamily = 'Metropolis-Regular',
      double fontSize = 16,
      Color color = Colors.black,
      FontWeight fontWeight = FontWeight.normal,
    }) {
      return TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      );
    }
  }