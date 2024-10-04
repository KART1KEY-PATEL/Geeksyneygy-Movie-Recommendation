// app_theme.dart
import 'package:flutter/material.dart';
import 'package:geeksynergymovie/utils/color.dart';

ThemeData appTheme(BuildContext context) {
  return ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.primaryButtonColor),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        elevation: WidgetStateProperty.all(5),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      side: BorderSide(color: AppColors.primaryButtonColor, width: 1.0),
      fillColor: WidgetStateProperty.resolveWith((states) => Colors.transparent),
    ),
    scaffoldBackgroundColor: AppColors.primaryColor,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
        .copyWith(primary: AppColors.secondaryColor),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primaryButtonColor,
      textTheme: ButtonTextTheme.primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.textFieldColor,
      hintStyle: TextStyle(
        color: AppColors.greyColor,
        fontSize: MediaQuery.of(context).size.height * 0.02,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide:  BorderSide(width: 0.5, color: AppColors.accentTextColor),
      ),
    ),
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.primaryColor),
    textTheme: const TextTheme(bodyLarge: TextStyle(color: AppColors.whiteTextColor)),
    textSelectionTheme:  TextSelectionThemeData(
      cursorColor: AppColors.accentTextColor,
      selectionColor: Color(0xFF4362FF),
      selectionHandleColor: Color(0xFF4362FF),
    ),
    fontFamily: 'PlusJakartaSans',
    useMaterial3: true,
  );
}