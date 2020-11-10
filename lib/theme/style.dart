import 'package:flutter/material.dart';

const DEATHS_COLOR = Color(0xfff40f4c);
const RECOVERED_COLOR = Color(0xff55aa50);
const CASES_COLOR = Color(0xffefae1d);
var highlight_purple = Colors.deepPurple[700];

ThemeData appTheme() {
  const int _purplePrimaryValue = 0xff2a1c66;
  const BACKGROUND_COLOR = Color(_purplePrimaryValue);

  const MaterialColor primaryPurple = MaterialColor(
    _purplePrimaryValue,
    <int, Color>{
      50: BACKGROUND_COLOR,
      100: BACKGROUND_COLOR,
      200: BACKGROUND_COLOR,
      300: BACKGROUND_COLOR,
      400: BACKGROUND_COLOR,
      500: BACKGROUND_COLOR,
      600: BACKGROUND_COLOR,
      700: BACKGROUND_COLOR,
      800: BACKGROUND_COLOR,
      900: BACKGROUND_COLOR,
    },
  );

  return ThemeData(
    primarySwatch: primaryPurple,
    backgroundColor: primaryPurple,
    primaryColor: primaryPurple,
    accentColor: Colors.grey,
    fontFamily: "Century Gothic",
    iconTheme: IconThemeData(
      color: Colors.grey,
      size: 28.0,
    ),
    textTheme: TextTheme(
      headline5: TextStyle(
          fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.white),
      headline6: TextStyle(fontSize: 13.0, color: Colors.grey),
      headline4: TextStyle(fontSize: 17.0, color: Colors.grey),
      bodyText2: TextStyle(fontSize: 36.0, color: Colors.grey),
    ),
  );
}
