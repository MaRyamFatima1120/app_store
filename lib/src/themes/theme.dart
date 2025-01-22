import 'package:app_store/src/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'color_scheme.dart';

ThemeData appTheme(BuildContext context,) {
  return ThemeData(
    colorScheme: lightColorScheme,
    textTheme: customTextTheme(context),
    primaryColor:  lightColorScheme.primary ,
    scaffoldBackgroundColor:  lightColorScheme.onPrimary,

  );
}