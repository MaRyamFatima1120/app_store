import 'package:flutter/material.dart';

const Color primary = Color(0xff0C0C0C);
const Color onPrimary = Color(0xffF2F2F2);
const Color secondary = Color(0xffFFFFFF);
const Color onSecondary = Color(0xff000000);
const Color surface = Color(0xffEE3C3C);
const Color onSurface = Color(0xffFFC553);
ColorScheme lightColorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: onPrimary,
    secondary: secondary,
    onSecondary: onSecondary,
    error: Colors.red,
    onError: Colors.grey,
    surface: surface,
    onSurface: onSurface);
