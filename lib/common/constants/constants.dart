import 'package:flutter/material.dart';

const textInputDecoration1 = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.white,
      width: 2.0,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.pink,
      width: 2.0,
    ),
  ),
);

final textInputDecoration = InputDecoration(
  filled: true,
  border: textFormFieldWhiteBorder,
  enabledBorder: textFormFieldWhiteBorder,
  focusedBorder: textFormFieldFocusedBorder,
  errorBorder: textFormFieldErrorBorder,
  errorStyle: textFormFieldErrorMessageStyle,
  hintStyle: textFormFieldHintTextStyle,
  contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
);

final OutlineInputBorder textFormFieldWhiteBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(15.0),
  borderSide: const BorderSide(
    color: Colors.white70,
    width: 2.0,
  ),
);

final OutlineInputBorder textFormFieldFocusedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(15.0),
  borderSide: const BorderSide(
    color: Colors.white,
    width: 2.4,
  ),
);

OutlineInputBorder textFormFieldErrorBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(15.0),
  borderSide: const BorderSide(
    color: Colors.red,
    width: 2.0,
  ),
);

const TextStyle textFormFieldFontStyle = TextStyle(
  color: Colors.white,
);

const textFormFieldHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

const TextStyle textFormFieldErrorMessageStyle = TextStyle(
  fontSize: 14.0,
);

const textFormFieldLabelStyle = TextStyle(
  fontSize: 16,
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

const BoxDecoration backgroundDecoration = BoxDecoration(
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
