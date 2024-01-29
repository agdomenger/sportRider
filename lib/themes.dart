// lib/themes.dart

import 'package:flutter/material.dart';

final Color fond = Color.fromARGB(240, 240, 250, 252);
final Color rouge = Color.fromARGB(245, 221, 28, 26);
final Color bleu_fonce = Color.fromARGB(240, 8, 103, 136);
final Color bleu_clair = Color.fromARGB(157, 7, 160, 195);
final Color jaune = Color.fromARGB(255, 240, 201, 8);

final ThemeData myTheme = ThemeData(
  primaryColorDark: bleu_fonce,
  primaryColor: fond,
  primaryColorLight: bleu_clair,
  shadowColor: rouge,
  canvasColor: jaune,
  fontFamily: 'Roboto',
);
