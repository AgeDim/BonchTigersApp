import 'package:flutter/material.dart';

class CustomButtonStyle {
  ButtonStyle? orangeButton = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFFE4500)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
