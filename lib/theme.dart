import 'package:flutter/material.dart';
import 'package:humab/constants.dart';

ThemeData themeData() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.grey[100],
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: ColorScheme.fromSwatch(accentColor: kPrimaryColor),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[100],
      foregroundColor: kBlack,
      elevation: 0,
      actionsIconTheme: const IconThemeData(
        color: kBlack,
      ),
      iconTheme: const IconThemeData(color: kBlack),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 20,
      ),
      enabledBorder: underlineBorder(),
      focusedBorder: underlineBorder(),
      disabledBorder: underlineBorder(),
    ),
  );
}

UnderlineInputBorder underlineBorder() => const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFFF0F0F0),
        width: 1,
      ),
    );
