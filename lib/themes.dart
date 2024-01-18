// lib/themes.dart

import 'package:flutter/material.dart';

final Color vertKaki = Color.fromARGB(240, 96, 108, 56);
final Color vertKakiFonce = Color.fromARGB(245, 40, 54, 24);
final Color beige = Color.fromRGBO(254, 250, 224, 1);
final Color marronClair = Color.fromARGB(157, 221, 161, 94);
final Color marronFonce = Color.fromARGB(157, 188, 108, 37);

final ThemeData myTheme = ThemeData(
  primaryColorDark: vertKakiFonce,
  primaryColor: vertKaki,
  primaryColorLight: beige,
  shadowColor: marronClair,
  canvasColor: marronFonce,
  fontFamily: 'Roboto',
);
