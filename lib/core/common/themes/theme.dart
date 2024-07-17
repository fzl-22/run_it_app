import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:run_it_app/core/resources/colours.dart';
import 'package:run_it_app/core/resources/fonts.dart';

class AppTheme {
  static final theme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: Colours.blue500,
      secondary: Colours.gold500,
      error: Colours.error500,
      surface: Colours.grey50,
    ),
    fontFamily: Fonts.poppins,
    useMaterial3: true,
  );

  static const cupertinoTheme = CupertinoThemeData(
    primaryColor: Colours.blue500,
    applyThemeToAll: true,
  );
}
