import 'package:flutter/material.dart';

const textInputDecoration1 = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white,
      width: 2.0,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.pink,
      width: 2.0,
    ),
  ),
);

final textInputDecoration = InputDecoration(
  fillColor: Color(0xFF6CA8F1),
  filled: true,
  border: textFormFieldWhiteBorder,
  enabledBorder: textFormFieldWhiteBorder,
  focusedBorder: textFormFieldWhiteBorder,
  errorBorder: textFormFieldErrorBorder,
  errorStyle: textFormFieldErrorMessageStyle,
  hintStyle: textFormFieldHintTextStyle,
  contentPadding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
);

final OutlineInputBorder textFormFieldWhiteBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(15.0),
  borderSide: BorderSide(
    color: Colors.white70,
    width: 2.0,
  ),
);

final OutlineInputBorder textFormFieldErrorBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(15.0),
  borderSide: BorderSide(
    color: Colors.red,
    width: 2.0,
  ),
);

final TextStyle textFormFieldFontStyle = TextStyle(
  color: Colors.white,
);

final textFormFieldHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final TextStyle textFormFieldErrorMessageStyle = TextStyle(
  fontSize: 14.0,
);

final textFormFieldLabelStyle = TextStyle(
  fontSize: 16,
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final BoxDecoration backgroundDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF73AEF5),
      Color(0xFF61A4F1),
      Color(0xFF478DE0),
      Color(0xFF398AE5),
    ],
    stops: [0.1, 0.4, 0.7, 0.9],
  ),
);
