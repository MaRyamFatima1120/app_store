import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color_scheme.dart';

TextTheme customTextTheme(BuildContext context){

  return TextTheme(
      bodyLarge: GoogleFonts.playfairDisplay(
          textStyle: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w400,
              color: lightColorScheme.onSecondary
          )
      ),
      bodyMedium: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: lightColorScheme.secondary
          )
      ),
      bodySmall: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: lightColorScheme.onPrimary
          )
      ),
    titleSmall: GoogleFonts.poppins(
        textStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: lightColorScheme.onSecondary
        ),

    )
  );
}