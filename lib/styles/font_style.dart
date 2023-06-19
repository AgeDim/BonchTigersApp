import 'package:flutter/material.dart';

class FontStyle {
  //Это константные переменные, не стоит их делать опциональными --> (?)
  TextStyle gray34 = const TextStyle(
    fontFamily: 'Source Sans Pro',
    fontSize: 34,
    color: Color(0xFF3A3A3A),
  );
  TextStyle lightGray20 = const TextStyle(
    fontFamily: 'Source Sans Pro',
    fontSize: 20,
    color: Color(0xFF777777),
  );
  TextStyle darkWhite12 = const TextStyle(
      fontFamily: 'Source Sans Pro', fontSize: 12, color: Color(0xFFA5A5A5));
  TextStyle white16 = const TextStyle(
    fontFamily: 'Source Sans Pro',
    fontSize: 16,
    color: Colors.white,
  );
}
