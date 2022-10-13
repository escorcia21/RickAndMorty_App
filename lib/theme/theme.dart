import 'package:flutter/material.dart';
import 'colors.dart';
import 'text_styles.dart';

class MyTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      primarySwatch: AppColors.createMaterialColor(AppColors.primaryColor),
      colorScheme: AppColors.darkScheme,
      toggleableActiveColor: AppColors.darkScheme.secondary,
      // this can all be copied, waiting for verification
      fontFamily: AppTextStyle.fontFamily,
      textTheme: AppTextStyle.textTheme.copyWith(
        bodyText1: AppTextStyle.bodytext1.copyWith(
          color: Colors.white70,
        ),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        titleTextStyle: AppTextStyle.textTheme
            .copyWith(
              headline6: AppTextStyle.headline1.copyWith(
                color: AppColors.darkScheme.primary,
              ),
            )
            .headline6,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        unselectedItemColor: Colors.grey.shade400,
        selectedItemColor: AppColors.darkScheme.primary,
      ),
      // copy from ligthTheme
      inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(),
        fillColor: Colors.grey.shade300,
      ),
      cardTheme: const CardTheme(elevation: 4, clipBehavior: Clip.hardEdge),
    );
  }
}
