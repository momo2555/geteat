import 'package:flutter/material.dart';

const PrimaryColor = Color(0xFF34BF49);
const PrimaryColorLight = Color.fromARGB(255, 255, 255, 255);
const PrimaryColorDark = Color.fromARGB(255, 28, 28, 28);

const SecondaryColor = const Color(0xFFF2F2F2);
const SecondaryColorLight = const Color(0xFFe5ffff);
const SecondaryColorDark = const Color(0xFF6F6F6F);
const errorColor =  Colors.red;
const Background = Color.fromARGB(255, 0, 0, 0);
const TextColor = Color.fromARGB(255, 255, 255, 255);

class mainTheme {
  static final ThemeData defaultTheme = _buildMyTheme();

  static ThemeData _buildMyTheme() {
    final ThemeData base = ThemeData(fontFamily: 'Poppins');

    return base.copyWith(
      accentColor: SecondaryColor,
      accentColorBrightness: Brightness.dark,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: PrimaryColor,
        onPrimary: PrimaryColorLight,
        secondary: SecondaryColorDark,
        onSecondary: SecondaryColor,
        error: errorColor,
        onError: errorColor,
        background: PrimaryColorDark,
        onBackground: PrimaryColorLight,
        surface: SecondaryColor,
        onSurface: SecondaryColor,
      ),
      primaryColor: PrimaryColor,
      primaryColorDark: PrimaryColorDark,
      primaryColorLight: PrimaryColorLight,
      primaryColorBrightness: Brightness.dark,
      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: SecondaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: Background,
      ),
      floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
        backgroundColor: PrimaryColor,
      ),
      scaffoldBackgroundColor: Background,
      cardColor: Background,
      
      backgroundColor: Background,
      bottomAppBarTheme: base.bottomAppBarTheme.copyWith(
        elevation: 0,
      ),

      /*textTheme: base.textTheme.copyWith(
          titleLarge: base.textTheme.titleLarge?.copyWith(color: TextColor),
          bodyText1: base.textTheme.bodyText1?.copyWith(color: TextColor),
          bodyText2: base.textTheme.bodyText2?.copyWith(color: TextColor)
      ),*/
    );
  }
}
