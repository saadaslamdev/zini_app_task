import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zini_pay_task/src/core/utils/app_colors.dart';
import 'package:zini_pay_task/src/core/utils/font_manager.dart';
import 'package:zini_pay_task/src/core/utils/styles_manager.dart';

void setLightStatusBarIcons() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
}

ThemeData getAppTheme() {
  setLightStatusBarIcons();

  return ThemeData(
    fontFamily: 'Montserrat',
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
      elevation: 0.0,
      centerTitle: false,
      iconTheme: IconThemeData(color: AppColors.white),
    ),
    textTheme: TextTheme(
      headlineLarge:
          getBlackTitleStyle(fontSize: FontSize.title, color: AppColors.white),
      headlineMedium:
          getBoldStyle(fontSize: FontSize.subTitle, color: AppColors.white),
      titleLarge: getBoldStyle(color: AppColors.white),
      // titleMedium Used in text form field
      titleMedium: getRegularStyle(color: AppColors.black),
      bodyLarge: getMediumStyle(color: AppColors.black),
      bodyMedium: getRegularStyle(color: AppColors.black),
      bodySmall: getLightStyle(color: AppColors.blackWithOpacity),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(color: AppColors.white),
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0.0,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: getRegularStyle(color: AppColors.blackWithOpacity),
      hintStyle: getRegularStyle(color: AppColors.blackWithOpacity),
      errorStyle: getLightStyle(color: AppColors.error),
      filled: true,
      fillColor: const Color(0xFFd3d3d3),
      errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
          borderRadius: BorderRadius.circular(20)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
          borderRadius: BorderRadius.circular(20)),
    ),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: AppColors.primaryColor),
  );
}
